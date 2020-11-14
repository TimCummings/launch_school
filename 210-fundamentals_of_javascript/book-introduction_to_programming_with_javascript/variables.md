
# Variables - 10/16/2020

In a simple sense, a **variable** is a named area of a program's memory space where it can store data.

*Variable names* are often referred to by the broader term **identifiers**. In JavaScript, identifiers include:
* variable names declared by `let` and `var`
* constant names declared by `const`
* property names of objects
* function names
* function parameters
* class names

The term *variable name* refers to all of these identifiers except property names of objects. However, property names of the **global object** are usually included when discussing variable names. We'll use this inclusive form of variable name, but we'll be specific when there are important differences.

### What Else is a Variable?

* variables declared with `let` and `var`
* constants declared with `const`
* properties of the global object
* function names
* function parameters
* class names

This list looks very similar to our list of variable names, with the main difference being properties limited to only the global object. JavaScript is also unusual in that functions and classes are actually values, and their names are used the same way as more traditional variables.

## Declaring and Assigning Variables

A variable declaration is a statement that asks the JavaScript engine to reserve space for a variable with a particular name and **initializes** it with a value. The preferred way to do this in modern JavaScript is with the `let` keyword:

```javascript
> let firstName
= undefined
```

```javascript
> let a = 4
= undefined

> let b = a
= undefined

> a = 7
= 7

> b
= 4
```

You'll notice that `b` retains the value `4`, even though `a` is now `7`. This example suggests that variables reference values in memory that aren't deeply-linked to each other. If you change one variable, it doesn't change other variables with the same value. Later, we'll see that that isn't always the case, but it serves well as an initial mental model.

## Declaring Constants

The `const` keyword is similar to `let`, but it lets you declare and initialize **constant** identifiers:

```javascript
> const firstName = 'Mitchell'
= undefined

> firstName
= Mitchell
```

Once you initialize a constant, you can't give it another value:

```javascript
> firstName = 'Joe'
TypeError: Assignment to constant variable.
```

Constants store values that remain the same throughout the execution of a program, a block within the program, or a function (we'll talk about blocks shortly, and functions later):

```javascript
const INTEREST_RATE = 0.0783;
```

This code lets you label a value like `0.0783` and makes your code more descriptive and easier to understand. A standard convention when naming constants is to use all uppercase letters and digits in the name; if the name contains multiple words, use underscores to separate the words.

> When we use the terms variable or variable name, we are usually including constants declared by const in that same discussion.

## Variable Scope

* A variable's **scope** determines where it is available in a program.
* The location where a variable is declared determines its scope.
* Variables declared with `let` or `const` have **block scope**.

A block is a related set of statements and expressions between a pair of opening and closing curly braces, e.g.

```javascript
if (expression) { // block starts at {
  doSomething();  // block body
}                 // block ends here
```

> Not everything between curly braces is a block. As you'll see later, the braces that surround a function definition are not normally considered to be blocks, but are instead called function bodies. Likewise, the braces that surround object literals are not blocks, but are simply the object literal. However, there are similarities between blocks, function bodies, and, to a lesser degree, object literals.

In the next example, the condition always evaluates as true, so JavaScript runs the `let` statement on line 2. That code declares a variable `a` and assigns it to the string `'foo'`. However, we get an error on line 5 since `let` creates a block-scoped variable; `a` isn't accessible outside the block.

```javascript
if (1 === 1) {
  let a = 'foo'
  }

console.log(a); // ReferenceError: a is not defined
```

The error tells you that `a` isn't available on line 5. In other words, it isn't in scope outside of the `if` block.

If, on the other hand, you declare the variable outside the `if` block, the variable is available within the block as well as after the block ends.

```javascript
let a = 'foo';
if (1 === 1) {
  a = 'bar';
  }

console.log(a);    // => 'bar'
```

As we can see, this code prints the string `"bar"` since `a` is accessible inside the block. Thus, we can reassign it to a different value inside the block. In other words, this `a` has a broader scope than the `a` variable in the previous example.

Constants declared with `const` have the same scope as variables declared with `let`.

There's a third type of variable declaration that uses the `var` keyword and doesn't use block-scoping. We discuss `var` and variable scoping in more detail in the Launch School courses. For now, `let`, `const`, and block scope are the important takeaways of this section.

### A Common Gotcha

Be sure to always declare your variables and constants with `let` and `const`. JavaScript is a forgiving language, and one of the ways it demonstrates that occurs when you fail to declare a variable or constant. You can create them willy-nilly merely by assigning a variable to a value:

```javascript
p = 'foo';
```

That looks harmless, but JavaScript has some bizarre rules when working with undeclared variables. The most notable rule is that all undeclared variables have global scope: they ignore block and function scope entirely. If your program uses that same variable name in a different scope without declaring it, there's a good chance that it will step on the original variable by changing its content. You don't want that to happen: it's typically difficult to debug, and sometimes fixing it breaks other code.

We discuss this gotcha in more detail in the Core Curriculum.

## Exercises

1. Write a program name `greeter.js` that greets `'Victor'` three times. Your program should use a variable and not hard code the string value `'Victor'` in each greeting. Here's an example run of the program:

```
$ node greeter.js
Good Morning, Victor.
Good Afternoon, Victor.
Good Evening, Victor.
```

### Solution

```javascript
let name = 'Victor';

console.log(`Good Morning, ${name}.`);
console.log(`Good Afternoon, ${name}.`);
console.log(`Good Evening, ${name}.`);
```

---

2. Write a program named `age.js` that includes someone's age and then calculates and reports the future age in 10, 20, 30 and 40 years. Below is the output for someone 20 years old.

```
You are 20 years old.
In 10 years, you will be 30 years old.
In 20 years, you will be 40 years old.
In 30 years, you will be 50 years old.
In 40 years, you will be 60 years old.
```

### Solution

```javascript
let age = 20;

console.log(`You are ${age} years old.`);
console.log(`In 10 years, you will be ${age + 10} years old.`);
console.log(`In 20 years, you will be ${age + 20} years old.`);
console.log(`In 30 years, you will be ${age + 30} years old.`);
console.log(`In 40 years, you will be ${age + 40} years old.`);
```

---

3. What happens when you run the following program? Why do we get that result?

```javascript
{
  let foo = 'bar';
}

console.log(foo);
```

### Solution

The above program throws a reference error: `ReferenceError: foo is not defined`, because `foo` is out of scope on line 5. `foo` isdeclared within a block on line 2 but `console.log` is trying to reference `foo` outside of the block (outside of its scope) on line 5.

---

4. What happens when you run the following code? Why?

```javascript
const NAME = 'Victor';
console.log('Good Morning, ' + NAME);
console.log('Good Afternoon, ' + NAME);
console.log('Good Evening, ' + NAME);

NAME = 'Joe';
console.log('Good Morning, ' + NAME);
console.log('Good Afternoon, ' + NAME);
console.log('Good Evening, ' + NAME);
```

### Solution

The above code throws a type error: `TypeError: Assignment to constant variable.` The code attempts to reassign the constant `NAME` on line 6, which is not allowed.

---

5. Take a look at this code snippet:

```javascript
let foo = 'bar';
{
  let foo = 'qux';
}

console.log(foo);
```

What does this program log to the console? Why?

### Solution

This program logs `bar` to the console because there are two different `foo` variables. The first `foo` on line one is declared outside the block. It can be referenced inside the block until like 3 when the second `foo` is declared, effectively shadowing the first `foo` (preventing it from being referenced inside the block.) The `console.log` on line six is outside the block and so it references the first `foo` from line one (the second `foo` is out of scope outside the block.)

---

6. Will this program produce an error when run? Why or why not?

```javascript
const FOO = 'bar';
{
  const FOO = 'qux';
}

console.log(FOO);
```

### Solution

No, this progam will not produce an error. Just like the previous question, `const` variables are scoped the same way as `let` variables. There are two `FOO` constants. The first from line one is accessible inside the block until the second `FOO` is declared on line three, shadowing the first `FOO`. Since a local block constant is being declared, not reassigned, there is no error.
