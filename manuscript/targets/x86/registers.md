{pagebreak}

### Registers

When encoding registers straight the below table is used:

| Encode as | 8bit low | 8bit high | 16bit | 32bit | 64bit | low 8 requires REX | Requires 64bit |
|-----------|----------|-----------|-------|-------|-------|--------------------|----------------|
| 0x0       | AL       | AH        | AX    | eAX   | rAX   | No                 | No             |
| 0x3       | BL       | BH        | BX    | eBX   | rBX   | No                 | No             |
| 0x1       | CL       | CH        | CX    | eCX   | rCX   | No                 | No             |
| 0x2       | DL       | DH        | DX    | eDX   | rDX   | No                 | No             |
| 0x6       | SIL      | Invalid   | SI    | eSI   | rSI   | Yes                | No             |
| 0x7       | DIL      | Invalid   | DI    | eDI   | rDI   | Yes                | No             |
| 0x5       | BPL      | Invalid   | BP    | eBP   | rBP   | Yes                | No             |
| 0x4       | SPL      | Invalid   | SP    | eSP   | rSP   | Yes                | No             |
| 0x8       | r8B      | Invalid   | r8W   | r8D   | r8    | No                 | Yes            |
| 0x9       | r9B      | Invalid   | r9W   | r9D   | r9    | No                 | Yes            |
| 0xA       | r10B     | Invalid   | r10W  | r10D  | r10   | No                 | Yes            |
| 0xB       | r11B     | Invalid   | r11W  | r11D  | r11   | No                 | Yes            |
| 0xC       | r12B     | Invalid   | r12W  | r12D  | r12   | No                 | Yes            |
| 0xD       | r13B     | Invalid   | r13W  | r13D  | r13   | No                 | Yes            |
| 0xE       | r14B     | Invalid   | r14W  | r14D  | r14   | No                 | Yes            |
| 0xF       | r15B     | Invalid   | r15W  | r15D  | r15   | No                 | Yes            |

For when encoding using `+rb +rw +rd +rq` there are three tables.
This is utilised for adding directly to the primary opcode.

1. No REX prefix provided
2. REX prefix provided and REX.B is 0
3. REX prefix provided and REX.B is 1

| Encode as | +rb | +rw | +rd | +rq |
|-----------|-----|-----|-----|-----|
| 0x0       | AL  | AX  | EAX | RAX |
| 0x3       | BL  | BX  | EBX | RBX |
| 0x1       | CL  | CX  | ECX | RCX |
| 0x2       | DL  | DX  | EDX | RDX |
| 0x4       | AH  | SP  | ESP | RSP |
| 0x5       | CH  | BP  | EBP | RBP |
| 0x6       | DH  | SI  | ESI | RSI |
| 0x7       | BH  | DI  | EDI | RDI |

| Encode as | +rb | +rw | +rd | +rq |
|-----------|-----|-----|-----|-----|
| 0x0       | AL  | AX  | EAX | RAX |
| 0x3       | BL  | BX  | EBX | RBX |
| 0x1       | CL  | CX  | ECX | RCX |
| 0x2       | DL  | DX  | EDX | RDX |
| 0x4       | SPL | SP  | ESP | RSP |
| 0x5       | BPL | BP  | EBP | RBP |
| 0x6       | SIL | SI  | ESI | RSI |
| 0x7       | DIL | DI  | EDI | RDI |

| Encode as | +rb    | +rw  | +rd  | +rq |
|-----------|--------|------|------|-----|
| 0x0       | r8B    | r8W  | r8D  | r8  |
| 0x3       | r9B    | r9W  | r9D  | r9  |
| 0x1       | r10B   | r10W | r10D | r10 |
| 0x2       | r11B   | r11W | r11D | r11 |
| 0x4       | r12B   | r12W | r12D | r12 |
| 0x5       | r13B   | r13W | r13D | r13 |
| 0x6       | r14B   | r14W | r14D | r14 |
| 0x7       | r15B   | r15W | r15D | r15 |

This page is used to generate register encoding for x86_64.
It can of course be used to help explain errors in an assembler/disassembler, however this is a secondary objective.

Normally the rBX family of registers is reserved for usage by a compiler and not for an assembly developer to use.