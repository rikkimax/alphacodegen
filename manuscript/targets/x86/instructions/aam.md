{pagebreak}

#### ASCII Adjust After Multiply

##### Variations

| Mnemonic | Opcode | Valid/Requires 64bit? | Description |
|----------|--------|-----------------------|-------------|
| AAM      | D4 0A  | No                    | Create a pair of unpacked BCD values in AH and AL |
| AAM imm8 | D4 ib  | No                    | Create a pair of unpacked values to the immediate byte base |

##### Encoding

```lua
if mnemonic == "aam" then
    dst:put(0xD4)

    if #args == 0 then
        dst:put(0x0A)
    else
        dst:put(args[1].value)
    end
end
```

##### Decoding

```lua
if B1 == 0xD4 then
    return {mnemonic="aam", args={[1]={value=src:moveFront()}}}
end
```