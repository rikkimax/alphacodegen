{pagebreak}

#### ASCII Adjust Before Division

##### Variations

| Mnemonic | Opcode | Valid/Requires 64bit? | Description |
|----------|--------|-----------------------|-------------|
| AAD      | D5 0A  | No                    | Adjust two BCD digits in AL and AH |
| AAD imm8 | D5 ib  | No                    | Adjust two BCD digits to the immediate byte base |

##### Encoding

```lua
if mnemonic == "aad" then
    dst:put(0xD5)

    if #args == 0 then
        dst:put(0x0A)
    else
        dst:put(args[1].value)
    end
end
```

##### Decoding

```lua
if B1 == 0xD5 then
    return {mnemonic="aad", args={[1]={value=src:moveFront()}}}
end
```