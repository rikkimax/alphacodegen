{pagebreak}

#### ASCII Adjust After Addition

##### Variations

| Mnemonic | Opcode | Valid/Requires 64bit? | Description |
|----------|--------|-----------------------|-------------|
| AAA      | 37     | No                    | Create an unpacked BCD number |

##### Encoding

```lua
if mnemonic == "aaa" then
    dst:put(0x37)
end
```

##### Decoding

```lua
if B1 == 0x37 then
    return {mnemonic="aaa"}
end
```