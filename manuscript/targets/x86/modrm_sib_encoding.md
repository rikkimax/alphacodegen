{pagebreak}

### ModRM/SIB encoding

Below is the structure of the ModRM byte:

| 7, 6 | 5, 4, 3 | 2, 1, 0 |
|------|---------|---------|
| Mod  | Reg     | Reg/Mem |

The Reg field can be reused to extend the opcode. This is specified in the opcode syntax of /digit.

The prefix REX.R, VEX.~R or XOP.~R can extend the Reg field into 4 bits by using .R as the most significant bit.
The prefix REX.B, VEX.~B or XOP.~B can extend the Reg/Mem field into 4 bits by using .B as the most significant bit.

Below is the structure of the SIB byte:

| 7, 6  | 5, 4, 3 | 2, 1, 0 |
|-------|---------|---------|
| Scale | Index   | Base    |

Index and Base are registers which contain the value.
The prefix REX.X, VEX.~X, XOP.~X can extend the Index field into 4 bits by using .X as the most significant bit.
The prefix REX.B, VEX.~B, XOP.~B can extend the Base field into 4 bits by using .B as the most significant bit.

```
effective_address = ([index] * scale) + [base] + displacement
```

Where offset is the displacement (immediate value), scale is where e.g. the data elements size would go for an array, index is the starting element in the array and base is the root/first element.

Scale has the following values:

| Encoded value | scale factor |
|---------------|--------------|
| 00            | 1            |
| 01            | 2            |
| 10            | 4            |
| 11            | 8            |

{pagebreak}

#### Addressing mode

Different addressing mode (16 vs 32/64) changes the displacement based upon the ModRM.Mod field.
With the ModRM.mod of 11b, then the value is in a register not in memory.
In 16bit mode no SIB byte is possible.

| Address Mode | Mod | Displacement Length |
|--------------|-----|---------------------|
| 16           | 00  | Invalid             |
| 16           | 01  | 1                   |
| 16           | 10  | 2                   |
| 16           | 11  | Invalid             |
| 32/64        | 00  | Invalid             |
| 32/64        | 01  | 1                   |
| 32/64        | 10  | 4                   |
| 32/64        | 11  | Invalid             |

Special cases are listed below:

The below table does not use the SIB byte.

| Address Mode | ModRM.regmem | ModRM.mod | Displacement Length | Displacement calculation |
|--------------|--------------|-----------|---------------------|--------------------------|
| 16           | 110          | 00        | 2                   | ``disp16``               |
| 32           | 101          | 00        | 4                   | ``disp32``               |
| 64           | 101          | 00        | 4                   | ``RIP + disp32`` or ``EIP + disp32`` for 32bit addresses |

When trying to encode ``[EBP]`` as an operand, assemblers rewrite it as ``[EBP+0]`` as it is reused to mean ``disp16`` for 16bit, ``disp32`` for 32bit and for 64bit ``RIP + disp32``.

The below two table uses the SIB byte.

| Address Mode | ModRM.regmem | ModRM.mod | Displacement Length |
|--------------|--------------|-----------|---------------------|
| 32/64        | 100          | 00        | Invalid             |
| 32/64        | 100          | 01        | 1                   |
| 32/64        | 100          | 10        | 4                   |

The below table has SIB.base = 101 and SIB.index = 100.

| Address Mode | ModRM.regmem | ModRM.mod | Displacement Length | Displacement calculation |
|--------------|--------------|-----------|---------------------|--------------------------|
| 32/64        | 100          | 00        | 4                   | ``disp32``               |
| 32/64        | 100          | 01        | 1                   | ``[*BP] + disp8``        |
| 32/64        | 100          | 10        | 4                   | ``[*BP] + disp32``       |

When SIB.index = 100 means the index field is not used (*SP cannot be used).
