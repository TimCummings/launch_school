
# Code Style - 10/20/2020

## Names

* variable, function, and property names: `camelCase`
* constants: capitalized ok; `SCREAMING_SNAKE_CASE` best
* constructor functions: `PascalCase` (capitalized `camelCase`)
* avoid **magic numbers** - give variables/constants descriptive names

## Formatting

* indent with two spaces (never tabs)
* with multi-line blocks,
  * the opening `{` should be on the first line with the initial statement
  * the closing `}` should be on its own line
* terminate statements with semicolons, even though they're optional, to prevent bugs
* use spaces to avoid confusion between keywords, operators, and function calls:
  * with `if`, `for`, and `while` between keyword and `(` and between `)` and `{`
  * around operators and `=`
* use one `let` per variable
