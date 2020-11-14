
# Arrays and Operators - 10/30/2020

Operators form a large chunk of the syntax a programmer regularly uses; some JavaScript operators are:

`+`, `-`, `*`, `/`, `%`, `-=`, `==`, `!=`, `===`, `!==`, `>`, `>=`, `<`, `<=`

These should be familiar from working with Numbers and Strings, where they're highly useful. Unfortunately, they're practically useless with Arrays.

## Arithmetic Operators

Arithmetic operators convert arrays to strings before performing an operation. After conversion, the operation works the same way as described in the Implicit Type Coercions lesson. You can use the `String()` function to see how JavaScript will coerce an Array into a String.

```javascript
let initials = ['A', 'H', 'E'];
initials + 'B';   // "A, H, EB"
initials;         // ["A", "H", "E"]

// can we add two arrays?
initials + ['B'];   // "A, H, EB"
initials;         // ["A", "H", "E"]
// nope
```

```javascript
[1] * 2;     // 2: becomes '1' * 2, then 1 * 2
[1, 2] * 2   // NaN: becomes '1,2' * 2, then NaN * 2
```

> The real danger here is not the useless results but that JavaScript silently performs these quirky operations without raising errors, which can lead to unexpected bugs.

## Comparison Operators

JavaScript's equality operators, both strict (`===`) and non-strict (`==`) consider arrays equal only if they are the same object; different arrays containing the same values are considered NOT equal:

```javascript
let friends = ['Bob', 'Josie', 'Sam'];
let enemies = [ 'Bob', 'Josie', 'Sam'];
friends == enemies;    // false
friends === enemies;   // false
[] == [];              // false
[] === [];             // false
```

When comparing an array with a value of a different type (not an array) using the non-strict equality operator (`==`), JavaScript implicitly coerces the array into a string and then performs the comparison.

> The relational comparison operators `>`, `>=`, `<`, and `<=` are useless with arrays and objects. They return `true` or `false` in unexpected ways - don't use them with arrays or objects!
