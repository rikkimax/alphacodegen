{pagebreak}

#### ASCII Adjust After Subtraction

##### Variations

| Mnemonic | Primary Opcode | Valid/Requires 64bit? | Description |
|----------|----------------|-----------------------|-------------|
| AAS      | 3F             | No                    | Create an unpackaged BCD number from the contents of teh AL register |

##### Encoding

```lua
if mnemonic == "aas" then
    dst:put(0x3F)
end
```

##### Decoding

```lua
if B1 == 0x3F then
    return {mnemonic="aas"}
end
```