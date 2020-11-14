
# Operators - 10/21/2020

An operator is a symbol that tells the computer to perform operations on values (its operands). Operators usually have two operands, e.g. in `a + b` the operands are `a` and  `b`.

## Arithmetic Operators

take two numeric operands and return a single numeric value: `+`, `-`, `*`, `/`, `%`.

Note that the remainder operator `%` is different than the modulo operator common in other languages. While they act the same with positive integers, their behavior is different with a negative operand:

```javascript
// javascript remainder operator
10 % -3; // => 1
```

Modulo in other language: `10 % -3 == -2`.

## Assignment Operators

Assignment operators assign the value of the right operand to the left operand. There are also compound assignment operators:

| Name                      | Shorthand Operator | Meaning   |
|---------------------------|--------------------|-----------|
| Addition Assignment       | a += b             | a = a + b |
| Subtraction Assignment    | a -= b             | a = a - b |
| Multiplication Assignment | a *= b             | a = a * b |
| Division Assignment       | a /= b             | a = a / b |
| Remainder Assignment      | a %= b             | a = a % b |

## Comparison Operators

Comparison operators compare their operands and return a boolean value. When the operands are different types, JavaScript tries to implicitly convert them to suitable types, which can cause significant problems. Many developers avoid `==` and `!=` in favor of their strict versions `===` and `!==`, which don't perform any conversions on their own.

| Operator                 | Description                                                            |
|--------------------------|------------------------------------------------------------------------|
| Equal (`==`)             | Returns true if the operands are equal                                 |
| Not Equal (`!=`)         | Returns true if the operands are not equal                             |
| Strict Equal (`===`)     | Returns true if the operands are equal and of the same type            |
| Strict Not Equal (`!==`) | Returns true if the operands are not equal and/or not of the same type |
| Greater than (`>`)       | Returns true if the left operand is greater than the right             |
| Less than (`<`)          | Returns true if the left operand is less than the right                |

## String Operators

You can compare strings just like numbers:

```javascript
'a' < 'b';         // true
'Ant' > 'Falcon';  // false
// String comparisons use Unicode lexicographical ordering
'50' < '6';        // true ('5' precedes '6' lexicographically)
```

Strings also support concatenation via `+` and combination concatenation/assignment via `+=`:

```javascript
let a = 'Hello';
a += ', world!';

a; // "Hello, world!"
```

## Logical Operators

And `&&`, or `||`, and  not `!`.

Note that not is a unary operator: it takes only a single operand.

And and or support short circuit evaluation and will return the value of the last operand to be evaluated.
