
# Closures - 10/25/2020

A **closure** is the combination of a function and the lexical environment within which it was defined - a function combined with all of the variables in its lexical scope, including function and class names. A closure is created whenever you define a function or method. You can think of a closure as an envelope (or backpack) that *encloses* the function's environment (what's in scope.) The function definition and its scope become a single entity called a closure. Consequently, when the function is invoked, it has access to everything in its environment, even if those variables aren't in scope where the function is invoked.

```javascript
function foo() {
  let name = "Pete";

  return function () {
    console.log(name);
  };
}

let printPete = foo();
printPete();   // Pete
```

Even though `name` is out of scope when `printPete()` is invoked on line 9, the returned function `foo()` has its envelope containing its environment, including a pointer to the `name` variable, so this works.

Note that variables in a closure are references, not values: changes to them before invocation will be reflected.

```javascript
function makeCounter() {
  let counter = 0;

  return function() {
    counter += 1;
    return counter;
  }
}

let incrementCounter = makeCounter();
console.log(incrementCounter()); // => 1
console.log(incrementCounter()); // => 2
```

## Partial Function Application

**Partial function application** is the creation of a function that can call a second function with fewer arguments than the second function expects; the created function supplies the remaining arguments:

```javascript
function add(first, second) {
  return first + second;
}

function makeAdder(firstNumber) {
  return function(secondNumber) {
    return add(firstNumber, secondNumber);
  };
}

let addFive = makeAdder(5);
let addTen = makeAdder(10);

console.log(addFive(3));  // 8
console.log(addFive(55)); // 60
console.log(addTen(3));   // 13
console.log(addTen(55));  // 65
```

We'll discuss this further in another course.

## What are Closures Good For?

* callbacks
* creating private data
* partial function application
* currying (a special form of partial function application)
* emulating private methods
* creating functions that can only be executed once
* iterators and generators
* the module pattern (putting code and data into modules)
* asynchronous operations

We'll discuss these further in later courses.

## Optional Reading

https://medium.com/dailyjs/i-never-understood-javascript-closures-9663703368e8

> The author claims that his final example is partial application, but it doesn't quite fit with our definition. You can ignore that.
>
> The author also uses the term "backpack" for what we call an envelope.
>
> Also, he sometimes uses *argument* and *parameter* interchangeably.
