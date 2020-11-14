
# Flow Control - 10/18/2020

## Conditionals

Use keywords `if` and `else` along with comparison and logical operators:

* `<`
* `>`
* `<=`
* `>=`
* `==`
* `===`
* `!=`
* `!==`
* `&&`
* `||`

The examples below are all valid JavaScript conditionals.

```javascript
// Example 1
if (x === 3) {
  console.log("x is 3");
}

// Example 2
if (x === 3) {
  console.log("x is 3");
} else {
  console.log("x is NOT 3");
}

// Example 3
if (x === 3) console.log("x is 3");

// Example 4
if (x === 3)
  console.log("x is 3");

// Example 5
if (x === 3)
  console.log("x is 3");
else
  console.log("x is NOT 3");

// Example 6
if (x === 3) {
  console.log('x is 3');
} else {
  if (x === 4) {
    console.log('x is 4');
  } else {
    console.log('x is NOT 3 or 4');
  }
}

// Example 7
if (x === 3) {
  console.log("x is 3");
} else if (x === 4) {
  console.log("x is 4");
} else {
  console.log('x is NOT 3 or 4');
}
```

Example 1 demonstrates the simplest if statement: it has a single condition (x === 3) and a single clause—a block, statement, or expression in this context—that executes when the condition is true. When the condition is false, execution resumes with the first expression after the if statement without running the code in the clause.

Example 2 demonstrates that you can handle both true and false conditions in the same if statement by using an else clause. When the condition is true, the code in the if clause (the first block) runs; when it's false, the code in the else clause runs. It's important to understand that the else clause is not a separate statement: it's part of the if statement.

Examples 3, 4, and 5 show that you don't need a block when the if or else clause contains a single statement or expression. You need braces for a block when you want to execute multiple statements or expressions in a clause. Otherwise, you can omit them. However, this practice can cause problems. Consider the following code:

```javascript
if (x === 3)
  console.log('x is 3');
  console.log('x is an odd number');
```

Based on the indentation, it looks like the programmer expects line 3 to execute when x is 3, but not when it has some other value. However, line 3 is not part of the if statement. It's a separate expression that follows the if statement. Though JavaScript allows this practice, you should avoid it in most cases. Blocks make your code more readable and reliable.

Examples 6 and 7 both behave the same way. Example 6 uses a nested if statement in the else clause, while example 7 shows the result of removing the block. Here, we can ignore our suggestion to use blocks in if statements; else if is one place where omitting the block is preferable. It's easier to read and maintain example 7 since you don't have the syntactic clutter of extra braces and indentation.

## Comparisons

* comparison operators always return a boolean value
* the expressions an operator uses (to its left and right) are its **operands**

## Logical Operators

* And `&&` and or `||`.
* Return the value of the last evaluated operand (not necessarily a boolean value).


### Strict Equality vs. Loose Equality Operators

* **strict equality operator** (`===`) returns `true` when its operands have the same type *and* value
* **non-strict** or **loose equality operator** coerces one of its operands to the same type as the other if they don't match and then compares their values

```javascript
> 5 === '5'
= false

> 5 == '5'
= true
```

> The rules that govern which operand == and != coerces to the other are complex and difficult to remember. Avoid these operators when you can. For instance, you can use explicit coercion and === in most cases.
>
> That advice is not universal. There are JavaScript developers, including some well-known ones, who will tell you to go ahead and use the loose operators, == and !=. Their reasoning is easy to understand: your code should not be attempting to compare different kinds of things, except in a few well-defined, isolated cases. Using the strict operators as a workaround is just masking bad code. They're not completely wrong! If you're comparing strings with arrays, your code is almost certainly needs a redesign.
>
> That said, there are some edge cases that you need to be aware of with the loose operators. For that reason, the style we use at Launch School insists that you always use the strict operators. Doing so won't prevent you from having to fix bad code, but at this stage of your journey, it's less confusing to use the strict operators, and easier to debug.

## Truthiness

When coercing a value to a boolean, JavaScript treats the following values as false:
* `false`
* The number `0` (all three variations:)
  * `0`: the ordinary zero value
  * `-0`: negative zero (nonsense in math but it exists in JavaScript)
  * `0n`: `BigInt` version of zero
* an empty string `''`
* `undefined`
* `null`
* `NaN`

Everything else evaluates as true.

In regards to logical operators and short-circuiting, the return value of the conditional expression is the value of the last operand that is evaluated.

### Operator Precedence

JavaScript has a set of precedence rules it uses to evaluate expressions that use multiple operators and sub-expressions. The following is a list of the comparison operations from the highest precedence (top) to lowest (bottom).

* `<=`, `<`, `>`, `>=` - Comparison
* `==`, `!=` - Equality
* `&&` - Logical AND
* `||` - Logical OR

## Ternary Operator

The ternary operator provides an easy way to write a short, simple if/else conditional. Its chief advantage over an if/else statement is that it is an expression and thus has a return value (along with all of the implications of that, such as being able to assign it to a variable, etc.)

```javascript
> 1 == 1 ? 'this is true' : 'this is not true'
= 'this is true'

> 1 == 0 ? "this is true" : "this is not true"
= 'this is not true'

> let message = true ? 'this is true' : 'this is not true'
= undefined

> message
= 'this is true'
```

## Switch Statement

Similar to `if/else` but it compares a single value against multiple values via strict equality.

```javascript
let a = 5;

switch (a) {
  case 5:
    console.log('a is 5');
    break;
  case 6:
    console.log('a is 6');
    break;
  default:
    console.log('a is neither 5, nor 6');
    break;
}

// logs "a is 5" to the console
```

The break statement in each case is crucial. Without a break, execution "falls through" to the next case clause.

```javascript
let a = 5;

switch (a) {
  case 5:
    console.log('a is 5');
  case 6:
    console.log('a is 6');
  default:
    console.log('a is neither 5, nor 6');
}

// It logs:
// a is 5
// a is 6
// a is neither 5, nor 6
```

```javascript
let a = 5;

switch (a) {
  case 5:
  case 6:
  case 7:
    // executed if a is 5, 6, or 7
    console.log("a is either 5, 6, or 7");
    break;
  case 8:
  case 9:
    // executed if a is 8 or 9
    console.log('a is 8 or 9');
    break;
  default:
    // executed if a is anything else
    console.log('a is not 5, 6, 7, 8, or 9');
    break;
}
```

Technically, this is fall-through, but, since each case executes a single clause, it's safe to use and doesn't suggest a possible error.

## Exercises

1. What values do the following expressions evaluate to?

```javascript
false || (true && false);
true || (1 + 2);
(1 + 2) || true;
true && (1 + 2);
false && (1 + 2);
(1 + 2) && true;
(32 * 4) >= 129;
false !== !true;
true === 4;
false === (847 === '847');
false === (847 == '847');
(!true || (!(100 / 5) === 20) || ((328 / 4) === 82)) || false;
```

### Solution

```javascript
false || (true && false); // false
true || (1 + 2); // true
(1 + 2) || true; // 3
true && (1 + 2); // 3
false && (1 + 2); // false
(1 + 2) && true; // true
(32 * 4) >= 129; // false
false !== !true; // false
true === 4; // false
false === (847 === '847'); // true
false === (847 == '847'); // false
(!true || (!(100 / 5) === 20) || ((328 / 4) === 82)) || false; // true
```

---

2. Write a function, `evenOrOdd`, that determines whether its argument is an even number. If it is, the function should log `'even'` to the console; otherwise, it should log `'odd'`. For now, assume that the argument is always an integer.

> Hint 1: A number is even if you can divide it by two with no remainder. For instance, 4 is even since 4 divided by 2 has no remainder. Conversely, 3 is odd since 3 divided by 2 has a remainder of 1.

> Hint 2: You can use the % remainder operator shown in The Basics chapter to determine the remainder.

### Solution

```javascript
function evenOrOdd(int) {
  if (int % 2 === 0) {
    console.log('even');
  } else {
    console.log('odd');
  }
}
```

---

3. Let's improve our previous implementation of `evenOrOdd`. Add a validation check to ensure that the argument is an integer. If it isn't, the function should issue an error message and return.

> Hint: You can use `Number.isInteger(value)` to determine whether a numeric `value` is an integer. It returns `true` if the value is an integer, `false` otherwise.

### Solution

```javascript
function evenOrOdd(int) {
  if (!Number.isInteger(int)) {
    console.log('Error: input is not an integer!');
    return;
  }

  if (int % 2 === 0) {
    console.log('even');
  } else {
    console.log('odd');
  }
}
```

---

4. What does the following code log to the console, and why?

```javascript
function barCodeScanner(serial) {
  switch (serial) {
    case '123':
      console.log('Product1');
    case '113':
      console.log('Product2');
    case '142':
      console.log('Product3');
    default:
      console.log('Product not found!');
  }
}

barCodeScanner('113');
```

### Solution

This code is missing `break` statements; as a result, evaluation will "fall through" after matching, in this case logging:

```
Product2
Product3
Product not found!
```

---

5. Refactor this statement to use an `if` statement instead.

```javascript
return foo() ? 'bar' : qux();
```

### Solution

```javascript
if (foo()) {
  return 'bar';
} else {
  return qux();
}
```

---

6. What does this code output to the console?

```javascript
function isArrayEmpty(arr) {
  if (arr) {
    console.log('Not Empty');
  } else {
   console.log('Empty');
  }
}

isArrayEmpty([]);   // [] is an empty Array
```

### Solution

Empty arrays evaluate to true, so this code logs `Not Empty`, even though the array is empty.

---

7. Write a function that takes a string as an argument and returns an all-caps version of the string when the string is longer than 10 characters. Otherwise, it should return the original string. Example: change `'hello world'` to `'HELLO WORLD'`, but don't change `'goodbye'`.

### Solution

```javascript
function upcaseLongStrings(str) {
  if (str.length > 10) {
    return str.toUpperCase();
  } else {
    return str;
  }
}
```

---

8. Write a function that logs whether a number is between 0 and 50 (inclusive), between 51 and 100 (inclusive), greater than 100, or less than 0.

```
numberRange(25);   // '25 is between 0 and 50'
numberRange(75);   // '75 is between 51 and 100'
numberRange(125);  // '125 is greater than 100'
numberRange(-25);  // '-25 is less than 0'
```

### Solution

```javascript
function numberRange(number) {
  if (number >= 0 && number <= 50) {
    console.log(`${number} is between 0 and 50`);
  } else if (number >= 51 && number <= 100) {
    console.log(`${number} is between 51 and 100`);
  } else if (number > 100) {
    console.log(`${number} is greater than 100`);
  } else if (number < 0) {
    console.log(`${number} is less than 0`);
  }
}
```

#### Adjustments based on provided solution

Re-ordering the conditionals makes the solution a little cleaner by reducing comparisons:

```javascript
function numberRange(number) {
  if (number < 0) {
    console.log(`${number} is less than 0`);
  } else if (number <= 50) {
    console.log(`${number} is between 0 and 50`);
  } else if (number <= 100) {
    console.log(`${number} is between 51 and 100`);
  } else {
    console.log(`${number} is greater than 100`);
}
```
