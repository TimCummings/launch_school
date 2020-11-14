
# Data Types - 10/21/2020

JavaScript has the following primitive data types:

* number
* boolean
* string
* null
* undefined
* symbols (ES6) - not discussed here
* big integers (ES6) - not discussed here

And one compound data type: objects

Use the `typeof` operator to get the data type of a value:

```javascript
typeof 1.2;        // "number"
typeof 'hello';    // "string"
typeof false;      // "boolean"
typeof undefined;  // "undefined"
typeof { a: 1 };   // "object"
typeof [1, 2, 3];  // "object" (yes: an array is an object)
typeof null;       // "object" (null both is and isn't an object)
```

Be especially aware of the last two. The last one is a bug, but it's established and expected behavior by now and will probably never be fixed.

## Number

* JavaScript uses [double precision floats](https://en.wikipedia.org/wiki/Double-precision_floating-point_format)
* the largest number that can be precisely stored (`Number.MAX_SAFE_INTEGER`)is 9,007,199,254,740,991
* the maximum numeric value that can be represented (`Number.MAX_VALUE`) is 1.7976931348623157e+308
* anything larger is represented as `Infinity`

JavaScript uses a floating point system to represent all numbers. This is unlike other programming languages that have distinct data types to represent integer, float, double, real, or decimal values.

> Floating point values cannot precisely represent values because of how the computer represents them. This is not specific to JavaScript. It is true for all programming languages that store numbers in this manner. A common issue that arises from the use of floating point numbers is that there seems to be slight discrepancies or rounding errors when looking at results. For example:
>
> ```javascript
> 0.1 + 0.2;    // returns 0.30000000000000004, not 0.3!
> ```
>
> The best practice here is to avoid fractional numbers as much as you can. Instead, use an integer number of the smallest relevant units. For example, if you're working with financial numbers, represent the amount in cents. If you're working with time duration, use seconds instead of hours.

Number has a few special values:

* `Infinity`: when you need a number that is greater than any other number.
* `-Infinity`: when you need a number that is less than any other number.
* `NaN`: means "not a number." You will see `NaN` when a math function encounters an error.

## Boolean

`true` or `false`

## String

* no size limit; can contain any amount of text
* surround by single or double quotes (no difference between which you use)
