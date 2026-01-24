#!/bin/bash
# Impose A6 pages onto A4 for cut-stack duplex printing
# Each cut piece will have consecutive pages front/back

set -e

INPUT="$1"
OUTPUT="$2"

if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
    echo "Usage: $0 input.pdf output.pdf"
    exit 1
fi

TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# Get page count
PAGES=$(pdftk "$INPUT" dump_data | grep NumberOfPages | awk '{print $2}')

# Pad to multiple of 8
REMAINDER=$((PAGES % 8))
if [ $REMAINDER -ne 0 ]; then
    PADDED=$((PAGES + 8 - REMAINDER))
else
    PADDED=$PAGES
fi

WORKING_PDF="$INPUT"

# Create padded PDF if needed
if [ $PADDED -gt $PAGES ]; then
    # Create blank A6 page using LaTeX directly
    cat > "$TMPDIR/blank.tex" << 'EOF'
\documentclass{article}
\usepackage[paperwidth=105mm,paperheight=148mm,margin=10mm]{geometry}
\begin{document}
\thispagestyle{empty}
\mbox{}
\end{document}
EOF
    xelatex -output-directory="$TMPDIR" "$TMPDIR/blank.tex" > /dev/null 2>&1

    # Build padding sequence
    PAD_SEQ=""
    for ((i=1; i<=PAGES; i++)); do
        PAD_SEQ="$PAD_SEQ A$i"
    done
    for ((i=PAGES+1; i<=PADDED; i++)); do
        PAD_SEQ="$PAD_SEQ B1"
    done

    pdftk A="$INPUT" B="$TMPDIR/blank.pdf" cat $PAD_SEQ output "$TMPDIR/padded.pdf"
    WORKING_PDF="$TMPDIR/padded.pdf"
fi

# Build page sequence for cut-stack imposition
# For each group of 8 pages:
#   Front sheet: 1,3,5,7 (2x2)
#   Back sheet:  4,2,8,6 (2x2) - ordered for long-edge flip
FRONT_PAGES=""
BACK_PAGES=""

for ((i=1; i<=PADDED; i+=8)); do
    p1=$i
    p2=$((i+1))
    p3=$((i+2))
    p4=$((i+3))
    p5=$((i+4))
    p6=$((i+5))
    p7=$((i+6))
    p8=$((i+7))

    FRONT_PAGES="$FRONT_PAGES $p1 $p3 $p5 $p7"
    BACK_PAGES="$BACK_PAGES $p4 $p2 $p8 $p6"
done

# Create front and back page PDFs
pdftk "$WORKING_PDF" cat $FRONT_PAGES output "$TMPDIR/front.pdf"
pdftk "$WORKING_PDF" cat $BACK_PAGES output "$TMPDIR/back.pdf"

# Impose 2x2
pdfjam --nup 2x2 --paper a4paper --outfile "$TMPDIR/front_a4.pdf" "$TMPDIR/front.pdf"
pdfjam --nup 2x2 --paper a4paper --outfile "$TMPDIR/back_a4.pdf" "$TMPDIR/back.pdf"

# Interleave front and back for duplex printing
pdftk A="$TMPDIR/front_a4.pdf" B="$TMPDIR/back_a4.pdf" shuffle A B output "$OUTPUT"

echo "Created $OUTPUT - print duplex (long-edge flip), then cut into quarters"
