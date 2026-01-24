---
title: VHDL Pocket Reference
author: Bo Joel Svensson
---

\newpage

This work is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License** (CC BY-NC-SA 4.0).

You are free to share and adapt this material for non-commercial purposes, provided you give appropriate credit and distribute any derivatives under the same license.

<https://creativecommons.org/licenses/by-nc-sa/4.0/>

\newpage

# High level overview 

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
end if; 
```

only works if `a` is a Boolean, if `a` instead is a bit you must express the
condition as `if (a = '1') then`

VHDL is a language full of features for modeling and describing hardware.
Some of it's features correspond directly to hardware concepts, while others
are purely software constructs useful for scripting  complex hardware.
An example is VHDL `for` loops, where the range of the for loop cannot
depend on the value of singal. The for loop bounds must be entirely
determined by values known at elaboration time (or hardware generation time).

# Comments

In VHDL `--` starts a comment that extends to the end of the line.

Example:
```VHDL
-- This line is a comment
a <= not b;
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





