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
   -- Do something if a is true.
end if;
```

only works if `a` is of type `boolean`. If `a` is instead of type `bit` you must express the
condition as `if (a = '1') then`

VHDL is a language full of features for modeling and describing hardware.
Some of its features correspond directly to hardware concepts, while others
are purely software constructs useful for scripting complex hardware.
An example is VHDL `for` loops, where the range of the for loop cannot
depend on the value of a signal. The for loop bounds must be entirely
determined by values known at elaboration time (or hardware generation time).

# Comments

In VHDL `--` starts a comment that extends to the end of the line.

Example:
```VHDL
-- This line is a comment.
a <= not b;
```

# Whitespace

Whitespace is used as a separator between syntactical tokens in
VHDL code. As a separator between two tokens, any whitespace will do.
For example:

```
a <= b;
-- is the same thing as
a
<=
b
;
```

In this pocket reference we sometimes use newline as a token
separator where you normally would use a space in order to fit
the code on these tiny pages.

Whitespace matters in string and bitvector literals though.
Of course "Hello world" is not the same thing as "Helloworld".
If "101 10" is used as a `std_logic_vector` literal it will cause
an error, but if it is used as a string it will be fine.

# Case sensitivity

VHDL is not case sensitive for identifiers or keywords.
The following signal declarations will cause an error:

```VHDL
architecture RTL of my_entity is
    signal A : std_logic;
    -- Causes an already declared error.
    signal a : std_logic;
begin

end RTL;
```

Redeclaration with different case across port and local
signal is also an error:

```VHDL
entity my_entity is
   port (A : in std_logic);
end my_entity;

architecture RTL of my_entity is
   -- Causes an already declared error
   -- because it is declared in port.
   signal a : std_logic;
begin

end RTL;
```


It is perfectly OK to refer to the same entity using
any capitalization of the entity name. For example, the following
is not disallowed by VHDL's syntax rules:

```VHDL
entity an_entity is
end an_entity;

architecture RTL of AN_ENTITY is
begin

end RTL;
```

Consistency and following the pattern used by fellow
HDL engineers is strongly suggested.

# Types

## Built in

The following built in types are always present. No library import is needed.

  - boolean - TRUE, FALSE
  - bit - '0', '1'
  - integer - typically 32-bit signed
  - natural - integer >= 0 (subtype)
  - positive - integer > 0 (subtype)
  - time - for simulation (1 ns, 10 ps, etc.)

The following types come from the `ieee.std_logic_1164` package and
are ubiquitous in designs:

  - std_logic -  'U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-'
  - std_logic_vector - array of std_logic

## Subtypes

A subtype is compatible with its parent type in assignments.
Note that these assignments are allowed in both directions, from
subtype to basetype and from basetype to subtype. In simulation
range checks may find and point out places where an assignment
would be incompatible.

```vhdl
subtype my_i is integer range -128 to 127;

subtype logic is std_logic range 'X' to 'Z';
```

Given the signals:
```vhdl
signal i1 : my_i;
signal i2 : integer;
```

both of the following assignmnents are OK.

```vhdl
i1 <= i2;
i2 <= i1;
```

## Enumeration types

Enumeration types can be used to give descriptive names
to the states of a statemachine for example. The values
of the enumaration type is automatically turned into
bits using an encoding schema.


```VHDL
type state is (IDLE, STATE_A, STATE_B);
```

# Converting between types

# Signals, Variables and constants

# Operators

# Entity

The entity keyword is used to define the interface
of a component. Consider a two-input one-output mux:

```VHDL
entity mux is
   port (a : in std_logic;
         b : in std_logic;
         s : in std_logic;
         y : out std_logic
         );
end mux;
```

Entities may also include generic parameters; see [Generics and Generate](#generics-and-generate).

```VHDL
entity gmux is
    generic (WIDTH : integer := 8                                                    
             );
    port (a : in std_logic_vector
                   (WIDTH-1 downto 0);
          b : in std_logic_vector
                   (WIDTH-1 downto 0);
          s : in std_logic;
          y : out std_logic_vector
                   (WIDTH-1 downto 0)
          );
end gmux;
```

# Architecture

# Process

# Conditionals

# Concurrent Statements

# Generics and Generate

# Attributes

# Libraries

# State Machines

# Testbenches

