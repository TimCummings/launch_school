
# JavaScript Language Fundamentals - Basics - 10/22/2020

1. Building Strings

The intention of the program below is to output a paragraph. Copy and paste the program into a JavaScript console (e.g., from the Chrome Developer Tools), then run it. Is the output what you expected? Are there any bugs/errors?

```javascript
const paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed \
                ligula at risus vulputate faucibus. Aliquam venenatis nibh ut justo dignissim \
                dignissim. Proin dictum purus mollis diam auctor sollicitudin. Ut in bibendum \
                ligula. Suspendisse quam ante, dictum aliquam tristique id, porttitor pulvinar \
                diam. Maecenas blandit aliquet ipsum. Integer vitae sapien sed nulla rutrum \   
                hendrerit ac a urna. Interdum et malesuada fames ac ante ipsum primis in faucibus.';

const paragraph2 = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed \
ligula at risus vulputate faucibus. Aliquam venenatis nibh ut justo dignissim \
dignissim. Proin dictum purus mollis diam auctor sollicitudin. Ut in bibendum \
ligula. Suspendisse quam ante, dictum aliquam tristique id, porttitor pulvinar \
diam. Maecenas blandit aliquet ipsum. Integer vitae sapien sed nulla rutrum \
hendrerit ac a urna. Interdum et malesuada fames ac ante ipsum primis in faucibus.';
console.log(paragraph);
```

### Solution

There is a `SyntaxError` due to the extra spaces after the backslash on the fifth line of the paragraph. Instead of escaping the newline character, the backslash escapes the first space and the un-escaped newline causes the `SyntaxError`.

After fixing this, the output still probably has too much spacing: the spaces before every line after the first are included in the string.

---

2. Conditionals Part 1

Go over the following program. What does it log to the console at lines 7, 11, 15, and 19? Is it what you expected? Why or why not?

```javascript
const myBoolean = true;
const myString = 'hello';
const myArray = [];
const myOtherString = '';

if (myBoolean) {
  console.log('Hello');
}

if (!myString) {
  console.log('World');
}

if (!!myArray) {
  console.log('World');
}

if (myOtherString || myArray) {
  console.log('!');
}
```

### Solution

* line 7: should log 'Hello' because `myBoolean` is `true`.
* line 11: should not log anything because `myString`'s value of `hello` would evaluate to a truthy value, but it's being negatived with `!` so it's `false`.
* line 15: should log 'World' because `myArray`'s value of an empty array should evaluate to a truthy value; it's being double negated, so it's `true`.
* line 19: should log '!' because `myOtherString`'s value of an empty string evaluates to false, but it's ORed with `myArray`, whose value of an empty object evaluates to a truthy value.

| line | logged  |
|------|---------|
| 7    | 'Hello' |
| 11   | nothing |
| 15   | 'World' |
| 19   | '!'     |

---

3. Conditionals Part 2

One of the ways to manage the flow of a program is through the use of conditionals. Go over the code below and specify how many unique execution paths are possible.

```javascript
if (condition1) {
  // ...
  if (condition2) {
    // ...
  } else {
    // ...
  }
} else {
  // ...
  if (condition4) {
    // ...
    if (condition5) {
    // ...
    }
  }
}
```

### Solution

Unique execution paths:

1. `condition1`:true, `condition2`:true
2. `condition1`:true, `condition2`:false
3. `condition1`:false, `condition4`:true, `condition5`:true
4. `condition1`:false, `condition4`:true, `condition5`:false
5. `condition1`:false, `condition4`:false

---

4. String Assignment

Take a look at the following code:

```javascript
let name = 'Bob';
const saveName = name;
name = 'Alice';
console.log(name, saveName);
```

What does this code log to the console? Think about it for a moment before continuing.

If you said that this code logged: `Alice Bob` you would be 100% correct, and the answer should come as no surprise. Now let's look at something slightly different:

```javascript
const name = 'Bob';
const saveName = name;
name.toUpperCase();
console.log(name, saveName);
```

What does this code log? Can you explain these results?

### Solution

This should log `Bob Bob` because `String.prototype.toUpperCase()` is not a mutating method; it returns a new string (as should all methods on primitive types since they're immutable.)

---

5. Arithmetic Integer

Write a program that prompts the user for two positive integers, and then prints the results of the following operations on those two numbers: addition, subtraction, product, quotient, remainder, and power. Do not worry about validating the input.

Example

```javascript
==> Enter the first number:
23
==> Enter the second number:
17
==> 23 + 17 = 40
==> 23 - 17 = 6
==> 23 * 17 = 391
==> 23 / 17 = 1
==> 23 % 17 = 6
==> 23 ** 17 = 1.4105003956066297e+23
```

> The final output above shows how JavaScript displays numbers that are too large for its Number type. The number represents approximately 1.41 * 100,000,000,000,000,000,000,000 using what is called **floating-point notation**. If you want to see what the exact value is, you can use JavaScript's `BigInt` type by appending an `n` to both `23` and `17`:
>
> `23n ** 17n    // 141050039560662968926103n`

### Solution

```javascript
const rlSync = require('readline-sync');

let number1 = rlSync.question('==> Enter the first number:\n');
number1 = Number(number1);

let number2 = rlSync.question('==> Enter the second number:\n');
number2 = Number(number2);

console.log(`==> ${number1} + ${number2} = ${number1 + number2}`);
console.log(`==> ${number1} - ${number2} = ${number1 - number2}`);
console.log(`==> ${number1} * ${number2} = ${number1 * number2}`);
console.log(`==> ${number1} / ${number2} = ${parseInt(number1 / number2, 10)}`);
console.log(`==> ${number1} % ${number2} = ${number1 % number2}`);
console.log(`==> ${number1} ** ${number2} = ${number1 ** number2}`);
```

---

6. Counting the Number of Characters

In this exercise, you will write a program that asks the user for a phrase, then outputs the number of characters in that phrase. Go over the documentation for String to find an appropriate method to use.

Examples:

```javascript
Please enter a phrase: walk
// console output
There are 4 characters in "walk".

Please enter a phrase: walk, don't run
// console output
There are 15 characters in "walk, don't run".
```

### Solution

```javascript
const rlSync = require('readline-sync');

let phrase = rlSync.question('Please enter a phrase: ');

console.log(phrase.length);
```

#### Further Exploration

Only count alphabetic characters

```javascript
const rlSync = require('readline-sync');

let phrase = rlSync.question('Please enter a phrase: ');
let alphabeticCharacters = phrase.replace(/[^a-z]/gi, '');

console.log(alphabeticCharacters);
console.log(`There are ${alphabeticCharacters.length} characters in "${phrase}".`);
```

---

7. Convert a String to a Number

For this exercise we're going to learn more about type conversion by implementing our own `parseInt` function that converts a string of numeric characters (including an optional plus or minus sign) to a number.

The function takes a string of digits as an argument, and returns the appropriate number. Do not use any of the built-in functions for converting a string to a number type.

For now, do not worry about leading `+` or `-` signs, nor should you worry about invalid characters; assume all characters will be numeric.

Examples:

```javascript
stringToInteger('4321');      // 4321
stringToInteger('570');       // 570
```

### Solution

```javascript
function stringToInteger(numberString) {
  let result = 0;
  let digits = numberString.split('').reverse();

  for (let power = 0; power < digits.length; power += 1) {
    result += digits[power] * (10 ** power);
  }

  return result;
}
```

#### Adjustments based on provided solution

It wasn't clear to me how to perform the conversion from a string digit to a numeral digit, so I relied on implicit conversion, which still falls under the spirit of using a built-in function for converting. The non-built-in way is to create a lookup object:

```javascript
const DIGITS = { 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9 };

function stringToInteger(numberString) {
  let result = 0;
  let digits = numberString.split('').reverse();

  for (let power = 0; power < digits.length; power += 1) {
    result += DIGITS[digits[power]] * (10 ** power);
  }

  return result;
}
```

---

8. Convert a String to a Signed Number

The previous exercise mimics the `parseInt` function to a lesser extent. In this exercise, you're going to extend that function to work with signed numbers.

Write a function that takes a string of digits, and returns the appropriate number as an integer. The string may have a leading `+` or `-` sign; if the first character is a `+`, your function should return a positive number; if it is a `-`, your function should return a negative number. If there is no sign, return a positive number.

You may assume the string will always contain a valid number.

Examples:

```javascript
stringToSignedInteger('4321');      // 4321
stringToSignedInteger('-570');      // -570
stringToSignedInteger('+100');      // 100
```

### Solution

```javascript
const DIGITS = { 0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9 };

function stringToSignedInteger(numberString) {
  let signMultiple = 1;

  if (numberString[0] == '+') {
    numberString = numberString.slice(1);
  } else if (numberString[0] == '-') {
    numberString = numberString.slice(1);
    signMultiple = -1;
  }

  let result = 0;
  let digits = numberString.split('').reverse();

  for (let power = 0; power < digits.length; power += 1) {
    result += DIGITS[digits[power]] * (10 ** power);
  }

  return result * signMultiple;
}
```

#### Adjustments based on provided solution

Rather than refactoring the internals of `stringToInteger` from the previous problem, implementing this as a layer on top of `stringToInteger` is astoundingly simple:

```javascript
function stringToSignedInteger(numberString) {
  switch (numberString[0]) {
    case '+': return stringToInteger(numberString.slice(1));
    case '-': return -stringToInteger(numberString.slice(1));
    default: return stringToInteger(numberString);
  }
}
```

---

9. Convert a Number to a String

In the previous two exercises, you developed functions that convert simple numeric strings to signed integers. In this exercise and the next, you're going to reverse those functions.

You will learn more about converting strings to numbers by writing a function that takes a positive integer or zero, and converts it to a string representation.

You may not use any of the standard conversion functions available in JavaScript, such as `String()`, `Number.prototype.toString`, or an expression such as `'' + number`. Your function should do this the old-fashioned way and construct the string by analyzing and manipulating the number.

Examples:

```javascript
integerToString(4321);      // "4321"
integerToString(0);         // "0"
integerToString(5000);      // "5000"
```

### Solution

```javascript
const DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

function integerToString(number) {
  let digits = [];
  do {
    digits.unshift(number % 10);
    number = Math.floor(number / 10);
  } while (number > 0);

  return digits.map(digit => DIGITS[digit]).join('');
}
```

---

10. Convert a Signed Number to a String

In the previous exercise, you reimplemented a function that converts non-negative numbers to strings. In this exercise, you're going to extend that function by adding the ability to represent negative numbers.

You may not use any of the standard conversion functions available in JavaScript, such as `String()`, `Number.prototype.toString`, or an expression such as `'' + number`. You may, however, use the `integerToString` function from the previous exercise.

Examples:

```javascript
signedIntegerToString(4321);      // "+4321"
signedIntegerToString(-123);      // "-123"
signedIntegerToString(0);         // "0"
```

### Solution

```javascript
const DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

function integerToString(number) {
  let digits = [];
  do {
    digits.unshift(number % 10);
    number = Math.floor(number / 10);
  } while (number > 0);

  return digits.map(digit => DIGITS[digit]).join('');
}

function signedIntegerToString(number) {
  if (number > 0) {
    return '+' + integerToString(number);
  } else if (number < 0) {
    return '-' + integerToString(number * -1);
  } else {
    return integerToString(number);
  }
}
```
