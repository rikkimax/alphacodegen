### Macro Preprocessor

#### Syntax

- `#define` Identifier Literal
  - Modifies the translation unit
  - Identifier#1 is replaced by Literal#1
- `#undef` Identifier
  - Behaves as `#define` Identifier#1 $empty
- `#ifdef` Identifier
  - Retrives from the translation unit
  - Conditional part of file to parse
- `#else`
  Alternative flow of a conditional statement.

  - Follows from:
    - `#if`
    - `#ifdef`
    - `#elseif`
    - `#elif`
  - Conditional part of file to parse and is always valid
- `#ifndef` Identifier
  If the identifier exists, ignores the given block.

  - Value of Identifier#1 is negated
    Negation can be:
    - $true or $false
    - $value or $empty
  - Behaves as `#ifdef` Identifier#1
