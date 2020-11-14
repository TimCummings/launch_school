
# Variables - 10/21/2020

## Naming Variables

* JavaScript is case-sensitive: `myvariable` is not the same as `myVariable`
* variable names can be of any length
* variable names must start with a Unicode letter, an underscore `_`, or a dollar sign `$`
* successive characters may be unicode letters, numbers, underscores, or dollar signs
* it must not be a [reserved word](http://www.ecma-international.org/ecma-262/5.1/#sec-7.6.1.1)

## Declaring Variables

* variables should generally be declared before they are used
* declare variables with `let` and `const` (introduced in ES6)
* `var` is the traditional way to declare variables; it's similar to `let` but has some important differences
  * avoid `var` unless it's already in heavy use or you need to support pre-ES6 environments
  * we'll discuss `var` more later
* once declared, variables have a value of `undefined` until initialized with a different value

## Dynamic Typing

JavaScript is a dynamically typed language: a variable may refer to data of any type.
