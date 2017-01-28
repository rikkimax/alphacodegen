{pagebreak}

### Encoding considerations

The x86 standard is considered incredibly complex and hard to encode. The following information describes this process.

#### Prefixes

There are two kinds of prefixes, 'base' which contains all the legacy ones and VEX/XOP.

- Operand size override (16/32 bit, for 64bit use REX)

  Alters how many bytes the operand data is
- Address size override

  Modifies the address size based upon the tables under [Encoding addresses and operand sizes](#X86EncodingSizes).
- Segment override

  Specifies a segment to lookup a memory address from. Invalid in long mode.
- Lock
- Repeat

  Repeats until criteria is meet.

    Uses the CX/ECX/RCX to determine how long to go for (max time).

	- Rep(e/z)

	  Repeat until equal.
	- Repn(e/z)

	  Repeat until not equal.
- REX

  The REX prefix allows for extending instructions to use the long mode only registers (r8*-r15*).
  If this is not provided in long mode, the default is 32bit registers. It is valid to mix 16 and 32bit while in long mode.
  - REX.B if 1:

    Expands base field in either ModRM or SIB.
  	The conventional usage is for a source operand, makes the r8*-r15* registers instead of *AX-*DI used.
  - REX.X

  	Expands index field in SIB prefix
  - REX.R if 1:

  	Expands reg field in ModRM.

  	The conventional usage is for a destination operand, makes the r8*-r15* registers instead of *AX-*DI used.
  - REX.W if 1:

  	Uses the 64bit variation of the registers used in operands
- VEX/XOP

  VEX has two forms, the two byte and the three byte.
  The three byte form is the same as XOP only with a different constant.

  The VEX (not for XOP) three byte form can be changed into a two byte if the address map is 1 with X, B are 1 and W is 0.

#### Misc

When encoding a negative displacement, when negative minice 1 and invert adding one.
So it ends up being ``(typeof(value).max - value) + 1``.