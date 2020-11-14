
# Function Declarations and Function Expressions - 10/23/2020

## Function Declarations

```javascript
function hello() {
  return 'Hello world!';
}

console.log(typeof(hello));   // logs: function
```

A function declaration (sometimes called a "function statement") defines a variable (`hello` in this case) whose type is `function`. It does not require assignment to a variable. The value of the function variable is the function itself. This "functional variable" obeys general scoping rules and we can use it exactly like other JavaScript variables:

```javascript
function outer() {
  function hello() {
    return 'Hello world!';
  }

  return hello();
}

console.log(typeof hello);   // can't access local function scope from here

const foo = outer;           // assign the function to a constant
foo();                       // we can then use the constant to invoke the function
```

Function declarations are similar to variable declarations. Just as variable declarations must start with `let` or `const`, function declarations must start with `function`.

> It's important to realize that a function **declaration** not only creates a function but also creates a variable with the same name as the function and then assigns the function to it. Thus, for every function declaration, a variable is initialized.

## Function Expressions

A function expression defines a function as part of a larger expression syntax (typically a variable assignment.)

```javascript
const hello = function () {     // we can also use let instead of const
  return 'hello';
};                              // note the semicolon!

console.log(typeof hello);      // function
console.log(hello());           // hello
```

Above, we define an anonymous function (one without a name) and assign it to the variable `hello`. We then use the variable to invoke the function.

```javascript
let foo = function () {
  return function () {
    return 1
  };                            // note the semicolon!
};                              // note the semicolon!

let bar = foo();                // bar is assigned to the returned function
bar();                          // 1
```

Above, the anonymous function `foo` returns another anonymous function.

### Named Function Expressions

We can also name function expressions like this:

```javascript
let hello = function foo() {
  console.log(typeof foo);     // function
};

hello();

foo();                         // Uncaught ReferenceError: foo is not defined
```

However, the name is only available inside the function (it can only be used from within the function's local scope.) While most function expressions use anonymous functions, named function expressions can be useful for:

* debugging (the function's name will appear in the debugger's call stack)
* recursive functions

Named function expressions look very similar to function declarations, but you can tell them apart by: if a *statement* begins with the `function` keyword, it's a function declaration; otherwise, it's a function expression. Even just adding parentheses turns a function declaration into a function expression:

```javascript
function foo() {
  console.log('function declaration');
}

(function bar() {
  console.log('function expression');
});

foo();     // function declaration
bar();     // Uncaught ReferenceError: bar is not defined
```

A function defined using a function declaration must always have a name (it cannot be an anonymous function.)

### Arrow Functions

Arrow functions are a popular addition in ES6; you can think of them as a shorthand for writing function *expressions*. Here is an example of a function expression and then the arrow function version of it:

```javascript
// function expression
const multiply = function (a, b) {
  return a * b;
};

// arrow function
const multiply = (a, b) => {
  return a * b;
};
```

All we've changed so far is removing the word `function` and adding an arrow `=>`. This isn't very beneficial and arguably reduces readability, but we can make two more modifications to an arrow function when its body is only a single line:

1. eliminate the braces and write the entire function on a single line
2. remove the `return`

```javascript
const multiply = (a, b) => a * b;
```

If you have lots of short functions like `multiply`, this is starting to look convenient. It's cryptic if you're unfamiliar with arrow function syntax, but it becomes comfortable and familiar with practice.

Arrow functions are most often used as **callback functions**:

```javascript
[1, 2, 3].map(function (element) {
  return 2 * element;
});
// returns [2, 4, 6]
```

Here, the anonymous function passed to `map` is our **callback function**. We can simplify this by using an arrow function.

Also, if an arrow function has only one parameter, you can omit the parentheses from the parameter list:

```javascript
[1, 2, 3].map(element => 2 * element);
// [2, 4, 6]
```

Arrow functions have another usethat makes them popular: they inherit the "execution context" from the surrounding code. This probably doesn't mean anything yet; we'll discuss it further in a later course.

## Style Notes

You should be familiar with all three styles (function declarations, function expressions, and arrow functions), because you will encounter them all in the real world and throughout our courses. For your own code, we recommend:

* use arrow functions for callbacks
* use function declarations or function expressions for other functions, but choose one and be consistent
* if you use function expressions, named function expressions are betterfor debugging purposes and clear intent
