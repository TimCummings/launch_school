
# Functions - 10/17/2020

* **Functions** are procedures that let you extract code and run it as a separate unit.
* Functions are defined with the reserved keyword `function`.
* A function definition consists of:
  * reserved keyword `function`
  * function name
  * list of parameters in parentheses
  * function body in curly braces

```javascript
function say(words) {
  console.log(words);
}

say("hello");
say("hi");
say("how are you");
say("I'm fine");
```

## Return Values

All JavaScript function calls evaluate to a value. By default, that value is `undefined`. You can specify a different value with the `return` statement:

```javascript
function add(a, b) {
  return a + b;
}

add(2, 3); // => returns 5
```

Functions that always return a boolean value are called **predicates**.

## Default Parameters

```javascript
function say(words = 'hello') {
  console.log(words + '!');
}

say('Howdy'); // logs Howdy!
say(); // logs hello!
```

You'll notice that `say()` —without arguments— logs `"hello!"` to the console. Since we've provided a default value for `words`, we can call our function without arguments. Nice!

## Nested Functions

You can create functions anywhere, even nested inside another function:

```javascript
function foo() {
  function bar() {
    console.log("BAR");
  }

  bar(); // BAR
  bar(); // BAR
}

foo();
bar(); // ReferenceError: bar is not defined
```

Here, the `bar` function is nested within the `foo` function. Such nested functions get created and destroyed every time the outer function runs. (This has a mostly negligible effect on performance.) They are also private functions since we can't access a nested function from outside the function where it is defined.

## Variable Scope

In JavaScript, there are two types of variables based on where they're accessible:

1. **global** variables: available throughout a program
2. **local** variables: confined to a function

Any variable declared (via `let` or `const`) inside a function or block is a local variable. Everything else is a global variable.

### Global Variables

```javascript
let greetingMessage = 'Good Morning';

function greetPeople() {
  console.log(greetingMessage);
}

function changeGreetingMessage(newMessage) {
  greetingMessage = newMessage;
}

changeGreetingMessage('Good Evening');
greetPeople(); // logs 'Good Evening'
```

Notice how even though `greetingMessage` looks like it might be a local variable (declared with `let`), it is reassigned in a function without being passed in as an argument. That's because it's really a global variable since it's not declared inside a function or block.

Global variables have their uses, but they are generally discouraged due to the likelihood of their misuse causing bugs.

### Local Variables

The following code is functionally identical to the first example in the previous section. However, it doesn't use any global variables. The `greetPeople` function declares `greetingMessage` internally. It's accessible within the function, but a `ReferenceError` occurs if you try to use it elsewhere.

```javascript
function greetPeople() {
  let greetingMessage = 'Good Morning';
  console.log(greetingMessage);
}

greetPeople();
console.log(greetingMessage); // raises ReferenceError
```

If we want dynamic behavior with our functions, e.g. a different greeting message, we simply use function arguments.

## Functions vs. Methods

* **function invocation**: `functionName(object);`
* **method invocation**: `object.methodName();`

This is discussed further in the Core Curriculum. For now, you must refer to documentation or study source code to determine which syntax to use.

## Mutating the Caller

We can also talk about whether functions mutate their arguments.

* Primitives (numbers, strings, booleans) are **immutable** and cannot be mutated.
* Complex data structures (arrays and objects) are **mutable**.

Since primitives are immutable, mutating methods/functions are only a concern when dealing with arrays and objects. Unfortunately, there's no easy way to tell whether a method or function will mutate; you must study documentation and practice.

> If you have experience programming in other languages and wonder whether JavaScript is a pass-by-value or pass-by-reference language, JavaScript is both! It uses pass-by-value when dealing with primitive values and pass-by-reference with objects and arrays.

## Function Composition

JavaScript, via **function composition**, lets us provide a function call as an argument to another function:

```javascript
function times(num1, num2) {
  return num1 * num2;
}

console.log(times(add(20, 45), subtract(80, 10))); // => 4550
// 4550 == ((20 + 45) * (80 - 10))
```

## Three Ways to Define a Function

A **function declaration** is what we've already seen. When using a function declaration, the function can be called before it's declared:

```javascript
greetPeople();

function greetPeople() {
  console.log('Good Morning');
}
// this works and does not throw an error
```

There's also a **function expression**. Functions defined this way cannot be invoked until they're declared.

```javascript
let greetPeople = function() {
   console.log('Good Morning');
};

greetPeople();
```

Any function definition that doesn't have the word `function` at the very beginning of a statement is a function expression. This includes wrapping a function in parentheses:

```javascript
// This is a function expression, not a declaration

(function greetPeople() {
  console.log('Good Morning');
})
```

as well as higher-order functions (which we'll explore in the Core Curriculum):

```javascript
function makeGreeter(name) {
  return function greeter() {
    console.log(`Hello ${name}`);
  }
}
```

Lastly, with ES6+, there are **arrow functions**, which look quite different:

```javascript
let greetPeople = () => console.log('Good Morning!');
greetPeople();

let add = (a, b) => a + b;
```

Arrow functions with only a single expression will *implicitly return* that expression. If an arrow function has more than one expression, you must explicitly return a value and use curly braces:

```javascript
// Run this code in your browser

let add = (a, b) => a + b;
let getNumber = text => {
  let input = prompt(text);
  return Number(input);
};

let number1 = getNumber('Enter a number: ');
let number2 = getNumber('Enter another number: ');
console.log(add(number1, number2));
```

On line #4, we define an arrow function that requires one parameter. The parentheses around the parameter name are optional in this case and are often omitted.

## The Call Stack

The **call stack** (or simply **stack**) is what JavaScript uses to keep track of the program it's running. It's a **last-in-first-out** data structure that uses **stack frames** to track the details of running functions, such as the function name, arguments, and line number where it was invoked. Let's look at an example:

```javascript
function first() {
  return "foo "
}

function second() {
  return first() + "bar ";
}

function third() {
  return first() + second() + "qux";
}

third(); // => 'foo foo bar qux'
```

Let's see what the call stack looks like at various points during the execution of this program.

| What?              | Item 0 | Item 1 | Item 2 | Item 3 |
|--------------------|--------|--------|--------|--------|
| program begins     | main   |        |        |        |
| calling `third()`  | main   | third  |        |        |
| calling `first()`  | main   | third  | first  |        |
| `first()` returns  | main   | third  |        |        |
| calling `second()` | main   | third  | second |        |
| calling `first()`  | main   | third  | second | first  |
| `first()` returns  | main   | third  | second |        |
| `second()` returns | main   | third  |        |        |
| `third()` returns  | main   |        |        |        |
| program ends       |        |        |        |        |

In this table, we represent the call stack horizontally, with the bottom of the stack as "Item 0", and the top of the stack at each point in the program being the rightmost item that has a value. As you can see, it always contains `main` until the program ends, at which point `main` gets popped off the stack leaving the stack empty.

When we call `third` on line 13, the function `third` gets pushed onto the stack. When `third` calls `first` on line 10, `first` gets pushed to the stack. When `first` returns on line 2, `first` gets popped from the stack leaving `third` at the top; JavaScript can use this item to determine where in the function execution needs to resume.

This process continues through the rest of the program's execution, with items being pushed to and popped from the call stack. At all times, the topmost (rightmost above) item is the function that is currently running. When a function returns, it always returns to the function specified by the newly exposed stack item.

## Exercises

1. What does this code log to the console? Does executing the `foo` function affect the output? Why or why not?

```javascript
let bar = 1;
function foo() {
  let bar = 2;
}

foo();
console.log(bar);
```

### Solution

This logs `1` to the console. Executing `foo` does not affect the output. The `bar` variable inside the `foo` function is a different variable than the `bar` variable outside it, so the outer `bar` remains unchanged by executing `foo`.

---

2. In the exercises for the previous chapter, you wrote a dynamic greeter program named `greeter.js`. Add a function to this program that solicits the user's first and last names in separate invocations; the function should return the appropriate name as a string. Use the return values to greet the user with their full name.

> Hint: You need to pass a prompt argument to the function.

### Solution

```javascript
rlSync = require('readline-sync');

function solicitName(which = 'first') {
  if (which === 'first') {
    let firstName = rlSync.question('What is your first name? ');
    return firstName;
  } else if (which === 'last') {
    let lastName = rlSync.question('What is your last name? ');
    return lastName;
  }
}

let firstName = solicitName('first');
let lastName = solicitName('last');
console.log(`Hello, ${firstName} ${lastName}!`);
```

#### Adjustments based on provided solution

There's no need for a conditional; let the prompt argument do the "heavy lifting" of indicating what is being requested. Don't forget to initialize all variables, including the `readline-sync` object, with `let`.

```javascript
function solicitName(prompt) {
  let rlSync = require('readline-sync');
  let name = rlSync.question(prompt);
  return name;
}

let firstName = solicitName('What is your first name? ');
let lastName = solicitName('What is your last name? ');
console.log(`Hello, ${firstName} ${lastName}!`);
```

---

3. Write a program that uses a `multiply` function to multiply two numbers and returns the result. Ask the user to enter the two numbers, then output the numbers and result as a simple equation.

```javascript
$ node multiply.js
Enter the first number: 3.141592653589793
Enter the second number: 2.718281828459045
3.141592653589793 * 2.718281828459045 = 8.539734222673566
```

### Solution

```javascript
function multiply(num1, num2) {
  return num1 * num2;
}

let rlsync = require('readline-sync');

let num1 = rlsync.question('Enter the first number: ');
num1 = Number(num1);

let num2 = rlsync.question('Enter the second number: ');
num2 = Number(num2);

console.log(`${num1} * ${num2} = ${multiply(num1, num2)}`);
```

---

4. Use the `times` function shown below to write a program that logs the value of `1!` (one factorial), `2!` (two factorial), `3!`, `4!`, and `5!` (five factorial) to the console.

| n!   | Expansion           | Result |
|------|---------------------|--------|
| `1!` | `1`                 | 1      |
| `2!` | `1 * 2`             | 2      |
| `3!` | `1 * 2 * 3`         | 6      |
| `4!` | `1 * 2 * 3 * 4`     | 24     |
| `5!` | `1 * 2 * 3 * 4 * 5` | 120    |

```javascript
function times(number1, number2) {
  let result = number1 * number2;
  console.log(result);
  return result;
}
```

Here's an example of the expected output:

```
> node factorial.js
1
2
6
24
120
```

### Solution

```javascript
function times(number1, number2) {
  let result = number1 * number2;
  console.log(result);
  return result;
}

times(times(times(times(times(1, 1), 2), 3), 4), 5);
```

---

5. What does the following code log to the console?

```javascript
function scream(words) {
  words = words + '!!!!';
  return;
  console.log(words);
}

scream('Yipeee');
```

### Solution

This code doesn't log anything to the console since it returns before invoking `console.log`.

---

6. What does the following code log to the console?

```javascript
function scream(words) {
  return words + '!!!!';
}

scream('Yipeee');
```

### Solution

This code also doesn't log anything to the console. It never invokes `console.log`.
