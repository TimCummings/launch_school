
[comment]: # (day_05.md)

# Advent of Code 2020

## Day 5 - Binary Boarding - 12/5/2020

### Part 1

You board your plane only to discover a new problem: you dropped your boarding pass! You aren't sure which seat is yours, and all of the flight attendants are busy with the flood of people that suddenly made it through passport control.

You write a quick program to use your phone's camera to scan all of the nearby boarding passes (your puzzle input); perhaps you can find your seat through process of elimination.

Instead of [zones or groups](https://www.youtube.com/watch?v=oAHbLRjF0vo), this airline uses **binary space partitioning** to seat people. A seat might be specified like `FBFBBFFRLR`, where `F` means "front", `B` means "back", `L` means "left", and `R` means "right".

The first 7 characters will either be `F` or `B`; these specify exactly one of the `128` rows on the plane (numbered `0` through `127`). Each letter tells you which half of a region the given seat is in. Start with the whole list of rows; the first letter indicates whether the seat is in the **front** (`0` through `63`) or the **back** (`64` through `127`). The next letter indicates which half of that region the seat is in, and so on until you're left with exactly one row.

For example, consider just the first seven characters of `FBFBBFFRLR`:

* Start by considering the whole range, rows `0` through `127`.
* `F` means to take the lower half, keeping rows `0` through `63`.
* `B` means to take the upper half, keeping rows `32` through `63`.
* `F` means to take the lower half, keeping rows `32` through `47`.
* `B` means to take the upper half, keeping rows `40` through `47`.
* `B` keeps rows `44` through `47`.
* `F` keeps rows `44` through `45`.
* The final `F` keeps the lower of the two, row `44`.

The last three characters will be either `L` or `R`; these specify exactly one of the **8 columns** of seats on the plane (numbered `0` through `7`). The same process as above proceeds again, this time with only three steps. L means to keep the lower half, while R means to keep the upper half.

For example, consider just the last 3 characters of `FBFBBFFRLR`:

* Start by considering the whole range, columns 0 through 7.
* `R` means to take the upper half, keeping columns `4` through `7`.
* `L` means to take the lower half, keeping columns `4` through `5`.
* The final `R` keeps the upper of the two, column `5`.

So, decoding `FBFBBFFRLR` reveals that it is the seat at row `44`, column `5`.

Every seat also has a unique **seat ID**: multiply the row by 8, then add the column. In this example, the seat has ID `44 * 8 + 5 = 357`.

Here are some other boarding passes:

* `BFFFBBFRRR`: row `70`, column `7`, seat ID `567`.
* `FFFBBBFRRR`: row `14`, column `7`, seat ID `119`.
* `BBFFBBFRLL`: row `102`, column `4`, seat ID `820`.

As a sanity check, look through your list of boarding passes. **What is the highest seat ID on a boarding pass?**

To begin, get your puzzle input:

```
BFBFBBBRLL
BFFBBBBRRR
FFBBFBFLLL
FFBBBBBRLR
BFFBFBFRRL
BFFBFFBRLL
FBBFBFBRLL
FFBFFBBLLR
BFBBBFFRRR
FBFFFFBLLL
FFFFFFBRRR
FBBFBFFRRR
FFBBBBFRLL
BFFBBFBLRR
BFFFFBFRRL
FFFFFBFRLL
FBFFBFFRRR
BFBFBBBLLR
FBFFBBBLRR
FBBBBBFRLR
FFBFFBBRLR
FBBFFFFRRL
FFFFFBBRRL
FFBBFBFRLL
BFFBBBBLLL
FFFFBFFRRL
FBBFFFFLLR
FFBBBBBLLR
FBFBBFBRRR
FBFFBBFRRL
BFBFBFBRLL
BFFBBBBLLR
FBBBBFFLLR
FFBFBBFRLL
BBFFFFBRRL
FBFFFBBLLL
FFFFBBBLLR
FFBBFFFRLL
BFBFFBBRLL
FFBBBFBLLR
FFBBFFFRRR
BFFFBBBRLL
FBFBBFFRLR
FBBFBBBRRR
FBBBBBBRRR
BFFBFFFRRR
BFFBBBFLLL
BFBFFFBLLL
BFFBFBFLLR
FBFFFFBLRL
BFFBBFFLRR
BFBFBFFLLL
BBFFFBFLRL
BFFFBBBLLL
FFBBBBBLLL
BFFFFFFRLL
FFBBBBBLRL
FBFBBBBLLR
FFBBFBBLRL
FBBFBFBLRL
FBBFBBBLRR
BFFBFBBRRR
BFFBBFFLRL
FBFBBFFLLR
BFBBBFFLRR
FBBBFFBLRL
FBFBBBBRLL
FFFFBFFLLL
BBFFFBFRRR
BFBFBBFLRR
FBBFBFFLLL
FBBBBFBRRR
FFFFBBFRRR
FBBFFBFLLL
FBBBFFBRRR
BFFBBBBLRL
FFFFBFBRLL
FBBFFFBRRR
FBFBBFFRLL
BFFFFBFRRR
FFBBBFFLRR
FBBFBBFLLR
BBFFFFBRRR
BFFBFBFLLL
FFFBBBFLLR
FFBFFBFLRL
FFBFBBBLRL
FBFFFBBRRL
BFFBFBBLLR
BFBBFBBRLR
BFBBFFFRRL
FBFBFFFLLR
FFBBBFFLLR
BFBBBFFLLR
BFBFBFBLLR
BBFFFBFLLL
FFBBFBFRRR
BFFFBBFRRR
FBFFBBFRLR
BFBBBBFRLL
BBFFFFBLLR
FFFBFBBLLR
FBFFBFBRRR
FFBFBFBRRR
FFFFFBBRLL
BFFFFBFLLR
FBBFBBFLRR
FBFFFFFRRL
FBBFBFBLLR
BFFFFBBLLL
FBBBBBFLLL
FBBFFBFRRR
BBFFBFBLRL
BFFFBFFRRL
BFFFFFBLLR
FFFBBFBRLR
FBFFBFFRLR
BFBFBFFLLR
BFFFBBFLRL
FFFFBFFLLR
BFFBFFFRLR
FBFBFBFLRR
FBBBBBBRLR
BFBFBFFLRL
BFFFBFBLLR
BBFFBFFLLR
BFFBBBBLRR
FFFBBFFRRR
FBBFBBBLRL
FFBBBFBRLR
FBBBFBFRLR
FBBBBFFLRL
FFBFBFFRLR
BBFFFFFLRL
FFFBBBBLRL
FBFBBBFLRL
BFFBFFFRRL
FFBFFBFRLR
FBFBFFFLRR
FBFBFFBRRL
FBFBBBBLRL
BFBBBBBLLL
BBFFFFBLRR
BFFFBFFLRR
FBBBBBFRRR
FBFFBBBLRL
BBFFFBBRLL
BFBFBFBRRR
BFFBFBBLRR
FFBBFBBRLL
FFFFFBBRLR
BFFFBFBRRL
FFFBFBBLLL
FFFFBFBRRR
FBBFFBBLRR
BFFFFBBLRR
FFBFFFBLRL
FFBFBFBLRR
FBBBBFFRRR
FBFFBFBLRL
BFBFFBBLLL
FBBFFFFLLL
FBBFFBBLLR
FFBFBFFRLL
FBFBBBFRRR
BFFFBFFRLL
FFBFBFBRLL
FFBBFBFLRL
FFBBFBBLLR
FBFBBFBLRL
BBFFFFFRRR
FBBFFBBLRL
BFBFFBBLLR
FFFFFBBLLL
FFBBBBFRRL
FFBBFFFLLL
FFFBFFBRLL
FFBFBBFLLR
BFFFBBBRLR
FBFFBBFRRR
FBBFFFFRLL
FFFBBBFRLR
FFBBFFBRRR
BFBFFFFLRR
BBFFBBFLLR
BFFBFFBLRL
BBFFBFFLRR
FFFBFFBRRR
BFFFBBBLRR
BFBFFBFRLR
FFFBFFFRRR
FFBFBBBRLR
BFBFBBFRLR
BBFFBFFRRL
BFBFBFFRLR
FBBFFFFRLR
FBFBFBBRLL
FFBBBFBRLL
FFBFFFFRRR
BFFBFBBLRL
FFFBFBFRLR
FBBFFFBLRL
FFBFFFFLRL
BBFFBBFRLL
FFFFFFBRRL
BFFBFFBLRR
BFFFFFFRRL
BFFBBFBLRL
FBBFFFFLRL
FFFBBFFRLR
BFBBFFFRLR
FFBBFBBLRR
FFBFBBBLLR
FFBBBBFLRR
FFBFBFFLLL
FFFBFFFLLL
FFBFBFFLRL
BFBFFFBLRL
FBFFFFFLRR
BFBBBBFRRR
FBBFBBFLLL
FFFBBFFLLR
FFBFBBBLLL
BBFFBFFLLL
FBFFBFBRLR
BFBBBBFLRR
FBBBFBFRRL
BFFBBBBRRL
BFBBFFFLLL
BFBBFBFRRR
BFFBFBBLLL
FBBBBBFRRL
FFFBFBFRRL
FFBBBBFLLL
FBBFBBBLLL
FBFFBFFLLR
BFBBBBBLRR
FBFFFFFLLL
BFFFBBBRRL
FBFFFBBRLL
BFBBFBBLRR
FBBBFBBRLR
BBFFBFBLLR
BBFFFFBRLL
BFBBFBFLLR
FBBFFBFLRL
BBFFFBFRRL
BFFFBBBLRL
FBBBBFBRRL
BFBFBFBRRL
FFBFFBBRRR
FBBFFBBLLL
BFFBFFFRLL
FFFFBFFRLR
FFBFFBBRLL
FBBBFFFLRL
FFBFBFBRRL
BFBBBFFLLL
FBBBBFBLLL
FFFBBBBLRR
FBFFFFBRLR
FFBBBBFLRL
BFBBBBFRRL
FFFFBBFLLL
BFFFBBBLLR
FFFBBBBRRL
FBBBFBFLLL
BFFFFFBLRL
FFFBFBBRRL
BFFBBFBRLL
FBFBBFBLRR
FBBBFFFLLL
BFBFFFFRRL
FBBBBFFRLL
BFBFFBBLRL
FBBBBFBRLL
FBBFFBBRLR
FFBBBFBRRL
FFFBBFFLRL
BFBBFBFRLL
FBBFBBFRLL
FBFBBBFLLR
FBFFBFBRLL
BFFFBFFRRR
BFBFBBFLRL
FBBBBBFLRR
FFFFBBFRRL
BFBBFFBRRR
FBBFFFBLRR
BFBBBFBLLR
FBBBBFBRLR
BFBFFFFRLL
FFFBBBFLLL
BFFFBFFLLL
FBFBFFBRLL
BBFFFFFLLL
FFFFFBBLRR
BFFFFFFLRR
BFFBFBFLRR
FFFBFFBLLR
BFFFFFFLLR
FBFFBBBRRR
FFFFBFBLLR
BFFBBFFLLL
FFFFFBBLLR
BFBBBFBRRL
FBFFBBBRLR
BBFFFFBLRL
FFBFFBFLLL
FBFFFFBLRR
FFFBFBFLLR
FFBFFFFLLR
FFFFFBFLRL
BBFFFBBLLL
BFFBFBFRRR
FBBBFFFLLR
BFBBBFBLLL
FBFFFFFRRR
FBFFBBFLRL
BFFBBFBLLR
FBBFFBFRLR
FFFFFBFRRL
FFBFFBBLLL
BFBFFBFRLL
BFBBFFFRLL
FBBBFBFRLL
FBFBFFFLLL
BBFFFBBLRR
FFFBFBFLLL
BBFFBFBLRR
FFBBFBFLRR
BFFBBFFRLR
FBFBFBBRLR
FBBFFBBRRR
FFBFFFBRRR
BFBBFBBLRL
FFFBFFFRLL
BFBBFBFLRL
BFBFBBBLLL
FBFBBFFLRL
FFBFBBBRRL
FFFBFFBRRL
FFBFFFFRLR
FFFFBBBRRR
FFFFBFBLLL
FFBFFBFRRR
FFBFFBFLRR
FFFBBFFRLL
FBBBFFFRLR
FFBFFFBRLL
FBBBFBFRRR
FBFFFBFLRR
FBBBFBFLRL
FBFBFFFRRL
BFBFFFFLRL
FFBBFFBLRL
BBFFBFBLLL
FBFBBBBRRR
FBBFFFBLLR
FBBFBFFRRL
FFBFBFBLLR
BFFBBBFLRR
FBFBFFBLRL
FBFFBBBLLL
FFBFBBFRRL
BFFBFFFLLR
FBBBFBBLRL
BFFBBFBRLR
BFFFBFBRLL
BFFFFBBRRR
FBFFBBFLLR
FFBFFFBRRL
FFBBBBBRRL
BFFBBBBRLR
BFFFBFBRLR
FBBBBBBLLL
BFFFBFBRRR
FFBBBFFRLR
FBBBFBFLLR
FBFBFBFRRR
FBFBBBBLLL
BFBFBFBRLR
FFFFBFFLRR
BFFBFBBRLL
BFBFFFBLLR
BFBBFBBLLL
FBFFBBBLLR
FBBFBBFRRR
FFFBFFFLLR
FFFBFBBRLL
BFBFFBFLLR
BFFFFBBLRL
FBFBBFBLLL
FBBFFBFRLL
BFBBBBFRLR
BFBFFFBRLL
BBFFFBFRLR
FFFFBBBLRL
BFBBFFBLRL
BBFFBBFRRL
FFBBBFBLLL
FBFBFBFLRL
FBBBBBBRRL
FFFFFBBRRR
FFFFFBFRRR
FBFFFBBRRR
BFFBBFBRRL
BBFFFFFRLL
FFFBFFBRLR
FFBBFFFRRL
FBFBFFFRLR
BFFBBBFRLR
BFBBBBFLRL
FBFFBFBRRL
FFBFBBBRRR
FFFFBBFRLL
FFFFBBBRLL
FBBFFFBLLL
BFBBFBBRRR
BFFBBBFRLL
BFFFBFFRLR
FBFBFFBLLL
BFFFFBBRLL
BBFFBFFLRL
BFBBBBBLRL
BFFFFBBRRL
BFFBFFFLRL
BBFFBBFRLR
BFBBFBFLLL
BBFFBFFRLR
FBBFBBBRLL
FFFBFBFLRR
BFBFFBFLLL
FFFFBBFLRR
FFFBBBBLLL
BFBFFFFRRR
FBFBBBFRLL
FFBBFFFLRR
FBFBBBFRLR
BFFFBBFLLR
BFBBBBBLLR
BFFBFFBRRR
FBBBFFBRLR
BFBFBBFLLL
FBFFFFFRLR
BFFFFFFLLL
BFFBFFBRLR
BBFFFFBRLR
BBFFBFBRLR
FBFBFBBLRR
BFFFBBFLRR
FBFFBBBRLL
FFFFBBFLRL
FFBFFBBLRL
FBFFBBFLLL
FBFBBFFLLL
FFBBFFBRLR
BFFFBBBRRR
BBFFFBBLLR
BFFBBBFLRL
BBFFFBBRLR
FBBBBBBLLR
FBFBBFFRRR
FBFFBBFRLL
FFFBBFBRLL
FFFBFBBRLR
FBFFBFFLLL
FFBBBBBLRR
FBFFFFFLLR
FBFFFBBLRL
FBFFBFBLRR
FFBBBBFRRR
FBBBFFFRRL
FFFFBBFLLR
FFFFFBFLRR
BBFFBBFLLL
FBFBFBBLLL
FBFBFFBRRR
FBFFBFFLRR
FBBFFFFLRR
FBBFBFFLLR
BFFBBBFRRR
FFBBBBBRRR
BFFFFFBRLR
BFFBFBFRLR
FFFFBFFRLL
BFBFFBBRLR
BFBBFFFLRL
FBFFFFBLLR
FFBFFBFRLL
BBFFFBBLRL
FBBFFBFLRR
BFFFFBBRLR
BFBBFBBRRL
FBBFBFBRRR
BFFFBFFLRL
FFBBFBBRRL
FFFBFFBLRR
FBBFBFBRRL
BFBFBBFLLR
BBFFFBBRRL
FFBFBBFLRL
FFBFFFBLRR
FBFFBFBLLR
BFBFFBBRRL
BFFBFFFLRR
BFBBBFBRRR
FFBFBBBLRR
BFFFFFBRRL
BFBFBFFRRL
FFBFFBBRRL
FBBBBFBLRL
BFBFFFFRLR
FBBBFFFRRR
BBFFBBFLRR
FFBFBFBRLR
FBBBFBBLRR
FFBFBBBRLL
BFFBBFFRRL
BBFFBFBRLL
FBBBFBBRRR
FBFFFFFLRL
FFBBFFBLLR
FBBFBBBRRL
FFFFBBBRLR
FBBFBBBRLR
FBBBBFBLLR
FFBFBFBLLL
BFFFBBFRRL
FBFFFBFRRL
BFBFBBBRRR
FBFBFBBLRL
BFBFBFFRRR
FFBBBBBRLL
FFFBBBFRRL
FFBBFFBLRR
BFBBBFBLRR
FBBBBBBLRR
FBFFFBBLLR
FBBFBFFLRL
FFBBBFFLRL
FFBFFBFLLR
FFFBBFFRRL
FFFFBFBRRL
FBFBBFBRRL
BFBBFFBLLL
BFFBFBBRRL
FFFFBBBRRL
BBFFFFFRRL
BFFBFFBRRL
FFFBBBFRLL
FFBFBBFRLR
BBFFFBFRLL
BFBBFBBRLL
FFFBFBBRRR
FBBFFFBRRL
FBFBFBFRLL
FBBFFFFRRR
BFBFFBFRRL
FBBBFBFLRR
FFBFBFBLRL
FFBBBBFLLR
FFFFFBFLLR
FFBFFFBLLL
BBFFBFFRLL
FFFBBBBRRR
FFBFFBBLRR
BFFFFFFLRL
FFFBBBFLRL
FBFFFBFLLR
BBFFFBFLRR
BFBFFFBRLR
BFFFBBFRLR
BFBFBBFRRL
BFBFFBBRRR
FFBFBBFLLL
FFFBBFBLLL
FFBBFFBRRL
FBFBBBFLLL
BFFFFFFRLR
BBFFFBFLLR
FBBFBFFRLL
FBFBFFBLRR
FBBFBFBRLR
FBFFBBBRRL
BFFBBFFRLL
BFFBFFBLLL
BFBBFBFRRL
FFFBFBFLRL
FFBBFBBRLR
FBBBBBFLRL
BBFFBFBRRL
FFFFBFBLRR
FFBFBFFRRL
FBFBBBBLRR
FFFFBFFRRR
BBFFBBFLRL
BFBBBBFLLL
FBBFBFBLRR
FBBBBBBRLL
FFFBBBBRLR
BBFFFFFRLR
FBFFFFFRLL
BFBBFFBLLR
BFFFFBFRLR
FFBBBFFRRL
FFBBBFFRLL
BFFBBFBLLL
FFFBBBFRRR
BFFFFFBRRR
FBFFFBFRLL
FBBFBFFLRR
BFFFFFBLRR
BFBFBFBLRL
BFBBBFFLRL
FFBFFFFRLL
FBFBFBFRLR
BFFFBBFRLL
FFBBFBFRLR
FBFBBFBLLR
FBFFBFFRRL
FBBBBFFLRR
BFBFBBBRLR
BFBBBFFRRL
FFFBFBBLRL
FBBBFFBLRR
BFBFFBFLRL
BFFFFFBRLL
BFFFBFFLLR
BFBBBFBRLR
FFFBFFFLRR
FBFBFBFRRL
FBFBFFFLRL
FBBFBBBLLR
BFBFFFFLLR
FBFFFBFLLL
FBBFBBFRLR
FBBFFFBRLL
FFFBFFBLRL
FBFBBFBRLR
BFBBFFFRRR
BFBFBFFRLL
FBFBFBBRRL
FFFBFBFRLL
FBBFFBBRLL
BFFBFBFLRL
BFFFFBBLLR
BFFFFFFRRR
BFBBBFBLRL
FFFBBFFLLL
FBBBFBBRLL
FFFBFFBLLL
FBFFFBFRRR
BFBFFBFLRR
FFBFFFFLRR
BFBBBFFRLR
FBFBFFBLLR
FFBFBBFRRR
FFBBFFBLLL
FFBFFFFLLL
BFFBBFBRRR
FFFBBBFLRR
FFBBFFBRLL
FFBBFBBLLL
BFFFFBFLLL
FFFBBFBRRR
FFBFFFFRRL
FFFBBFBRRL
BFFBBBFRRL
FBBBFFBRLL
FBFBFBBLLR
FBBBFBBRRL
BFBFBBBRRL
BFBFBFFLRR
BFFFFFBLLL
BFBFBBFRLL
FBBBBBFRLL
BFFFBFBLRL
FBFBBBBRLR
FBFFFBFLRL
FFBFBFFRRR
BFBFBFBLLL
BFBBFFBRLL
FBBBBBBLRL
BFFFBBFLLL
FBBFBBFLRL
FFFFBBFRLR
BFBFFFBRRR
FFBFBFFLRR
FFFFFBFLLL
FBFBFFFRRR
FBFFFBFRLR
FBFBBFBRLL
BFBFFBFRRR
BFBBFFBRLR
FBBBBFFRRL
BFBFFFFLLL
BFBFFFBLRR
FBFBBBBRRL
BFFFBFBLRR
FFBBFBFLLR
FBBBFFBRRL
FFFFFBFRLR
FFFBBFBLLR
FBFFBFFLRL
FFFBFBFRRR
BBFFBFBRRR
BFBBBBFLLR
BFBBBBBRLR
FFBBFFFLRL
FBBBFFBLLR
BFBFBFBLRR
FFBFBFFLLR
FBFFBFFRLL
FFBFFFBLLR
BFBBFBFRLR
FBBBFBBLLL
BFBBBBBRLL
FBFBFFBRLR
FFBBBFBLRR
FBBFFBFLLR
FFFBBFBLRL
FBFBBBFLRR
FBBBFFFLRR
FBFFFFBRRR
FFFFFBBLRL
FFBBBBFRLR
BFFBFBFRLL
BFFFFBFRLL
BFFFBFBLLL
BFBBBFBRLL
FFFBFFFRLR
FBBBFFBLLL
FBFBBFFLRR
FFFBFBBLRR
BFBFFFBRRL
FFBBBFFRRR
FBFFFFBRLL
FFFBBFBLRR
FFFFFFBRLR
FFFBBBBLLR
FFFBFFFRRL
FBBFFBBRRL
FBBBBFBLRR
FBFFBFBLLL
FFBFFFBRLR
BFFBBBFLLR
FFFBBBBRLL
FFFFBBBLRR
FFFBBFFLRR
BBFFFFFLLR
FFFFBFBLRL
BFBFBBBLRR
FBBFFFBRLR
FBFFFBBRLR
FBFFBBFLRR
BFBBFBFLRR
FBFBFFFRLL
BBFFBFFRRR
BFFBBBBRLL
BFBBFFBRRL
BFFBBFFLLR
BFBFBBFRRR
FBFBFBFLLL
FBBBFFFRLL
FFBBFBBRRR
FFBBBFFLLL
BFFBFFFLLL
BFBFFBBLRR
FFFFBFBRLR
FBFBBBFRRL
FFFFBBBLLL
FBBBBBFLLR
BFBFBBBLRL
BBFFFFFLRR
BFFBFFBLLR
BFBBFFBLRR
FBBBFBBLLR
FFBFBBFLRR
FBFBFBFLLR
FBFBFBBRRR
BFFFFBFLRL
FFFBFFFLRL
BBFFFBBRRR
BFBBFFFLRR
FFFFBFFLRL
BFFBBFFRRR
BFFBFBBRLR
FFBBBFBRRR
FFBBFBFRRL
FBBFFBFRRL
FBBFBBFRRL
FBBFBFBLLL
BFBBBBBRRL
FFBBFFFLLR
FFBBBFBLRL
FFBBFFFRLR
BFBBFBBLLR
FFBFFBFRRL
FBBBBFFLLL
BFFFFBFLRR
BFBBBFFRLL
BFBBBBBRRR
BBFFFFBLLL
FBFFFBBLRR
FBBBBFFRLR
FBBFBFFRLR
FBFBBFFRRL
FBFFFFBRRL
```

### Solution

822

```javascript
// Input: a string representing a list of boarding passes
// Output: a number representing the highest seat ID on a boarding pass
// Rules/Implicit Knowledge
//   rows: 128 numbered 0-127
//   cols: 8 numbered 0-7
//   boarding pass: binary space partitioning - 10 character string
//     first 7 characters determine row (2 ** 7 = 128)
//     last 3 characters determine col (2 ** 3 = 8)
//     selecting a row or column is a binary process: each letter indicates the lower or upper half
//   seat ID: multiply row by 8 and add column
// Examples: see below
// Edge Cases
// Data Structure
//   boarding pass list: split string on newline to array of strings (boarding passes)
//   boarding pass: leave as string
//   decoded boarding pass: array of two numbers: row and column
//   decoding object? track min and max numbers based on example:
//       min = 0
//       max = 127
//       length = 128

//     F: max = max - (length / 2)
//       min: 0
//       max: 63
//       length: 64

//     B: min = min + (length / 2) = 32
//       min: 32
//       max: 63
//       length: 32

//     F: max = max - (length / 2) = 47
//       min: 32
//       max: 47
//       length: 16

//     B: min = min + (length / 2) = 40
// Algorithm
//   split string of boarding passes on newlines to array of boarding pass strings
//   map array of boarding pass strings to array of seat ID numbers
//     decode boarding pass string to row and col array (2 numbers) - (separate function)
//       split boarding pass string to row string and column string
//         row string is first 7 characters
//         col string is last 3 characters
//       row number = parse row string
//       col number = parse col string
//       parse binary space partition (separate function - takes row string or col string)
//         initialize min to 0
//         initialize max to (2 raised to string length) minus 1
//         iterate string characters
//           if current character is F or L, keep lower half, discard upper half
//             length = max - min + 1
//             max = max - (length / 2)
//           if current character is B or R, keep upper half, discard lower half
//             length = max - min + 1
//             min = min + (length / 2)
//         min and max should be equal; log error if not as a sanity check
//         return min or max (does not matter which)
//       return array of row and col
//     transform row and col array to seat ID (separate function)
//       row * 8 + col
//   return the max seat ID
// Code

let generateSeatID = function generateSeatID(decodedBoardingPass) {
  let [row, col] = decodedBoardingPass;
  return row * 8 + col;
};

// console.log(generateSeatID([70, 7]) === 567);
// console.log(generateSeatID([14, 7]) === 119);
// console.log(generateSeatID([102, 4]) === 820);

let parseBinarySpacePartition = function parseBinarySpacePartition(rowOrColString) {
  const LOWER_HALF = /F|L/;
  const UPPER_HALF = /B|R/;

  let min = 0;
  let max = (2 ** rowOrColString.length) - 1;

  for (let index = 0; index < rowOrColString.length; index += 1) {
    let length = max - min + 1;

    if (LOWER_HALF.test(rowOrColString[index])) {
      max -= length / 2;
    } else if (UPPER_HALF.test(rowOrColString[index])) {
      min += length / 2;
    } else {
      console.log('BSP ERROR - bad input!');
      return;
    }
  }

  if (min !== max) {
    console.log('BSP ERROR - finished parse but min not equal to max!');
    return;
  }

  return min;
};

// console.log(parseBinarySpacePartition('FBFBBFF') === 44);
// console.log(parseBinarySpacePartition('RLR') === 5);
// console.log(parseBinarySpacePartition('BFFFBBF') === 70);
// console.log(parseBinarySpacePartition('RRR') === 7);
// console.log(parseBinarySpacePartition('FFFBBBF') === 14);
// console.log(parseBinarySpacePartition('RRR') === 7);
// console.log(parseBinarySpacePartition('BBFFBBF') === 102);
// console.log(parseBinarySpacePartition('RLL') === 4);

let decodeBoardingPass = function decodeBoardingPass(boardingPassString) {
  let rowString = boardingPassString.slice(0, 7);
  let colString = boardingPassString.slice(7);

  let row = parseBinarySpacePartition(rowString);
  let col = parseBinarySpacePartition(colString);

  return [row, col];
};

// console.log(decodeBoardingPass('BFFFBBFRRR'));
// console.log(decodeBoardingPass('FFFBBBFRRR'));
// console.log(decodeBoardingPass('BBFFBBFRLL'));

let maxSeatID = function maxSeatID(boardingPassesBatch) {
  let seatIDs = boardingPassesBatch.split('\n').map(boardingPassString => {
    let decodedBoardingPass = decodeBoardingPass(boardingPassString);
    return generateSeatID(decodedBoardingPass);
  });

  return Math.max(...seatIDs);
};

const boardingPassesBatch = 'BFFFBBFRRR\n' +
                            'FFFBBBFRRR\n' +
                            'BBFFBBFRLL';
```

---

### Part 2

**Ding!** The "fasten seat belt" signs have turned on. Time to find your seat.

It's a completely full flight, so your seat should be the only missing boarding pass in your list. However, there's a catch: some of the seats at the very front and back of the plane don't exist on this aircraft, so they'll be missing from your list as well.

Your seat wasn't at the very front or back, though; the seats with IDs +1 and -1 from yours will be in your list.

**What is the ID of your seat?**

### Solution

705

```javascript
// map array of boarding pass strings to seatIDs
// sort array of seatIDs
// find index of first gap: first index where current seatID is not equal to previous seatID + 1
// initialize counter to (seatID at first gap index) minus 1
// iterate array of seatIDs starting at first gap index
//   if current seatID is not equal to counter + 1
//     return counter + 1

let findFirstGap = function findFirstGap(seatIDs) {
  for(let index = 1; index < seatIDs.length; index += 1) {
    let current = seatIDs[index];
    let previous = seatIDs[index - 1];

    if (current !== previous + 1) return index;
  }
};

let findMySeatID = function findMySeatID(boardingPassesBatch) {
  let seatIDs = boardingPassesBatch.split('\n').map(boardingPassString => {
    let decodedBoardingPass = decodeBoardingPass(boardingPassString);
    return generateSeatID(decodedBoardingPass);
  });

  seatIDs.sort((first, second) => first - second);

  const firstGapIndex = findFirstGap(seatIDs);
  let counter = seatIDs[firstGapIndex] - 1;
  let missingSeatIDs = [];

  for(let index = firstGapIndex; index < seatIDs.length; index += 1) {
    if (seatIDs[index] !== counter + 1) return counter + 1;
    counter += 1;
  }
};
```
