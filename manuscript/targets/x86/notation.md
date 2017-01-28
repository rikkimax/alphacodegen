{pagebreak}

### Notation

#### Mnemonic

- cReg
- dReg
- imm8
- imm16
- imm16/32
- imm32
- imm32/64
- imm64
- mem
- mem8
- mem16
- mem16/32
- mem32
- mem32/48
- mem48
- mem64
- mem128
- mem16:16
- mem16:32
- mem32real
- mem32int
- mem64real
- mem64int
- mem80real
- mem80dec
- mem2env
- mem14/28env
- mem94/108env
- mem512env
- mmx
- mmx1
- mmx2
- mmx/mem32
- mmx/mem64
- mmx1/mem64
- mmx2/mem64
- moffset
- moffset8
- moffset16
- moffset32
- moffset64
- (cw|cd):cw
- reg
- reg8
- reg16/32
- reg32
- reg64
- reg/mem8
- reg/mem16
- reg/mem32
- reg/mem64
- rel8off
- rel16off
- rel32off
- segReg or sReg
- ST(0)
- ST(i)
- xmm
- xmm1
- xmm2
- xmm/mem64
- xmm/mem128
- xmm1/mem128
- xmm2/mem128
- ymm
- ymm1
- ymm2
- ymm/mem64
- ymm/mem128
- ymm1/mem256
- ymm2/mem256

#### Opcode

- /digit

    Uses the ModRM.regmem field and places the digit from the syntax in ModRM.reg.
    ModRM.reg specifies an extension for the opcode and is not a register.
- /r

    Uses the ModRM.reg and ModRM.regmem fields to specify two operands.
- Code offset

	This is the displacement byte offset.
	- cb

		1 byte.
	- cw

		2 bytes.
	- cd

		4 bytes.
	- cp

		6 bytes.
- Immediate value
	- ib

		1 byte.
	- iw

		2 bytes.
	- id

		4 bytes.
	- iq

		8 bytes.
- Byte that specifies register added to byte on left
	- +rb

		1 byte registers.
	- +rw

		2 bytes registers.
	- +rd

		4 bytes registers.
	- +rq

		8 bytes registers.
	- +i

		For x87 floating-point stack operands.
- m64

    Places register into ModRM.regmem for lookup for memory.
    Cannot have ModRM.mod be 11b.
- Pointer with segment

	(cw|cd):cw
	The result is 4 or 6 bytes as cd or cp.