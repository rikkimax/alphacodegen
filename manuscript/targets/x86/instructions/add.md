{pagebreak}

#### Signed or Unsigned Add

##### Variations

| Mnemonic             | Opcode   | Valid/Requires 64bit? | Description |
|----------------------|----------|-----------------------|-------------|
| ADD AL, imm8         | 04 ib    | Valid                 | Add imm8 to AL |
| ADD AX, imm16        | 05 iw    | Valid                 | Add imm16 to AX |
| ADD EAX, imm32       | 05 id    | Valid                 | Add imm32 to EAX |
| ADD RAX, imm32       | 05 id    | Requires              | Add sign-extended imm32 to RAX |
| ADD reg/mem8, imm8   | 80 /0 ib | Valid                 | Add imm8 to reg/mem8 |
| ADD reg/mem16, imm16 | 81 /0 iw | Valid                 | Add imm16 to reg/mem16 |
| ADD reg/mem32, imm32 | 81 /0 id | Valid                 | Add imm32 to reg/mem32 |
| ADD reg/mem64, imm32 | 81 /0 id | Requires              | Add sign-extended imm32 to reg/mem64 |
| ADD reg/mem16, imm8  | 83 /0 ib | Valid                 | Add sign-extended imm8 to reg/mem16 |
| ADD reg/mem32, imm8  | 83 /0 ib | Valid                 | Add sign-extended imm8 reg/mem32 |
| ADD reg/mem64, imm8  | 83 /0 ib | Requires              | Add sign-extended imm8 to reg/mem64 |
| ADD reg/mem8, reg8   | 00 /r    | Valid                 | Add reg8 to reg/mem8                |
| ADD reg/mem16, reg16 | 01 /r    | Valid                 | Add reg16 to reg/mem16 |
| ADD reg/mem32, reg32 | 01 /r    | Valid                 | Add reg32 to reg/mem32 |
| ADD reg/mem64, reg64 | 01 /r    | Requires              | Add reg64 to reg/mem64 |
| ADD reg8, reg/mem8   | 02 /r    | Valid                 | Add reg/mem8 to reg8 |
| ADD reg16, reg/mem16 | 03 /r    | Valid                 | Add reg/mem16 to reg16 |
| ADD reg32, reg/mem32 | 03 /r    | Valid                 | Add reg/mem32 to reg32 |
| ADD reg64, reg/mem64 | 03 /r    | Requires              | Add reg/mem64 to reg64 |
