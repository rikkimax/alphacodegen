{pagebreak}

### Encoding addresses and operand sizes {#X86EncodingSizes}

For encoding sizes (address + operand) there are three tables that determine it.

1. Real mode or virtual 8086 mode
2. Protected mode or long compatibility mode
3. Long 64bit mode

| CS.d    | REX.W   | Operand Prefix | Address Prefix | Operand Size | Address Size |
|---------|---------|----------------|----------------|--------------|--------------|
| Ignored | Ignored | No             | No             | 16           | 16           |
| Ignored | Ignored | No             | Yes            | 16           | 32           |
| Ignored | Ignored | Yes            | No             | 32           | 16           |
| Ignored | Ignored | Yes            | Yes            | 32           | 32           |

| CS.d | REX.W   | Operand Prefix | Address Prefix | Operand Size | Address Size |
|------|---------|----------------|----------------|--------------|--------------|
| 0    | Ignored | No             | No             | 16           | 16           |
| 0    | Ignored | No             | Yes            | 16           | 32           |
| 0    | Ignored | Yes            | No             | 32           | 16           |
| 0    | Ignored | Yes            | Yes            | 32           | 32           |
| 1    | Ignored | No             | No             | 32           | 32           |
| 1    | Ignored | No             | Yes            | 32           | 16           |
| 1    | Ignored | Yes            | No             | 16           | 32           |
| 1    | Ignored | Yes            | Yes            | 16           | 16           |

| CS.d    | REX.W | Operand Prefix | Address Prefix | Operand Size | Address Size |
|---------|-------|----------------|----------------|--------------|--------------|
| Ignored | 0     | No             | No             | 32           | 64           |
| Ignored | 0     | No             | Yes            | 32           | 32           |
| Ignored | 0     | Yes            | No             | 16           | 64           |
| Ignored | 0     | Yes            | Yes            | 16           | 32           |
| Ignored | 1     | Ignored        | No             | 64           | 64           |
| Ignored | 1     | Ignored        | Yes            | 64           | 32           |

Some instructions default to and even fixed at 64bit operands and hence do not require a REX prefix.

- Call (near)
- Enter
- Jcc
- JrCXZ
- JMP (near)
- Leave
- LGDT
- LIDT
- LLDT
- LOOP
- LOOPcc
- LTR
- MOV
	- CRn
	- DRn
- POP
	- reg/mem
	- reg
	- FS
	- GS
- POPF
- POPFD
- POPFQ
- PUSH
	- imm8
	- imm32
	- reg/mem
	- reg
	- FS
	- GS
- PUSHF
- PUSHFD
- PUSHFQ
- RET (near)