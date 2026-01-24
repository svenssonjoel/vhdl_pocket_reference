

\newpage

# High level overview <!-- No more than a page -->

VHDL is a strongly typed Hardware Description Language (HDL).
The VHDL acronym stands for VHSIC Hardware Description Language,
which contains the acronym VHSIC which stands for Very High Speed Integrated
Circuits.

That VHDL is strongly typed means that assignment LHS and RHS must be compatible
according to the type system (think of them as "the same"). Another place
where the strong typing becomes apparent is in conditionals where: 

```VHDL
if a then
   -- do something if a is true
endif 
```

only works if `a` is a Boolean, if `a` instead is a bit you must express the
condition as `if (a = '1') then`

# Comments

In VHDL `--` starts a comment that extends to the end of the line.

Example:
```VHDL
-- This line is a comment
a <= not b
```

  

# Types

# Signals, Variables and constants  

# Operators 

# Entity and Component 

# Architectures

# Processes

# Conditionals

# Concurrent Statements

# Generics and Generate

# Attributes

# Libraries 

# State Machines





