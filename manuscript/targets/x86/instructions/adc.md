{pagebreak}

#### Add with Carry

##### Variations

| Mnemonic             | Opcode   | Valid/Requires 64bit? | Description |
|----------------------|----------|-----------------------|-------------|
| ADC AL, imm8         | 14 ib    | Valid                 | Add imm8 to AL + CF |
| ADC AX, imm16        | 15 iw    | Valid                 | Add imm16 to AX + CF |
| ADC EAX, imm32       | 15 id    | Valid                 | Add imm32 to AL + CF |
| ADC RAX, imm32       | 15 id    | Requires              | Add sign-extended imm32 to RAX + CF |
| ADC reg/mem8, imm8   | 80 /2 ib | Valid                 | Add imm8 to reg/mem8 + CF |
| ADC reg/mem16, imm16 | 81 /2 iw | Valid                 | Add imm16 to reg/mem16 + CF |
| ADC reg/mem32, imm32 | 81 /2 id | Valid                 | Add imm32 to reg/mem32 + CF |
| ADC reg/mem64, imm32 | 81 /2 id | Requires              | Add sign-extended imm32 to reg/mem64 + CF |
| ADC reg/mem16, imm8  | 83 /2 ib | Valid                 | Add sign-extended imm8 to reg/mem16 + CF |
| ADC reg/mem32, imm8  | 83 /2 ib | Valid                 | Add sign-extended imm8 to reg/mem32 + CF |
| ADC reg/mem64, imm8  | 83 /2 ib | Requires              | Add sign-extended imm8 to reg/mem64 + CF |
| ADC reg/mem8, reg8   | 10 /r    | Valid                 | Add reg8 to reg/mem8 + CF |
| ADC reg/mem16, reg16 | 11 /r    | Valid                 | Add reg16 to reg/mem16 + CF |
| ADC reg/mem32, reg32 | 11 /r    | Valid                 | Add reg32 to reg/mem32 + CF |
| ADC reg/mem64, reg64 | 11 /r    | Requires              | Add reg64 to reg/mem64 + CF |
| ADC reg8, reg/mem8   | 12 /r    | Valid                 | Add reg/mem8 to reg8 + CF |
| ADC reg16, reg/mem16 | 13 /r    | Valid                 | Add reg/mem16 to reg16 + CF |
| ADC reg32, reg/mem32 | 13 /r    | Valid                 | Add reg/mem32 to reg32 + CF |
| ADC reg64, reg/mem64 | 13 /r    | Requires              | Add reg/mem64 to reg64 + CF |

##### Encoding

```lua
if mnemonic == "adc" then
    if #args == 2 then
        if not args[2].haveValue then
            error("")
        elseif args[1].haveRegister then
            if args[1].register == "RAX" then
                dst:put(0x48)
                dst:put(0x15)
                dst:put(args[2].value)
            elseif args[2].size == 1 then
                if not args[1].register == "AL" then
                    error("")
                end

                dst:put(0x14)
                dst:put(args[2].value)
            elseif args[2].size == 2 then
                if not args[1].register == "AX" then
                    error("")
                end

                dst:put(0x15)
                dst:put(args[2].value)
            elseif args[2].size == 4 then
                if not args[1].register == "EAX" then
                    error("")
                end

                dst:put(0x15)
                dst:put(args[2].value)
            else
                error("")
            end
        end
    else
        error("")
    end
end
```

##### Decoding

```lua
if B1 == 0x14 then
    return {mnemonic="adc", args={[1] = {haveRegister=true, register="AL"}} }
elseif B1 == 0x15 then
    local rArch = env.targetArch


end
```