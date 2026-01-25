# Makefile for VHDL Pocket Reference
# Converts markdown to pocket-sized PDF (A6 format: 105mm x 148mm)

SRC = pocket_ref.md
OUTPUT = pocket_ref.pdf
OUTPUT_A4 = pocket_ref_a4.pdf

# A6 paper size for pocket reference
PAPER_WIDTH = 105mm
PAPER_HEIGHT = 148mm
MARGIN = 10mm

# Pandoc options for pocket-sized PDF
PANDOC_OPTS = \
	--pdf-engine=xelatex \
	-V geometry:paperwidth=$(PAPER_WIDTH) \
	-V geometry:paperheight=$(PAPER_HEIGHT) \
	-V geometry:margin=$(MARGIN) \
	-V geometry:footskip=8mm \
	-V fontsize=9pt \
	-V documentclass=article \
	-H header.tex \
	--toc \
	--toc-depth=2

.PHONY: all clean a4

all: $(OUTPUT)

# A6 pocket-sized PDF
$(OUTPUT): $(SRC)
	pandoc $(PANDOC_OPTS) -o $@ $<

# A4 with 4 pocket pages per side, imposed for cut-stack duplex printing
a4: $(OUTPUT_A4)

$(OUTPUT_A4): $(OUTPUT) impose.sh
	./impose.sh $< $@

clean:
	rm -f $(OUTPUT) $(OUTPUT_A4)
