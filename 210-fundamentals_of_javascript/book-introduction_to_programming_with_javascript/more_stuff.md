
# More Stuff - 10/20/2020

There are other things that don't fit elsewhere but still need to be covered.

## Variables as Pointers

With JavaScript, we use the terms **pointers** and **references** interchangeably.

Recall that JavaScript values fall into one of two general types: primitive or complex.

### Primitives as pass-by-value

```javascript
> let a = 5
> let b = a
> a = 8
> a
= 8

> b
= 5
```

Variables with primitive values store those values in the variable (they're pass-by-value.)

> In reality, string values aren't stored in the variables, but they **act** like they are.

### Objects and non-mutating operations

These also act like pass-by-value, even though they aren't.

### Objects and mutating operations

Mutating operations on objects reveal that objects are pass-by-reference. Their values get stored in a region of memory known as the **heap**. Changes to a value in the heap are reflected by every variable pointing to it.

## Regular Expressions

* JavaScript **regex** appear similar to strings but with enclosing slashes instead of quotes: `/bob/`.
* RegExp objects are used to store regex. Like other objects, they can invoke methods.
  * `test` is a good one for checking matches:

```javascript
> /o/.test('bobcat');
= true

> /l/.test('bobcat');
= false
```

  * if a boolean return value isn't enough, use `Strin.prototype.match()` which returns an array of information about the match:
    * because it returns `null` when there's no match, it can also be used in conditionals, like `test`

```javascript
// no match
> "bobcat".match(/x/);
= null

// global match
> "bobcat".match(/[bct]/g);
= [ 'b', 'b', 'c', 't' ]

// singular match with groups
> "bobcat".match(/b((o)b)/);
= [ 'bob', 'ob', 'o', index: 0, input: 'bobcat', groups: undefined ]
```

Be aware that mixing `RegExp.prototype.test()` with the `g` global regex option can cause confusing results. The number of matches are tracked and reset after a false match:

```javascript
let regex = /b/g;
let str = "ababa";

console.log(regex.test(str)); // Prints true
console.log(regex.test(str)); // Prints true
console.log(regex.test(str)); // Prints false <==
```

## The Math Object

If you find you have math needs beyond basic arithmetic, see if the Math object can help:

```javascript
> Math.sqrt(36)
= 6

> Math.sqrt(2)
= 1.4142135623730951

> Math.PI
= 3.141592653589793
```

## Dates

Similar to Math, if you find yourself working with dates and times, the Date constructor and the objects it produces have lots of helpful methods:

```javascript
> let date = new Date('December 25, 2012')
> date.getDay()
= 2

// we have to do some extra work to turn 2 into a meaningful day name
function getDayOfWeek(date) {
  let daysOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  return daysOfWeek[date.getDay()];
}

console.log(getDayOfWeek(date)); // logs Tuesday
```

> After seeing that we had to implement `getDayOfWeek()`, you might think that JavaScript's developers somehow forgot to include such a useful method. They did, at least in the earliest versions of JavaScript. These days, you can use the `toLocaleDateString` method of the `Date` type. It's a bit awkward to use, but it has multi-language support and a host of other features. However, full support may be lacking in some browsers.

## Exceptions

JavaScript is less strict than some other languages and "fails silently" in many cases by returning a result such as `NaN`, `undefined`, `null`, or `-1`. In cases where it doesn't fail silently, JavaScript will throw or raise an exception.

Exceptions are handled in JavaScript with `try/catch` statements, and sometimes `finally`:

```javascript
try {
  // perform an operation that may produce an error
} catch (exception) {
  // an error has occurred. do something about it here.
  // for example, log the error
} finally {
  // Optional 'finally' block; not used often
  // Executes even if an exception occurs.
}
```

```javascript
let names = ['bob', 'joe', 'steve', undefined, 'frank'];

names.forEach(name => {
  try {
    console.log(`${name}'s name has ${name.length} letters in it.`);
  } catch (exception) {
    console.log('Something went wrong');
  }
});

// Log output
// bob's name has 3 letters in it.
// joe's name has 3 letters in it.
// steve's name has 5 letters in it.
// Something went wrong
// frank's name has 5 letters in it.
```

You can raise your own exceptions with the `throw` keyword and [one of these error types](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error).

```javascript
function foo(number) {
  if (typeof number !== "number") {
    throw new TypeError("expected a number");
  }

  // handle case where the argument really is a number
}
```

### SyntaxError

In most cases, a `SyntaxError` occurs after a JavaScript program loads but before it runs. These, as the name implies, are usually due to a typo, such as a missing `}`. In some situations these can occur after a program has started running, e.g. `JSON.parse('not really JSON');  // SyntaxError: Unexpected token i in JSON at position 0`.

## Exercises

1. What does this code log to the console? Why?

```javascript
let array1 = [1, 2, 3];
let array2 = array1;
array1[1] = 4;
console.log(array2);
```

### Solution

This logs `[ 1, 4, 3 ]` because the array is mutated on line 3 - one of its elements is reassigned to a different value. `array1` and `array2` are variables that point to the same object.

---

2. What do the following error message and stack trace tell you?

```
$ node exercise2.js
/Users/wolfy/tmp/exercise2.js:4
  console.log(greeting);
              ^

ReferenceError: greeting is not defined
    at hello (/Users/wolfy/tmp/exercise2.js:4:15)
    at Object.<anonymous> (/Users/wolfy/tmp/exercise2.js:13:1)
    at Module._compile (internal/modules/cjs/loader.js:721:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:732:10)
    at Module.load (internal/modules/cjs/loader.js:620:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:560:12)
    at Function.Module._load (internal/modules/cjs/loader.js:552:3)
    at Function.Module.runMain (internal/modules/cjs/loader.js:774:12)
    at executeUserCode (internal/bootstrap/node.js:342:17)
    at startExecution (internal/bootstrap/node.js:276:5)
```

### Solution

The `greeting` variable that is passed to `console.log` on line 4 of the `exercise2.js` file has not been defined.

---

3. Write some code to output the square root of 37.

### Solution

`console.log(Math.sqrt(37)); // => 6.082762530298219`

---

4. Given a list of numbers, write some code to find and display the largest numeric value in the list.

| List           | Max |
|----------------|-----|
| 1, 6, 3, 2     | 6   |
| -1, -6, -3, -2 | -1  |
| 2, 2           | 2   |

### Solution

```javascript
function findMax(numbers) {
  return numbers.reduce(function(max, number) {
    return (number > max) ? number : max;
  });
}

console.log(findMax([1, 6, 3, 2])); // => 6
console.log(findMax([-1, -6, -3, -2])); // => -1
console.log(findMax([2, 2])); // => 2
```

#### Adjustments based on provided solution

The `Math` object has a `max` method:

```javascript
console.log(Math.max(1, 6, 3, 2));      // 6
console.log(Math.max(-1, -6, -3, -2));  // -1
console.log(Math.max(2, 2));            // 2
```

---

5. What does the following function do?

```javascript
function doSomething(string) {
  return string.split(' ').reverse().map((value) => value.length);
}
```

> Hint: Don't hesitate to use the MDN Documentation.

### Solution

This function:

1. takes a string argument
2. turns it into an array of strings that is split as spaces
3. reverses the array of strings
4. and finally returns a new array of numbers which are the lengths of the strings from the previous step

---

6. Write a function that searches an array of strings for every element that matches the regular expression given by its argument. The function should return all matching elements in an array.

**Example**

```javascript
let words = [
  'laboratory',
  'experiment',
  'flab',
  'Pans Labyrinth',
  'elaborate',
  'polar bear',
];

allMatches(words, /lab/); // ['laboratory', 'flab', 'elaborate']
```

### Solution

```javascript
function allMatches(words, pattern) {
  return words.filter(word => pattern.test(word));
}

let words = [
  'laboratory',
  'experiment',
  'flab',
  'Pans Labyrinth',
  'elaborate',
  'polar bear',
];

allMatches(words, /lab/); // ['laboratory', 'flab', 'elaborate']
```

---

7. What is exception handling and what problem does it solve?

### Solution

Exception handling is the process of trying potentially problematic code and catching a specific type of error so that the program is able to recover from specific exceptional circumstances instead of crashing.

---

8. **Challenging Exercise** This exercise has nothing to do with this chapter. Instead, it uses concepts you learned earlier in the book. If you can't figure out the answer, don't worry: this question can stump developers with more experience than you have.

Earlier, we learned that `Number.isNaN(value)` returns `true` if, and only if, `value` is the `NaN` value. It returns `false` otherwise. You can also use `Object.is(value,` NaN) to make the same determination.

Without using either of those methods, write a function named `isNotANumber` that returns `true` if the value passed to it as an argument is `NaN`, `false` if it is not.

### Solution

NaN is of type number and evaluates to false. 0 also evaluates to false, but all other numbers should evaluate to true. Therefore, if a value is a number, is not equal to zero, and evaluates to false, it should be NaN.

```javascript
function isNotANumber(value) {
  // NaN is of type 'number'
  if (typeof(value) !== 'number') return false;
  // NaN and zero evaluate to false
  if (!!value) return false;
  // check for zero
  if (value === 0) return false;
  return true;
}
```

#### Adjustments based on provided solution

`NaN` is also the only value in JavaScript to not `===` itself:

```javascript
function isNotANumber(value) {
  return value !== value;
}
```

---

9. **Challenging Exercise** This exercise has nothing to do with this chapter. Instead, it uses concepts you learned earlier in the book. If you can't figure out the answer, don't worry: this question can stump developers with more experience than you have.

Earlier, we learned that JavaScript has multiple versions of the numeric value zero. In particular, it has `0` and `-0`. These numbers, while being mathematically nonsensical, are distinct values in JavaScript. We won't get into why JavaScript has a `0` and `-0`, but it can be useful in some cases.

There's a problem, however: JavaScript itself doesn't seem to realize that the values are distinct:

```javascript
> 0 === -0
= true

> String(-0)
= '0'
```

Fortunately, you can use `Object.is` to determine whether a value is `-0`:

```javascript
> let value = -0;
> Object.is(value, 0)
= false

> Object.is(value, -0)
= true
```

There are other ways to detect a `-0` value. Without using `Object.is`, write a function that will return `true` if the argument is `-0`, and `false` if it is `0` or any other number.

> Hint: What happens if you divide a non-zero integer by zero? Apply this to the problem of determining whether a value is `-0`.

### Solution

```javascript
function isNegativeZero(value) {
  if (value === 0 && 1 / value === -Infinity) return true;
  return false;
}

console.log(isNegativeZero(-0)); // true
console.log(isNegativeZero(0)); // false
console.log(isNegativeZero(-5)); // false
```

#### Adjustments based on provided solution

The conditional expressions already return boolean values:

```javascript
function isNegativeZero(value) {
  return (value === 0) && (1 / value === -Infinity);
}
```

---

10. **Challenging Exercise** This exercise has nothing to do with this chapter. Instead, it uses concepts you learned earlier in the book. If you can't figure out the answer, don't worry: this question can stump developers with more experience than you have.

Consider this code:

```javascript
let x = "5";
x = x + 1;      // returns "51"
```

Now, consider this code:

```javascript
let y = "5";
y++;
```

What gets returned by `y++` in the second snippet, and why?

### Solution

`y++` in the second snippet returns `5`. The increment operator `++` is not the same as the addition operator `+`. Where the addition operator performs coercion and string concatenation if one value is a string, the increment operator expects a number and coerces non-numeric values to a number. Since this is the post-increment version, it returns 5 instead of 6.
