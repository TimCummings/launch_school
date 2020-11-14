
# Hoisting - 10/22/2020

## What is Hoisting?

JavaScript engines operate in two main phases: **creation** and **execution**. The execution phase is when the program runs code line-by-line. However, before execution begins, the creation phase does some preliminary work, such as finding all variable, function, and class *declarations* and effectively moving them to the top of their respective function or block: function-scoped declarations are moved to the top of the function, and block-scoped declarations are moved to the top of the block. This process is called **hoisting**, and is why this works:

```javascript
console.log(getName());

function getName() {
  return "Pete";
}
```

During the creation phase, JavaScript finds the `getName` function declaration and hoists it to the top of the program. The code above effectively is rearranged to:

```javascript
function getName() {
  return "Pete";
}

console.log(getName());
```

> At the top level of a program, outside of any function, function scope refers to the entire file. Some people use the term **global scope** to refer to function scope at the top level, but this isn't quite accurate, especially in Node.js. A better term is **module scope**. We'll use function scope unless we need to be more specific.

It's important to realize that JavaScript doesn't change the program; it just executes the program in a manner that acts as though it was changed.

## The Temporal Dead Zone

Variables declared with `let`, `const`, and `var` statements are hoisted, but `var` has a major difference:

* When a `var` variable is hoisted, JavaScript gives it an initial value of `undefined`.
* When `let` and `const` variables are hoisted, they are not given an initial value at all; they are left in an "unset" state - they are "not defined". Don't say "undefined", that's confusing.

If you try to access the value assigned a `var` variable before the original `var` declaration gets executed, JavaScript will return a value of `undefined`:

```javascript
console.log(bar);   // undefined
var bar = 3;
console.log(bar);   // 3
```

If you try to access a `let` or `const` variable before the original declaration gets executed, you'll get an error:

```javascript
console.log(foo);   // Uncaught ReferenceError: Cannot access 'foo' before initialization
let foo;
```

Such unset variables are said to be in the **Temporal Dead Zone** (TDZ).

Note that the error message is different if you don't declare `foo` at all.

```javascript
console.log(foo);   // Uncaught ReferenceError: foo is not defined
```

## Hoisting for Function Declarations

JavaScript also hoists function declarations, including the body, to the top of its scope:

```javascript
console.log(hello());

function hello() {
  return 'Hello world!';
}
```

is equivalent to:

```javascript
function hello() {
  return 'Hello world!';
}

console.log(hello());
```

Function declarations have function scope - hoisting also occurs with nested functions:

```javascript
function foo() {
  return bar();

  function bar() {
    return 42;
  }
}

foo();   // 42
```

> Though JavaScript has function scope, function hoisting has undefined behavior when the function is nested inside a non-function block, such as `if` and `while` statements:
>
> ```javascript
> function foo() {
>   if (true) {
>     function bar() {
>       console.log("bar");
>     }
>   } else {
>     function qux() {
>       console.log("qux");
>     }
>   }
>
>   console.log(bar);
>   bar();
>
>   console.log(qux);
>   qux();
> }
>
> foo();
> ```
>
> The output of the above code differs depending on the JavaScript implementation. The more likely output is:
>
> ```
> [Function: bar]
> bar
> undefined
> TypeError: qux is not a function
> ```
>
> This indicates that both `bar` and `qux` were hoisted to the top of the function, but the definition of `qux` was not. In effect, we have a TDZ with a function declaration.
>
> Other implementations may output:
>
> ```javascript
> [Function: bar]
> bar
> [Function: qux]
> qux
> ```
>
> or
>
> ```javascript
> undefined
> TypeError: bar is not a function
> ```
>
> or even a syntax error.
>
> Since the behavior is so unpredictable, avoid nesting function declarations inside non-function blocks.

## Hoisting for Function Expressions

Function expressions that involve assigning a function to a declared variable are still just variable declarations and obey the same hoisting rules. See steps 5 and 8 of Declaration Binding in the [documentation](http://www.ecma-international.org/ecma-262/5.1/#sec-10.5) for more detailed info. These two snippets are equivalent:

```javascript
console.log(hello());

var hello = function () {
  return 'Hello world!';
};
```

```javascript
var hello;

console.log(hello());   // raises `Uncaught TypeError: hello is not a function`

hello = function () {
  return 'Hello world!';
};
```

## Hoisting Variable and Function Declarations

When both a variable and a function declaration exist, assume the function declaration is hoisted first / hoisted above the variable declaration. The following two snippets are equivalent:

```javascript
bar();   // logs undefined
var foo = 'hello';

function bar() {
  console.log(foo);
}
```

```javascript
function bar() {
  console.log(foo);
}

var foo;

bar();   // logs undefined
foo = 'hello';
```

Consider what happens when a function and variable use the same name:

```javascript
// Snippet 1
bar();   // logs "world"
var bar = 'hello';

function bar() {
  console.log('world');
}
```

vs.

```javascript
// Snippet 2
var bar = 'hello';
bar();   // raises `Uncaught TypeError: bar is not a function`

function bar() {
  console.log('world');
}
```

Compare the above snippets with their hoisted versions; notice that there's no longer a variable declaration since that would be redundant, just reassignment.

```javascript
function bar() {
  console.log('world');
}

bar();
bar = 'hello';
```

```javascript
function bar() {
  console.log('world');
}

bar = 'hello';
bar();
```

> You can't declare a `let` or `const` variable and a function with the same name:
>
> ```javascript
> let foo = 3;
> function foo() {};   // Uncaught SyntaxError: Identifier 'foo' has already been declared
> ```
>
> ```javascript
> function foo() {};
> let foo = 3;         // Uncaught SyntaxError: Identifier 'foo' has already been declared
> ```

## Best Practices to Avoid Confusion

* Whenever possible, use `let` and `const` instead of `var`.
  * Declare `let` and `const` variables as close to their first usage as possible.
* If you must use `var`, declare all of the variables at the top of the scope.
* Declare functions before calling them.

## Hoisting isn't Real

Hoisting is just a mental model that almost all JavaScript developers use to explain how scope works in the language. JavaScript does not rearrange your code, but it's a helpful mental model for understanding the effects of JavaScripts two phases of execution.

> In the remainder of the curriculum, we will talk about hoisting as though it were a real process. You should consider that as a given in future assignments, quizzes, and assessments. If we ask you about something involving hoisting, don't try to argue that there is no such thing.

For more hoisting examples, check out [this blog](https://javascriptweblog.wordpress.com/2010/07/06/function-declarations-vs-function-expressions/).
