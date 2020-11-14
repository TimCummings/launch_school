
# Expressions and Statements - 10/21/2020

## Expressions

An expression is any valid code that resolves to a value:

```javascript
'hello';   // a single string is an expression
10 + 13;   // arithmetic operations are expressions
sum = 10;  // assignments are expressions
```

## Increment and Decrement Operators in Expressions

The increment (`++`) and decrement (`--`) operators may appear before their operand (prefix) or after their operand (postfix). When used as a standalone expression, it doesn't matter whether they are prefix or postfix.

When increment or decrement are part of a more complicated expression, prefix or postfix matters greatly:

* If the operator appears before the operand (prefix), JavaScript modifies the operand and *then* evaluates the expression.
* If the operator appears after the operand (postfix), JavaScript evaluates the expression and  *then* modifies the operand.

```javascript
let a;
let b;
let c;

a = 1;
b = a++;  // equivalent to "b = a; a++;". so now b is 1 and a is 2
c = ++a;  // equivalent to "++a; c = a;". so now c is 3 and a is 3
```

## Statements

Unlike expressions, statements always evaluate as `undefined`; you also cannot use a statement as part of another expression. They generally control the execution of the program. For example, variable assignments are expressions, but variable declarations are statements:

```javascript
let a;                // a statement to declare variables
let b;
let c;
let b = (a = 1);      // this works, because assignments are expressions too
let c = (let a = 1);  // this gives an error, since a statement can't be used as part of an expression
```
