
# JS210 Small Problems - Medium 1 - 11/26/2020

## 1. Rotation Part 1

Write a function that rotates an array by moving the first element to the end of the array. Do not modify the original array.

* If the input is not an array, return `undefined`.
* If the input is an empty array, return an empty array.

Review the test cases below, then implement the solution accordingly.

```javascript
rotateArray([7, 3, 5, 2, 9, 1]);       // [3, 5, 2, 9, 1, 7]
rotateArray(['a', 'b', 'c']);          // ["b", "c", "a"]
rotateArray(['a']);                    // ["a"]
rotateArray([1, 'a', 3, 'c']);         // ["a", 3, "c", 1]
rotateArray([{ a: 2 }, [1, 2], 3]);    // [[1, 2], 3, { a: 2 }]
rotateArray([]);                       // []

// return `undefined` if the argument is not an array
rotateArray();                         // undefined
rotateArray(1);                        // undefined


// the input array is not mutated
const array = [1, 2, 3, 4];
rotateArray(array);                    // [2, 3, 4, 1]
array;                                 // [1, 2, 3, 4]
```

### Solution

```javascript
let rotateArray = function rotateArray(array) {
  if (!Array.isArray(array)) return undefined;
  if (array.length === 0) return [];

  return array.slice(1).concat(array[0]);
};
```

---

## 2. Rotation Part 2

Write a function that rotates the last `n` digits of a `number`. For the rotation, rotate by one digit to the left, moving the first digit to the end.

Examples:

```javascript
rotateRightmostDigits(735291, 1);      // 735291
rotateRightmostDigits(735291, 2);      // 735219
rotateRightmostDigits(735291, 3);      // 735912
rotateRightmostDigits(735291, 4);      // 732915
rotateRightmostDigits(735291, 5);      // 752913
rotateRightmostDigits(735291, 6);      // 352917
```

### Solution

```javascript
let rotateRightmostDigits = function rotateRightmostDigits(number, n) {
  if (n === 1) return number;

  const numberString = String(number);
  const boundary = numberString.length - n;
  const leftmost = numberString.slice(0, boundary);
  let rightmost = numberString.slice(boundary);

  return Number(leftmost + rightmost.slice(1) + rightmost[0]);
};
```

---

## 3. Rotation Part 3

Take the number `735291` and rotate it by one digit to the left, getting `352917`. Next, keep the first digit fixed in place and rotate the remaining digits to get `329175`. Keep the first two digits fixed in place and rotate again to get `321759`. Keep the first three digits fixed in place and rotate again to get `321597`. Finally, keep the first four digits fixed in place and rotate the final two digits to get `321579`. The resulting number is called the **maximum rotation** of the original number.

Write a function that takes an integer as an argument, and returns the maximum rotation of that integer. You can (and probably should) use the `rotateRightmostDigits` function from the previous exercise.

Examples:

```javascript
maxRotation(735291);          // 321579
maxRotation(3);               // 3
maxRotation(35);              // 53
maxRotation(105);             // 15 -- the leading zero gets dropped
maxRotation(8703529146);      // 7321609845
```

### Solution

```javascript
let maxRotation = function maxRotation(number) {
  let result = number;

  for (let digits = String(number).length; digits > 1; digits -= 1) {
    result = rotateRightmostDigits(result, digits);
  }

  return result;
};
```

---

## 4. Stack Machine Interpretation

A stack is a list of values that grows and shrinks dynamically. A stack may be implemented as an `Array` that uses two `Array` methods: `Array.prototype.push` and `Array.prototype.pop`.

A *stack-and-register* programming language is a language that uses a stack of values. Each operation in the language operates on a *register*, which can be thought of as the current value. The register is not part of the stack. An operation that requires two values pops the topmost item from the stack (i.e., the operation removes the most recently pushed value from the stack), operates on the popped value and the register value, and stores the result back in the register.

Consider a `MULT` operation in a stack-and-register language. It multiplies the `stack` value with the `register` value, removes the value from the `stack`, and stores the result back in the `register`. For example, if we start with a `stack` of `[3, 6, 4]` (where `4` is the topmost item in the `stack`) and a `register` value of `7`, the `MULT` operation transforms the `stack` to `[3, 6]` (the `4` is removed), and the result of the multiplication, `28`, is left in the `register`. If we do another `MULT` at this point, the `stack` is transformed to `[3]`, and the `register` is left with the value `168`.

Write a function that implements a miniature stack-and-register-based programming language that has the following *commands* (also called *operations* or *tokens*):

* `n` : Place a value, `n`, in the `register`. Do not modify the `stack`.
* `PUSH` : Push the `register` value onto the `stack`. Leave the value in the `register`.
* `ADD` : Pop a value from the `stack` and add it to the `register` value, storing the result in the `register`.
* `SUB` : Pop a value from the `stack` and subtract it from the `register` value, storing the result in the `register`.
* `MULT` : Pop a value from the `stack` and multiply it by the `register` value, storing the result in the `register`.
* `DIV` : Pop a value from the `stack` and divide it into the `register` value, storing the *integer* result in the `register`.
* `MOD` : Pop a value from the `stack` and divide it into the `register` value, storing the *integer* remainder of the division in the `register`.
* `POP` : Remove the topmost item from the stack and place it in the `register`.
* `PRINT` : Print the `register` value.

All operations are *integer* operations (which is only important with `DIV` and `MOD`).

*Programs* will be supplied to your language function via a string argument. Your function may assume that all arguments are valid programs — i.e., they will not do anything like trying to pop a non-existent value from the `stack`, and they will not contain any unknown *tokens*.

Initialize the `stack` and `register` to the values `[]` and `0`, respectively.

Examples:

```javascript
minilang('PRINT');
// 0

minilang('5 PUSH 3 MULT PRINT');
// 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT');
// 5
// 3
// 8

minilang('5 PUSH POP PRINT');
// 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT');
// 5
// 10
// 4
// 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT');
// 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT');
// 12

minilang('-3 PUSH 5 SUB PRINT');
// 8

minilang('6 PUSH');
// (nothing is printed because the `program` argument has no `PRINT` commands)
```

### Solution

```javascript
let minilang = function minilang(program) {
  let stack = [];
  let register = 0;

  const instructionSet = {
    push() {
      stack.push(register);
    },
    add() {
      register += stack.pop();
    },
    sub() {
      register -= stack.pop();
    },
    mult() {
      register *= stack.pop();
    },
    div() {
      register = Math.floor(register / stack.pop());
    },
    mod() {
      register = Math.floor(register % stack.pop());
    },
    pop() {
      register = stack.pop();
    },
    print() {
      console.log(register);
    },
  };

  program.split(' ').forEach(instruction => {
    if (instruction.match(/^-?\d+$/)) {
      register = parseInt(instruction, 10);
    } else {
      let operation = instructionSet[instruction.toLowerCase()];
      operation();
    }
  });
};
```

#### Further Exploration

Refactor the `minilang` function to include some error handling. In particular, the function should detect and report empty `stack` conditions, and invalid `tokens` in the `program`. Ideally, the function should return an error message if an error occurs, or `undefined` if the `program` runs successfully.

##### FE Solution

```javascript
let minilang = function minilang(program) {
  let stack = [];
  let register = 0;
  let result;

  const instructionSet = {
    push() {
      stack.push(register);
    },
    add() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register += stack.pop();
    },
    sub() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register -= stack.pop();
    },
    mult() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register *= stack.pop();
    },
    div() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register = Math.floor(register / stack.pop());
    },
    mod() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register = Math.floor(register % stack.pop());
    },
    pop() {
      if (stack.length === 0) return 'ERROR! - empty stack';
      register = stack.pop();
    },
    print() {
      console.log(register);
    },
  };

  for (let token of program.split(' ')) {
    if (token.match(/^-?\d+$/)) {
      register = parseInt(token, 10);
    } else {
      let operation = instructionSet[token.toLowerCase()];
      if (!operation) return `ERROR! - invalid token: ${token}`;
      result = operation();
    }
  }

  return result;
};
```

---

## 5. Word to Digit

Write a function that takes a sentence string as an argument, and returns that string with every occurrence of a "number word" — `'zero'`, `'one'`, `'two'`, `'three'`, `'four'`, `'five'`, `'six'`, `'seven'`, `'eight'`, `'nine'` — converted to its corresponding digit character.

Example:

```javascript
wordToDigit('Please call me at five five five one two three four. Thanks.');
// "Please call me at 5 5 5 1 2 3 4. Thanks."
```

### Solution

```javascript
let digitReplacer = function digitReplacer(digit) {
  const digitWords = {
    zero: '0', one: '1', two: '2', three: '3', four: '4', five: '5', six: '6',
    seven: '7', eight: '8', nine: '9',
  };

  return digitWords[digit.toLowerCase()];
};

let wordToDigit = function wordToDigit(sentence) {

  let digitFinder = /\b(zero|one|two|three|four|five|six|seven|eight|nine)\b/gi;
  return sentence.replace(digitFinder, digitReplacer);
};
```

---

## 6. Fibonacci Numbers (Recursion)

The Fibonacci series is a sequence of numbers in which each number is the sum of the previous two numbers. The first two Fibonacci numbers are `1` and `1`. The third number is `1 + 1 = 2`, the fourth is `1 + 2 = 3`, the fifth is `2 + 3 = 5`, and so on. In mathematical terms, this can be represented as:

```
F(1) = 1
F(2) = 1
F(n) = F(n - 1) + F(n - 2) where n > 2
```

This simple sequence can easily be computed using a *recursive* function. A recursive function is one in which the function calls itself. For example, the following function is a recursive function that computes the sum of all integers between `1` and `n`:

```javascript
function sum(n) {
  if (n === 1) {
    return 1;
  } else {
    return n + sum(n - 1);
  }
}
```

A good recursive function has three primary qualities:

* It calls itself at least once.
* It has an ending condition — e.g., `if (n === 1)`, in the `sum` function above.
* The results of each recursion are used in each step — e.g., `n + sum(n - 1)` uses `sum(n - 1)`.

Write a recursive function that computes the `nth` Fibonacci number, where `nth` is an argument passed to the function.

NOTE: This exercise verges on the Advanced level of exercises, so do not be discouraged if you are not able to solve it on your own; recursion is tricky, and even experienced developers can have difficulty dealing with it.

Examples:

```javascript
fibonacci(1);       // 1
fibonacci(2);       // 1
fibonacci(3);       // 2
fibonacci(4);       // 3
fibonacci(5);       // 5
fibonacci(12);      // 144
fibonacci(20);      // 6765
```

### Solution

```javascript
let fibonacci = function fibonacci(nth) {
  if (nth === 1) return 1;
  if (nth === 2) return 1;
  return fibonacci(nth - 1) + fibonacci(nth - 2);
};
```

#### Adjustments based on provided solution

The conditions for `1` and `2` can be combined into a single `if`:

```javascript
let fibonacci = function fibonacci(nth) {
  if (nth <= 2) return 1;
  return fibonacci(nth - 1) + fibonacci(nth -2);
};
```

---

## 7. Fibonacci Numbers (Procedural)

In the previous exercise, we developed a recursive solution for computing the `nth` Fibonacci number. In a language that is not optimized for recursion, some (but not all) recursive functions can be extremely slow and may require massive quantities of memory and/or stack space. If you tested for bigger `nth` numbers, you might have noticed that getting the `50th` fibonacci number already takes a significant amount of time.

Fortunately, every recursive function can be rewritten as a non-recursive (or *procedural*) function.

Rewrite your recursive `fibonacci` function so that it computes its results without using recursion.

Examples:

```javascript
fibonacci(20);       // 6765
fibonacci(50);       // 12586269025
fibonacci(75);       // 2111485077978050
```

Note that JavaScript can accurately compute intergers up to 16 digits long; this means that `fibbonacci(78)` is the largest Fibbonacci number that you can accurately compute with simple operations in JavaScript.

### Solution

```javascript
let fibonacci = function fibonacci(nth) {
  if (nth <= 2) return 1;

  let previous = 1;
  let result = 1;

  for (let counter = 3; counter <= nth; counter += 1) {
    let temp = result;
    result += previous;
    previous = temp;
  }

  return result;
};
```

---

## 8. Fibonacci Numbers (Memoization)

Our recursive `fibonacci` function from the previous exercise is not very efficient. It starts slowing down with an `nth` argument value as low as `35`. One way to improve the performance of our recursive `fibonacci` function (and other recursive functions) is to use *memoization*.

Memoization is an approach that involves saving a computed answer for future reuse, instead of computing it from scratch every time it is needed. In the case of our recursive `fibonacci` function, using memoization saves calls to `fibonacci(nth - 2)` because the necessary values have already been computed by the recursive calls to `fibonacci(nth - 1)`.

For this exercise, your objective is to refactor the recursive `fibonacci` function to use memoization.

### Solution

```javascript
let fibLookup = {
  1: 1,
  2: 1,
};

let fibonacci = function fibonacci(nth) {
  if (fibLookup[String(nth)]) return fibLookup[String(nth)];

  let result = fibonacci(nth - 1) + fibonacci(nth - 2);
  fibLookup[String(nth)] = result;
  return result;
};
```
