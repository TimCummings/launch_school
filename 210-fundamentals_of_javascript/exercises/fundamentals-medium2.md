
# JavaScript Language Fundamentals - Medium 2 - 11/5/2020

1. Defaults

The `processOrder` function shown below accepts the following arguments: `price`, `quantity`, `discount`, `serviceCharge` and `tax`. Any arguments other than `price` may be omitted when calling the function, in which case, default values will be assigned.

```javascript
function processOrder(price, quantity, discount, serviceCharge, tax) {
  if (!quantity) {
    quantity = 1;
  }

  if (!discount) {
    discount = 0;
  }

  if (!serviceCharge) {
    serviceCharge = 0.1;
  }

  if (!tax) {
    tax = 0.15;
  }

  return (price * quantity) * (1 - discount) * (1 + serviceCharge) * (1 + tax);
}

processOrder(100);      // 126.5
```

This function uses conditional statements to test whether arguments have been omitted. When an argument is omitted, JavaScript automatically initializes it to a value of `undefined`. The function takes advantage of this behavior by setting `undefined` arguments to a default value.

The following variation of the `processOrder` function has the same behavior as the first:

```javascript
function processOrder(price, quantity, discount, serviceCharge, tax) {
  quantity = quantity || 1;
  discount = discount || 0;
  serviceCharge = serviceCharge || 0.1;
  tax = tax || 0.15;

  return (price * quantity) * (1 - discount) * (1 + serviceCharge) * (1 + tax);
}
```

However, both of these solutions have a limitation that can lead to an incorrect result for certain inputs. What is this limitation and how does it affect the result?

### Solution

Invalid input that evaluates to a truthy value but is coerced to `NaN` when used with an arithmetic operator like `*` will return `NaN` for both code snippets. An example would be a string that contains an invalid character, such as `abc`.

#### Adjustments based on provided solution

My answer was wrong (the question wasn't asking about invalid input but valid input that would produce an uxpected result.) The right answer is that when the optional arguments (other than `discount`, because it's default value is `0`) have a value of `0`, `0` evaluates to false, so both code snippets will act as if the argument wasn't provided and assign the default value, overwriting the provided value of `0`.

---

2. Equal

Read through the following code. Currently, it does not log the expected result. Explain why this happens, then refactor the code so that it works as expected.

```javascript
const person = { name: 'Victor' };
const otherPerson = { name: 'Victor' };

console.log(person === otherPerson);    // false -- expected: true
```

### Solution

This snippet does not log the expected result because of the way JavaScript evaluates objects for equality: two objects are considered equal if they are the *same* object, not if they have the properties (key/value pairs.)

The easiest solution is to set both variables to the same object:

```javascript
const person = { name: 'Victor' };
const otherPerson = person;

console.log(person === otherPerson);    // true
```

If you must evaluate different objects for equality based on their properties, you have to create a function to iterate and compare the properties of both objects. Note that this only works if the objects contain primitives as their property values; nested objects or arrays have the same issue: they're only considered equal if they are the same thing.

```javascript
function objectsEqual(object1, object2) {
  if (object1.length !== object2.length) return false;

  let keys = Object.keys(object1);
  for (let index = 0; index < keys.length; index += 1) {
    let key = keys[index];
    if (object1[key] !== object2[key]) return false;
  }

  return true;
}

const person = { name: 'Victor' };
const otherPerson = person;

console.log(objectsEqual(person, otherPerson));    // true
```

---

3. Amount Payable

What does the following code log? Why is this so?

```javascript
let startingBalance = 1;
const chicken = 5;
const chickenQuantity = 7;

function totalPayable(item, quantity) {
  return startingBalance + (item * quantity);
}

startingBalance = 5;
console.log(totalPayable(chicken, chickenQuantity));

startingBalance = 10;
console.log(totalPayable(chicken, chickenQuantity));
```

### Solution

This logs:
```javascript
40   // from line 10
45   // from line 13
```

This code illustrates how lexical scoping and closures work in JavaScript. The outer scoped variable `startingBalance` is accessible inside the `totalPayable` function because the function's closure retains a reference to `startingBalance`. As `startingBalance` is reassigned new values throughout the code snippet, references to `startingBalance` inside the `totalPayable` function see the new values.

---

4. Caller

The `doubler` function in the code below takes two arguments: a `number` to double and return, and a string containing the name of the function's `caller`.

```javascript
function doubler(number, caller) {
  console.log(`This function was called by ${caller}.`);
  return number + number;
}

doubler(5, 'Victor');                   // returns 10
// logs:
// This function was called by Victor.
```

Write a `makeDoubler` function that takes a `caller` name as an argument, and returns a function that has the same behavior as `doubler`, but with a preset `caller`.

Example:

```javascript
const doubler = makeDoubler('Victor');
doubler(5);                             // returns 10
// logs:
// This function was called by Victor.
```

### Solution

```javascript
function makeDoubler(caller) {
  return function doubler(number) {
    console.log(`This function was called by ${caller}.`);
    return number + number;
  }
}

const doubler = makeDoubler('Victor');
doubler(5);                             // returns 10
// logs:
// This function was called by Victor.
```

#### Adjustments based on provided solution

This is a great place to use an arrow function:

```javascript
function makeDoubler(caller) {
  return number => {
    console.log(`This function was called by ${caller}.`);
    return number + number;
  }
}

const doubler = makeDoubler('Victor');
doubler(5);                             // returns 10
// logs:
// This function was called by Victor.
```

---

5. What's My Value?

What will the following program log to the console? Can you explain why?

```javascript
const array = ['Apples', 'Peaches', 'Grapes'];

array[3.4] = 'Oranges';
console.log(array.length);
console.log(Object.keys(array).length);

array[-2] = 'Watermelon';
console.log(array.length);
console.log(Object.keys(array).length);
```

### Solution

```javascript
const array = ['Apples', 'Peaches', 'Grapes', '3.4': 'Oranges', '-2': 'Watermelon'];
```

This program logs:

```javascript
3   // line 4
4   // line 5
3   // line 8
5   // line 9
```

In JavaScript, `Arrays` are `Objects`, and their indexes are keys - specifically any key with a value that is an integer greater than or equal to zero is an index; values stored at indexes are elements. `Arrays`, as `Objects`, can have other properties too, but they aren't indexes/elements if the key is not an integer greater than or equal to zero.

Furthermore, the `length` property of an `Array` only counts elements; non-index keys are omitted. But `Object.keys()` on an array returns all keys, both indexes and non-indexes. That is why the length of `array` in the snippet does not change: no integer keys greater than or equal to zero are added. But two non-integer keys are added, so the length of `Object.keys(array)` does change.

---

6. Length

Read through the code below. What values will be logged to the console? Can you explain these results?

```javascript
const languages = ['JavaScript', 'Ruby', 'Python'];
console.log(languages);
console.log(languages.length);

languages.length = 4;
console.log(languages);
console.log(languages.length);

languages.length = 1;
console.log(languages);
console.log(languages.length);

languages.length = 3;
console.log(languages);
console.log(languages.length);

languages.length = 1;
languages[2] = 'Python';
console.log(languages);
console.log(languages[1]);
console.log(languages.length);
```

### Solution

This code logs:

```
// empty lines are included for organization, they aren't logged by the above code
[ 'JavaScript', 'Ruby', 'Python' ]                    // line 2
3                                                     // line 3

[ 'JavaScript', 'Ruby', 'Python', <1 empty item> ]    // line 6
4                                                     // line 7

[ 'JavaScript' ]                                      // line 10
1                                                     // line 11

[ 'JavaScript', <2 empty items> ]                     // line 14
3                                                     // line 15

[ 'JavaScript', <1 empty item>, 'Python' ]            // line 19
undefined                                             // line 20
3                                                     // line 21
```

The explanation is that JavaScript arrays are sparse arrays and their length property can be manually manipulated, as we see on lines 5, 9, 13, and 17. Manually reducing the length of a full array (an array with a value stored at every index) results in values beyond the new, shorter array length being discarded.

As sparse arrays, JavaScript arrays can contain fewer elements than the total length of the array. Put another way, sparse arrays can be empty at one or more indexes. Manually increasing the length of an array results in empty slots at the new indexes. If accessed, empty values evaluate to `undefined`.

---

7. The Red Pill

Read through the code below and determine what will be logged. You may refer to the [ASCII Table](http://www.ascii-code.com/) to look up character code values.

```javascript
function one() {
  function log(result) {
    console.log(result);
  }

  function anotherOne(...args) {
    let result = '';
    for (let i = 0; i < args.length; i += 1) {
      result += String.fromCharCode(args[i]);
    }

    log(result);
  }

  function anotherAnotherOne() {
    console.log(String.fromCharCode(87, 101, 108, 99, 111, 109, 101));
    anotherOne(116, 111);
  }

  anotherAnotherOne();
  anotherOne(116, 104, 101);
  return anotherOne;
}

one()(77, 97, 116, 114, 105, 120, 33);
```

### Solution

This code logs:

```
Welcome   // lines 19 -> 15
to        // lines 16 -> 11 -> 2
the       // lines 20 -> 11 -> 2
Matrix!   // lines 21 -> 24 -> 11 -> 2
```
