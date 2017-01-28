{pagebreak}

#### Logical AND

##### Variations

| Mnemonic             | Opcode   | Valid/Requires 64bit? | Description |
|----------------------|----------|-----------------------|-------------|
| AND AL, imm8         | 24 ib    | Valid                 | *and* the contents of AL with an immediate 8-bit value and store the result in AL |
| AND AX, imm16        | 25 iw    | Valid                 | *and* the contents of AX with an immediate 16-bit value and store the result in AX |
| AND EAX, imm32       | 25 id    | Valid                 | *and* the contents of EAX with an immediate 32-bit value and store the result in EAX |
| AND RAX, imm32       | 25 id    | Requires              | *and* the contents of RAX with a sign-extended immediate 32-bit value and store the result in RAX |
| AND reg/mem8, imm8   | 80 /4 ib | Valid                 | *and* the contents of reg/mem8 with imm8 |
| AND reg/mem16, imm16 | 81 /4 iw | Valid                 | *and* the contents of reg/mem16 with imm16 |
| AND reg/mem32, imm32 | 81 /4 id | Valid                 | *and* the contents of reg/mem32 with imm32 |
| AND reg/mem64, imm32 | 81 /4 id | Requires              | *and* the contents of reg/mem64 with imm32 |
| AND reg/mem16, imm8  | 83 /4 ib | Valid                 | *and* the contents of reg/mem16 with a sign-extended 8-bit value |
| AND reg/mem32, imm8  | 83 /4 ib | Valid                 | *and* the contents of reg/mem32 with a sign-extended 8-bit value |
| AND reg/mem64, imm8  | 83 /4 ib | Requires              | *and* the contents of reg/mem64 with a sign-extended 8-bit value |
| AND reg/mem8, reg8   | 20 /r    | Valid                 | *and* the contents of an 8-bit register or memory location with the contents of an 8-bit register |
| AND reg/mem16, reg16 | 21 /r    | Valid                 | *and* the contents of a 16-bit register or memory location with the contents of a 16-bit register |
| AND reg/mem32, reg32 | 21 /r    | Valid                 | *and* the contents of a 32-bit register or memory location with the contents of a 32-bit register |
| AND reg/mem64, reg64 | 32 /r    | Requires              | *and* the contents of a 64-bit register or memory location with the contents of a 64-bit register |
| AND reg8, reg/mem8   | 22 /r    | Valid                 | *and* the contents of an 8-bit register with the contents of a 8-bit memory location or register |
| AND reg16, reg/mem16 | 23 /r    | Valid                 | *and* the contents of a 16-bit register with the contents of a 16-bit memory location or register |
| AND reg32, reg/mem32 | 23 /r    | Valid                 | *and* the contents of a 32-bit register with the contents of a 32-bit memory location or register |
| AND reg64, reg/mem64 | 23 /r    | Requires              | *and* the contents of a 64-bit register with the contents of a 64-bit memory location or register |