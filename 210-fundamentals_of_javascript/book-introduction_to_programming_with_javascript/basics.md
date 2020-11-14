
# The Basics - 10/14/2020

## Data Types

JavaScript has five **primitive data types**:
* String
* Number
* Undefined
* Null
* Boolean

> ES6 introduces two more: Symbol and BigInt. We don't currently cover them at Launch School.

### Strings

* you may use single or double quotes
* you can escape a character (e.g. a single quote in a single quoted string) with backslash `\`:

```javascript
> "He said, 'Hi there!'"    // with double quotes
= "He said, 'Hi there!'"

> 'He said, \'Hi there!\''  // with single quotes and escaping
= "He said, 'Hi there!'"
```

A recent addition is **string interpolation** within backticks \`:

```javascript
> `5 plus 5 equals ${5 + 5}`
= '5 plus 5 equals 10'
```

> As a recent addition, it won't work in older versions of JavaScript/older browsers.

### Numbers

Some programming languages have multiple types to represent different kinds of numbers; this is not the case in JavaScript. The `Number` data type represents all types of real numbers (integers, floating point, decimals, etc.)

You can't use commas or European style periods for grouping: `123456.78`, not `123,456.78` or `123.456,78`.

> A recent update allows underscores for grouping, e.g. `123_456.78`, but this isn't widely supported yet.

### Booleans

`true` or `false`

### Undefined

* represents the absence of a value
* often occurs when functions don't return an explicit value or when assigning variables:

```javascript
> console.log("Hello, World!")
Hello, World!
= undefined

> let foo
= undefined

> foo
= undefined

> let bar = 3
= undefined

> bar
= 3
```

### Null

* represents emptiness or nothing
* very similar to `undefined`
* main difference from `undefined` is that `null` must be used explicitly, while `undefined` often occurs implicitly

## The typeof Operator

Every value you use in your JavaScript programs has a data type. To see what type a particular value has, you can use the `typeof` operator. `typeof` returns a string that contains the type of its operand's value. For example:

```javascript
> typeof 1
= 'number'

> typeof 'foo'
= 'string'

> typeof true
= 'boolean'

> typeof undefined
= 'undefined'

> typeof null
= 'object'

> typeof [1, 2, 3]
= 'object'
```

We can make a couple of observations here.

* We can see that the value `undefined` has type `'undefined'`. The name of the type and the value are distinct. The `'undefined'` type has one possible value: `undefined`. To make this clearer, we sometimes write `Undefined` (with a capital U) when referring to the type name. However, the `typeof` operator doesn't make this distinction.
* For some bizarre reason, `null`'s type is `'object'`. No, that's not a typo: `typeof null` returns `'object'`! This oddity is, in fact, a mistake in JavaScript itself. It goes back to the first version of the language, which took but 10 days to develop. Subsequent implementations preserved the error, and now we're stuck with it. Fixing it would break too many applications.
* If you search the Internet, you'll eventually find some sites that claim that `null` is actually an object -- primarily because of this issue. Even MDN says it is an object on at least one page, but elsewhere claims it is a primitive value. In the end, the ECMAScript standards document describes `null` as a primitive value. Therefore, you should treat it as a primitive value.
* Another peculiarity is that the type of an array (`[1, 2, 3]` is an example) is also `'object'`. This makes some sort of sense since, in JavaScript, arrays *are* objects. They just have some special characteristics. (We will meet arrays later and revisit this point.)

## The Remainder Operator

Note that JavaScript's `%` operator computes the remainder of dividing two numbers; it does not compute the modulo value, nor does it have any built-in methods that will compute the modulo value. In mathematics, there is a subtle, but important, difference between modulo and remainder operations. We won't get into the [mathematical definitions](https://math.stackexchange.com/questions/801962/difference-between-modulus-and-remainder), but the effect can be summarized as follows:

* Remainder operations return a positive integer when the first operand is positive, and a negative integer when the first operand is negative.
* Modulo operations return a positive integer when the second operand is positive, and a negative integer when the second operand is negative.

We can see this definition at work in this table:

|a   | b  | a % b (remainder) | a modulo b |
|----|----|-------------------|------------|
|17  | 5  | 2                 | 2          |
|17  | -5 | 2                 | -3         |
|-17 | 5  | -2                | 3          |
|-17 | -5 | -2                | -2         |

Avoid this problem if possible: try to work with positive integers only; if that's not possible, make sure you know what you need and what's happening.

## Not A Number (NaN)

Some operations such as `0 / 0` return the value `NaN` for "Not a Number". This is a special value that signals an invalid operation on numbers. Curiously, let's look at `NaN`'s type:

```javascript
> typeof(NaN);
= 'number'
```

How is "Not a Number" of type `'number'`? It's helpful to think of `NaN` as a *numeric* result that indicates an error has occurred.

Also note that `NaN` is not equal to itself:

```javascript
> NaN === NaN;
= false
```

To compare `NaN`, use `Number.isNan` or `Object.is`:

```javascript
> let value = NaN;
> Number.isNaN(value)
= true

> Object.is(value, NaN)
= true
```

## Infinity

* represents a number of infinite magnitude
* there is also negative infinity: `-Infinity`
* `Infinity` is practically similar to `NaN`, although they represent different things
* `Infinity` results from some mathematical operations, such as `1 / 0`
* `Infinity` can be compared to itself:

```javascript
> Infinity === Infinity
= true
```

* `Infinity` has some interesting properties:

```javascript
> Infinity * Infinity
= Infinity

> Infinity + Infinity
= Infinity

> Infinity - Infinity
= NaN

> Infinity / Infinity
= NaN

> 1234567890 / Infinity
= 0
```

## Equality Comparison

For now, use `===` rather than `==`. We'll discuss the differences later.

### String Concatenation

Concatenate strings with `+`:

```javascript
> 'foo' + 'bar'
= 'foobar'
```

What if you mix strings and numbers, or attempt to perform arithmetic on a string?

```javascript
> '1' + '2'
= '12'

> '1' + 2
= '12'

> '5' - 3
= 2
```

JavaScript is coercing the `Number` to a `String`. These examples showcase **implicit type coercion**. We'll discuss coercion further.

## Explicit Coercion

With **implicit** coercion as we just saw, the JavaScript engine decides how to adjust the types of the arguments. With **explicit** coercion, we decide ourselves:

### Strings to Numbers

Use `Number()` or `parseInt()`.

```javascript
> Number('1')
= 1

> Number('foo')
= NaN
// **NB**: no error!!

> parseInt('12')
= 12
```

`Number()` allows signs and decimals but no invalid characters:

```javascript
> Number('-12.345')
= -12.345

> Number('123abc456')
= NaN
```

`parseInt()`'s argument can start with digit, `=`, or `-`; parsing stops at invalid characters:

```javascript
> parseInt('-12')
= -12

> parseInt('123abc456')
= 123
```

`parseInt()` won't do decimals; use `parseFloat()` instead:

```javascript
> parseInt('12.345')
= 12

> parseFloat('12.345')
= 12.345
```

### Numbers to Strings

Use `String()`.

```javascript
> String(20)
= '20'

> String(-123.456)
= '-123.456'
```

## Data Structures

Data structures are also commonly referred to as complex data types. The two most common in JavaScript are **arrays** and **objects**.

### Arrays

* Arrays are ordered lists.
* They may contain any other data type.
* Array literals use square brackets `[ ]`: `[1, 2, 3, 4, 5]`.
* Arrays are zero indexed.
* Array elements are accessed by `[index]`.

### Objects

* Objects are dictionary-like collections of key-value pairs.
* Similar to hashes, dictionaries, or associative arrays in other languages.
* Literals use curly braces `{ }`.
* Keys are strings (quotes may be omitted).
* Keys and values are delimited with a colon `:`.
* Values are accessed by `[key]` (quotes are needed here.)

```javascript
> { dog: 'barks', cat: 'meows', pig: 'oinks' }
= { dog: 'barks', cat: 'meows', pig: 'oinks' }
```

## Expressions and Return Values

* An **expression** is anything that JavaScript can evaluate to a value (even if that value is `undefined` or `null`.)
* Expressions always evaluate to a value (a **return value**.)
* Almost everything you write in JavaScript is an expression.
* Like in mathematics, return values can be used as part of another expression:

```javascript
> 7 + (5 + 2)
= 14
```

`5 + 2` is an expression that evaluates to a value of `7` and is then used in another expression, `7 + 7`.


* Expressions don't have to involve operators; any value is an expression that evaluates to itself:

```javascript
> "hi"
= hi
```

### printing/logging vs. return value

Printing (frequently called logging in JavaScript) is not the same as returning a value. This is a very important distinction:

```javascript
> console.log('Howdy')
Howdy
= undefined
> ```

The above code **prints** or **logs** `Howdy`, but its **return value** is `undefined`.

## Statements

JavaScript also has **statements** (a complete list can be found [here on MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements)); a common example is a variable declaration:

```javascript
> let foo
= undefined
```

* Statements always evaluate to `undefined`.
* Satements cannot be used as part of an expression, but...
* an expression may be used as part of a statement:

```javascript
> 5 * let foo
SyntaxError: Unexpected identifier

> console.log(let bar)
SyntaxError: missing ) after argument list

> let foo = (4 + 2)
= undefined
> foo
= 6
```

### Expressions vs. Statements

Unfortunately, the term "statement" isn't as well defined as the MDN page makes it seem. Most programmers use the term "statement" loosely to refer to a syntactic unit of code that expresses an action for the computer to perform. Everything in MDN's list conforms to this description, but their list is not complete. Consider assignment: `finalValue = firstValue + secondValue;`

MDN's list does not include assignment, but the above example fits our description of a statement. It's also an expression (containing other expressions - there are four total:)

1. firstValue
2. secondValue
3. firstValue + secondValue
4. finalValue = firstValue + secondValue

A simple function or method call is also a statement and an expression: `console.log('Hello');`

1. `console`
2. `console.log`
3. `'Hello'`
4. `console.log('Hello')`

You can usually refer to any single line of code as a statement, but be aware that a statement can also span multiple lines or multiple statements can be contained on a single line:

```javascript
// one statement on multiple lines
theFinalValue = (firstValue + secondValue) *
                (thirdValue - forthValue) / fifthValue;

// multiple statements on one line
const hello = "Hello"; console.log(hello);
```

We will use "statement" somewhat loosely, but bear the distinction between statements and expressions in mind as it will sometimes be crucial. Expressions can be part of a statement, but not every statement is an expression.

## Exercises

1. Concatenate two or more strings, one with your first name and one with your last, to create a string with your full name as its value. For example, if your name is John Doe, think about how you can put `'John'` and `'Doe'` together to get `'John Doe'`.

### Solution

```javascript
> 'Tim' + ' ' + 'Cummings'
= 'Tim Cummings'
```

---

2. Use the arithmetic operators to determine the individual digits of a 4-digit number like `4936`:

1. thousands place is `4`
2. hundreds place is `9`
3. tens place is `3`
4. ones place is `6`

> Hint 1: Use `number % 10` to determine the rightmost digit. Then use that value and `%` again to get the tens digit. Repeat until you have all 4 digits.

> Hint 2: Once you have the ones digit from the previous hint, subtract it from the current number, then divide the result by 10. Repeat hint 1 to get the next digit.

### Solution

```javascript
let x = 4936;
let ones = x % 10;

x = (x - ones) / 10;
let tens = x % 10;

x = (x - tens) / 10;
let hundreds = x % 10;

x = (x - hundreds) / 10;
let thousands = x;

thousands
= 4

hundreds
= 9

tens
= 3

ones
= 6
```

---

3. Identify the data type for each of the following values:

* `'true'`
* `false`
* `1.5`
* `2`
* `undefined`
* `{ foo: 'bar' }`

### Solution

* `'true'`: String
* `false`: Boolean
* `1.5`: Number
* `2`: Number
* `undefined`: Undefined
* `{ foo: 'bar' }`: Object

---

4. Given the code below, identify which lines are statements and which are expressions:

```javascript
let foo;
foo = 5;
foo;
```

### Solution

lines 1 and two are statements
line 2 has three expressions: `foo`,`5`, and `foo = 5`
line 3 is an expression

#### Adjustments based on provided solution

Line 2 is an expression; it evaluates to `5`. Statements always evaluate to `undefined`.

---

5. Explain why this code logs `'510'` instead of `15`.

```javascript
console.log('5' + 10);
```

### Solution

This code logs `'510'` instead of `15` because of implicit type coercion. Because there is a string argument (`'5'`) with the addition operator, it coerces the number `10` to a string and performs string concatenation instead of numeric addition.

---

6. Refactor the code from the previous exercise to use explicit coercion, so it logs `15` instead.

### Solution

```javascript
console.log(Number('5') + 10);
```

---

7. Use the template literal syntax along with the expression `Number('5') + 10` to log the following sentence to the console: `The value of 5 + 10 is 15.`

### Solution

```javascript
console.log(`The value of 5 + 10 is ${Number('5') + 10}.`)
```

---

8. Will an error occur if you try to access an array element with an index that is greater than or equal to the length of the array? For example:

```javascript
let foo = ['a', 'b', 'c'];
foo.length;  // returns 3
foo[3];      // will this result in an error?
```

### Solution

No, it returns `undefined`.

---

9. Create an array named `names` that contains a list of pet names. For instance:

| Name         |
|--------------|
| asta         |
| butterscotch |
| pudding      |
| neptune      |
| darwin       |

You can use that data or make up your own.

### Solution

```javascript
let names = ['asta', 'butterscotch', 'pudding', 'neptune', 'darwin']
```

---

10. Create an object named `pets` that contains a list of pet names and the type of animal. For instance:

| Name         | Animal |
|--------------|--------|
| asta         | dog    |
| butterscotch | cat    |
| pudding      | cat    |
| neptune      | fish   |
| darwin       | lizard |

You can use that data or make up your own.

### Solution

```javascript
let pets = { asta: 'dog', butterscotch: 'cat', pudding: 'cat', neptune: 'fish', darwin: 'lizard' };
```

---

11. What value does the following expression evaluate to?

`'foo' === 'Foo'`

### Solution

False. String comparison is case-sensitive.

---

12. What value does the following expression evaluate to?

`parseInt('3.1415')`

### Solution

`3`. `parseInt()` stops evaluation when encountering the first invalid character, such as `.`.

---

13. What value does the following expression evaluate to?

`'12' < '9'`

### Solution

True. It appears that string comparison is character by character, and `'1'` is less than `'9'`.
