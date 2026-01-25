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

only works if `a` is of type `boolean`. If `a` is instead of type `bit` you must express the
condition as `if (a = '1') then`

VHDL is a language full of features for modeling and describing hardware.
Some of its features correspond directly to hardware concepts, while others
are purely software constructs useful for scripting complex hardware.
An example is VHDL `for` loops, where the range of the for loop cannot
depend on the value of signal. The for loop bounds must be entirely
determined by values known at elaboration time (or hardware generation time).

# Comments

In VHDL `--` starts a comment that extends to the end of the line.

Example:
```VHDL
-- This line is a comment
a <= not b;
```

# Case sensitivity

VHDL is not case sensitive for identifiers or keywords.
The following signal declarations will cause an error:

```VHDL
architecture RTL of my_entity is
    signal A : std_logic;
    -- causes an already declared error
    signal a : std_logic;
begin

end RTL;
```

It is perfectly ok to refer to the same entity using
any capitalization of the entity name. For example the following
is ok from a VHDL syntax perspective:

```VHDL
entity an_entity is
end an_entity;

architecture RTL of AN_ENTITY is
begin

end RTL;
```

Consistency and following the pattern used by fellow
HDL engineers is strongly suggested.

Redeclaration with different case across port and local
signal is also an error:

```VHDL
entity my_entity is
   port (A : in std_logic);
end my_entity;

architecture RTL of my_entity is
   -- causes an already declared error
   signal a : std_logic;
begin

end RTL;
```

# Types

## bit

## std_logic

## std_logic_vector

## Declaring types

### Enumeration types

```VHDL
type state is (IDLE, STATE_A, STATE_B);
```


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

# Testbenches

