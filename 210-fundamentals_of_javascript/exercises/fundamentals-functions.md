
# JavaScript Fundamentals Exercises - Functions - 10/26/2020

1. Local vs Global Part 1

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
var myVar = 'This is global';

function someFunction() {
  var myVar = 'This is local';
}

someFunction();
console.log(myVar);
```

### Solution

This logs `This is global` because the inner `myVar` variable on line 4 shadows the outer `myVar` variable on line 1.

#### Adjustments based on provided solution

My answer was incomplete; the solution describes the scope of the variables, specifically that the first `myVar` is declared outside of any other functions at the "global" level, while the inner `myVar` is declared inside the `somFunction()` function and is scoped to that function. The `console.log` call on line 8 is at the global scope, thus `myVar` references the variable from line 1.

---

2. Local vs Global Part 2

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
var myVar = 'This is global';

function someFunction() {
  var myVar = 'This is local';
  console.log(myVar);
}

someFunction();
```

### Solution

This logs `This is local` because the `console.log` call on line 5 is within the `someFunction()` function which has `myVar` on line 4 in scope. The `myVar` on line 1 could still be accessed within `someFunction()`, but the declaration of a second `myVar` variable on line 4 shadows `myVar` from line 1.

---

3. Local vs Global Part 3

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
var myVar = 'This is global';

function someFunction() {
  myVar = 'This is local';
}

someFunction();
console.log(myVar);
```

### Solution

This logs `This is local` because `myVar` from line 1 is reassigned the string `'This is local'` on line 4 inside `someFunction()`.

---

4. Variable Lookup

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
var myVar = 'This is global';

function someFunction() {
  console.log(myVar);
}

someFunction();
```

### Solution

This logs `This is global` because functions are able to access variables declared in outer scopes. When `myVar` is referenced within `someFunction()` on line 4, JavaScript first searches the immediate local scope of `someFunction()`; when it doesn't find a local `myVar`, it searches its closure's environment, where it finds a pointer to the global `myVar` variable.

---

5. Variable Scope

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
function someFunction() {
  myVar = 'This is global';
}

someFunction();
console.log(myVar);
```

### Solution

This logs `This is global` because JavaScript creates a new `myVar` global variable on line 2. When evaluating the assignment on line 2, JavaScript does not find an existing `myVar` variable, so it makes a global one (several points in the material have hinted that this is actually a "property of the global object" which will be discussed later.)

---

6. Arguments Part 1

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
let a = 7;

function myValue(b) {
  b += 10;
}

myValue(a);
console.log(a);
```

### Solution

This logs `7` because the reassignment on line 4 only affects the local variable `b`. The outer variable `a` still holds a value of `7`, which is logged on line 8.

#### Adjustments based on the provided solution

The reassignment on line 4 doesn't affect `a` because `a` holds a primitive value (a number), which are immutable.

---

7. Arguments Part 2

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
let a = 7;

function myValue(a) {
  a += 10;
}

myValue(a);
console.log(a);
```

### Solution

The answer is still the same as the previous problem, with one addition: this code logs `7` because `a` holds a primitive value, which are immutable and therefore are unaffected by reassignment after being passed as an argument to a function. Additionally, there are two `a` variables: the outer `a` declared on line 1 and the function parameter `a` on line 3/local variable on line 4. Inside the `myValue` function, the local variable `a` shadows the outer variable `a`.

---

8. Arguments Part 3

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
let a = [1, 2, 3];

function myValue(b) {
  b[2] += 7;
}

myValue(a);
console.log(a);
```

### Solution

This logs `[1, 2, 10]` because objects are not immutable. While reassigning a variable that points to an object is not a mutating operation, reassigning an element within an object is.

---

9. Variable Declarations

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
console.log(a);

var a = 1;
```

### Solution

This logs `undefined` because `var a` on line 3 is hoisted to the start of the snippet, although the assignment of the value `1` to variable `a` remains in its original location. As a result, when logging `a` on line 1, it evaluates to `undefined` since it was declared with `var`.

---

10. Function Declarations

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
logValue();

function logValue() {
  console.log('Hello, world!');
}
```

### Solution

This logs `Hello, world!` again because of hoisting. The function declaration for `logValue()` is hoisted to the start of the snippet.

#### Further Exploration

Let's refactor the code a bit. What does it log now? What is the hoisted equivalent of this code?

```javascript
var logValue = 'foo';

function logValue() {
  console.log('Hello, world!');
}

console.log(typeof logValue);
```

For insight into the answer to this question, revisit the [lesson on hoisting](https://launchschool.com/lessons/7cd4abf4/assignments/510e62bb). ([Alternate link if the previous link doesn't work](https://launchschool.com/lessons/511a561c/assignments/529cf31a)).

##### FE Solution

This logs `string` because function declarations are hoisted above variable declarations. The hoisted code looks like:

```javascript
function logValue() {
  console.log('Hello, world!');
}

var logValue = 'foo';

console.log(typeof logValue);
```
