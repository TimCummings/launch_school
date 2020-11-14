
# Pure Functions and Side Effects - 11/2/2020

A function call that performs any of the following is said to have side effects:

* reassigns any non-local variable
* mutates the value of any object referenced by a non-local variable
* reads from or writes to any data entity (files, network, etc.) that is non-local to your program
* raises an exception
* calls another function that has side effects

## Side Effects through Input/Output (IO)

All of the following are considered side effects:

* Reading from a file on the system's disk
* Writing to a file on the system's disk
* Reading input from the keyboard
* Writing to the console
* Accessing a database
* Updating the display on a web page
* Reading data from a form on a web page
* Sending data to a remote web site
* Receiving data from a remote web site
* Accessing system hardware such as:
  * The mouse, trackpad, or other pointing devices
  * The clock
  * The random number generator
  * The audio speakers
  * The camera

The list goes on. Using any of these things are considered side effects.

Perhaps the most surprising entries on that list are reading from the keyboard and writing to the console:

```javascript
let readLine = require("readline-sync");

function getName() {
  let name = readLine.question("Enter your name: ") // side effect: output and input
  console.log(`Hello, ${name}!`); // side effect: output to console
}
```

Accessing the system date or time and generating random numbers are also side effects:

```javascript
let date = new Date(); // side effect: accesses the system clock
let rand = Math.random(); // side effect: accessed random number generator
```

## Non Local Side Effects

Note that side effects are mainly important when they aren't local to the calling function:

```javascript
function insertNumberInOrder(arrayOfNumbers) {
  arrayOfNumbers = arrayOfNumbers.slice(); // creates a copy of an array
  arrayOfNumbers.push(arrayOfNumbers); // not a side effect since copy of array
  arrayOfNumbers.sort((a, b) => a - b); // sort has side effects within function
  return arrayOfNumbers; // function has no side effect
}
```

Even though several of the function calls inside `insertNumberInOrder` clearly have side effects, `insertNumberInOrder` can be said to have no side effects, since all effects are contained within local variables to the function; nothing "leaks out".

## Mixing Side Effects and Return Values

As much as possible, your functions should return a useful value **or** have a side effect, but not both. Sometimes avoiding both isn't possible, but stick to it as much as you can.

## Pure Functions

**Pure functions**:

* have no side effects
* always return a value that is dependent on their arguments
* given the same set of arguments, they always return the same value during their lifetime

```javascript
const squared = value => value * value;
```

The consistent return value is probably the most important feature, because it implies that a pure function is isolated from the rest of the program: nothing else can influence the pure function during its lifetime. A huge benefit is how easy pure functions are to test.

## Practice Problems

1. What side effects are present in the `foo` function in the following code?

```javascript
const bar = 42;
let qux = [1, 2, 3];
let baz = 3;

function foo(arr) {
  let value = arr.pop();
  console.log(`popped ${value} from the array`);
  return value + bar + baz;
}

foo(qux);
```

### Solution

Line 6 mutates the `arr` argument; when invoked with the array `qux` on line 11, `qux` is mutated.
Line 7 logs to the console.

---

2. Which of the following functions are pure functions?
```javascript
// Function 1

function sum(a, b) {
  console.log(a + b);
  return a + b;
}
```

```javascript
// Function 2

function sum(a, b) {
  a + b;
}
```

```javascript
// Function 3

function sum(a, b) {
  return a + b;
}
```

```javascript
// Function 4

function sum(a, b) {
  return a + b + Math.random();
}
```

```javascript
// Function 5

function sum(a, b) {
  return 3.1415;
}
```

### Solution

Function 3 is a pure function.

Function 1 logs to the console.
Function 2 does not return a value dependent on its input.
Function 4 access the random number generator.
Function 5 does not return a value dependent on its input.
