
# Strict Mode - 11/8/2020

Due to JavaScript's quirks and potential pitfalls, its normal operation has sometimes been (unofficially) dubbed **sloppy mode**. To help with these issues, without breaking loads of existing code, ES5 introduced **strict mode**. Strict mode prevents certain kinds of errors and syntax; it's easy to use, but you should be aware of how it changes Javascript's behavior (more info in the [LaunchSchool gist](https://launchschool.com/gists/406ba491).

## What Does Strict Mode Do?

Strict mode makes three significant changes:

1. Certain silent errors in sloppy mode are no longer silent: they raise exceptions.
2. Certain code that hinders JavaScript's ability to optimize a program to run faster is prohibited.
3. names and syntax that may conflict with current or future versions of JavaScript are prohibited.

## Enabling Strict Mode

Strict mode may be enabled at the global level of a program or at the function level. To do so, add the **pragma** `"use strict";` at the very beginning of the file or function; it can't be enabled partway through a program or function, and it can't be disabled partway through once it's been enabled. Strict mode is automatically enabled within the body of a class and within modules (more about this in course 225 and 230.)

> A **pragma** is a language construct that tells the compiler/interpreter/translator to process code in a certain way. It's not part of the language.

## Strict Mode Changes

* implicit global variables: The default execution context is set to `undefined` instead of the *global object* (don't worry if you don't know what this means yet.) The result is that assigning a value to an undeclared variable now raises an error instead of silently defining a new global variable (well, a new property on the global object, which acts like a global variable.)
* implicit context in functions (revisit LS gist in course 225)
* forgetting to use `this` (revisit LS gist in course 225)
* leading zeroes: numbers with leading zeroes raise an error instead of being silently interpreted as octal numbers
* prevents you from using function declarations in blocks.
* prevents declaring two function parameters with the same name.
* prevents using some newer reserved keywords, such as `let` and `static`, as variable names.
* prevents you from using the `delete` operator on a variable name.
* forbids binding of `eval` and `arguments` in any way.
* disables access to some properties of the `arguments` object in functions.
* disables the `with` statement, a statement whose use is not recommended even in sloppy mode.

## When Should I Use Strict Mode?

Use strict mode in any new code you write. If you're adding functions to an old codebase, use function-level strict mode. Applying strict mode to an entire file in an old code base could lead to breaking code that otherwise works well enough.
