
# Loops and Iterating - 10/18/2020

## While Loops

```javascript
let counter = 1;
while (counter <= 10) {
  console.log(counter);
  counter = counter + 1;
}
```

### Looping Over Arrays With while

```javascript
let names = ['Chris', 'Kevin', 'Naveed', 'Pete', 'Victor'];
let upperNames = [];
let index = 0;

while (index < names.length) {
  let upperCaseName = names[index].toUpperCase();
  upperNames.push(upperCaseName);
  index += 1;
}

console.log(upperNames); // ['CHRIS', 'KEVIN', 'NAVEED', 'PETE', 'VICTOR']
```

### do/while Loop

A do/while loop differs visibly from a while loop, but its behavior is almost identical. The crucial difference is that do/while always executes the code in the block at least once. A while loop can't make that guarantee since the initial condition may be falsy; if it is, the loop body doesn't run. In a do/while loop, the conditional check occurs at the end of the loop instead of the beginning which allows it to run the code at least once, even if the condition is falsy when the loop begins.

```javascript
let answer;
do {
  answer = prompt("Do you want to do that again?");
} while (answer === 'y');
```

## for Loops

`for` loops have the same purpose as `while` loops, but they use a condensed syntax that works well when iterating over arrays and other sequences. A `for` loop combines variable initialization, a loop condition, and the variable increment/decrement expression all on the same line:

```javascript
for (initialization; condition; increment) {
  // loop body
}
```

This structure behaves almost the same as:

```javascript
initialization;
while (condition) {
  // loop body
  increment;
}
```

The sole difference between the two loops is the scope of any variables declared by the initialization clause. In the while statement, the scope includes the code that surrounds the loop; in the for statement, the scope is the for statement and its body.

```javascript
let names = ['Chris', 'Kevin', 'Naveed', 'Pete', 'Victor'];
let upperNames = [];

for (let index = 0; index < names.length; index += 1) {
  let upperCaseName = names[index].toUpperCase();
  upperNames.push(upperCaseName);
}

console.log(upperNames); // ['CHRIS', 'KEVIN', 'NAVEED', 'PETE', 'VICTOR']
```

## Controller Loops

* advance to the next iteration of the loop with `continue`
* exit the loop with `break`

## Array Iteration

JavaScript has built-in ways to iterate over arrays, such as `forEach`.

```javascript
let names = ['Chris', 'Kevin', 'Naveed', 'Pete', 'Victor'];

names.forEach(function (name) {
  console.log(name);
});
```

Notice the function expression that is passed to `forEach`. Since this function is unnamed, it's an **anonymous function**. We can use an arrow function here to make it even more concise:

```javascript
let names = ['Chris', 'Kevin', 'Naveed', 'Pete', 'Victor'];

names.forEach(name => console.log(name));
```

## Recursion

A **recursive** function is a function that calls itself. It needs a **baseline condition** that marks the end of the recursion.

```javascript
function fibonacci(number) {
  if (number < 2) return number; // 0 if number is 0, 1 if number is 1
  return fibonacci(number - 1) + fibonacci(number - 2);
}

console.log(fibonacci(6));  // the 6th Fibonacci number is 8
console.log(fibonacci(20)); // the 20th Fibonacci number is 6765
```

## Exercises

1. Modify the `age.js` program you wrote in the exercises for the *Input/Output* chapter. The updated code should use a `for` loop to display the future ages.

### Solution

```javascript
rlSync = require('readline-sync');
age = Number(rlSync.question('How old are you? '));

console.log(`You are ${age} years old.`);

for (let years = 10; years <= 40; years += 10) {
  console.log(`In ${years} years, you will be ${age + years} years old.`);
}
```

---

2. Write a function that computes and returns the factorial (see exercise 4 in the Functions chapter) of a number by using a `for` loop. You may assume that the argument is a valid non-negative integer.

**Examples**

```javascript
console.log(factorial(0));     // => 1
console.log(factorial(1));     // => 1
console.log(factorial(2));     // => 2
console.log(factorial(3));     // => 6
console.log(factorial(4));     // => 24
console.log(factorial(5));     // => 120
console.log(factorial(6));     // => 720
console.log(factorial(7));     // => 5040
console.log(factorial(8));     // => 40320
```

### Solution

```javascript
function factorial(num) {
  let result = 1;
  for (let x = num; x > 1; x -= 1) {
    result *= x;
  }

  return result;
}
```

---

3. The following code causes an infinite loop (a loop that never stops iterating). Why?

```javascript
let counter = 0;

while (counter = 1) {
  console.log(counter);
  counter += 1;

  if (counter > 2) {
    break;
  }
}
```

### Solution

The `while` condition on line 3 is using assignment instead of equality comparison. As a result, counter is getting reassigned to `1` each loop, so the condition on line 7 that would `break` out of the loop is never satisfied.

---

4. Does the following code produce an error? Why or why not? What output does this code send to the console?

```javascript
for (let i = 0; i < 5;) {
  console.log(i += 1);
}
```

### Solution

This code does not produce an error. Even though the `for` statement omits the increment/decrement expression, the loop body takes care of incrementing `i` on line two. This code logs:

```
1
2
3
4
5
```

---

5. The following code uses a `randomNumberBetween` function to generate a number between its first and second arguments. It uses a `while` loop to try to generate a number greater than 2. Refactor the code so that you don't need to call `randomNumberBetween` from two different locations, lines 6 and 10. Do not change the arguments you pass to `randomNumberBetween`.

```javascript
function randomNumberBetween(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

let tries = 0;
let result = randomNumberBetween(1, 6);
tries += 1;

while (result <= 2) {
  result = randomNumberBetween(1, 6);
  tries += 1;
}

console.log('It took ' + String(tries) + ' tries to get a number greater than 2');
```

### Solution

```javascript
function randomNumberBetween(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

let tries = 0;
let result = 0;

while (result <= 2) {
  result = randomNumberBetween(1, 6);
  tries += 1;
}

console.log('It took ' + String(tries) + ' tries to get a number greater than 2');
```

#### Adjustments based on provided solution

A `do...while` loop is ideal here - I initially avoided it because the problem specified a `while` loop.

```javascript
function randomNumberBetween(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

let tries = 0;
let result;

do {
  result = randomNumberBetween(1, 6);
  tries += 1;
} while (result <= 2);

console.log('It took ' + String(tries) + ' tries to get a number greater than 2');
```

---

6. Reimplement the `factorial` function from exercise 2 using recursion. Once again, you may assume that the argument is a valid non-negative integer.

Examples

```javascript
console.log(factorial(0));     // => 1
console.log(factorial(1));     // => 1
console.log(factorial(2));     // => 2
console.log(factorial(3));     // => 6
console.log(factorial(4));     // => 24
console.log(factorial(5));     // => 120
console.log(factorial(6));     // => 720
console.log(factorial(7));     // => 5040
console.log(factorial(8));     // => 40320
```

### Solution

```javascript
function factorial(num) {
  if (num <= 1) return 1;
  return num * factorial(num - 1);
}
```
