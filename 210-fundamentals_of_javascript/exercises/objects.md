
# JavaScript Language Fundamentals - Objects - 11/4/2020

1. Literal

Identify the bug in the following code. Don't run the code until after you've tried to answer.

```javascript
const myObject = {
  a: 'name',
  'b': 'test',
  123: 'c',
  1: 'd',
};

myObject[1];
myObject[a];
myObject.a;
```

### Solution

The bug is on line 9; it should be `myObject['a'];`. As it is written, JavaScript will raise an error due to the variable `a` being undefined (rather than accessing `myObject`'s key with a value of the string `'a'`.

---

2. Literal Method

In the following code, a user creates a `person` object literal and defines two methods for returning the `person`'s first and last names. What is the result when the user tries out the code on the last line?

```javascript
const person = {
  firstName() {
    return 'Victor';
  },
  lastName() {
    return 'Reyes';
  },
};

console.log(`${person.firstName} ${person.lastName}`);
```

### Solution

To call a function or method, the function or method name has to have parentheses on the end. The provided code simply accesses the two methods; it does not call them.

---

3. Mutation

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
const array1 = ['Moe', 'Larry', 'Curly', 'Shemp', 'Harpo', 'Chico', 'Groucho', 'Zeppo'];
const array2 = [];

for (let i = 0; i < array1.length; i += 1) {
  array2.push(array1[i]);
}

for (let i = 0; i < array1.length; i += 1) {
  if (array1[i].startsWith('C')) {
    array1[i] = array1[i].toUpperCase();
  }
}

console.log(array2);
```

### Solution

This will log `[ 'Moe', 'Larry', 'Curly', 'Shemp', 'Harpo', 'Chico', 'Groucho', 'Zeppo' ]`. The arrays are different objects; mutating the values in one will not affect the the other.

---

4. Dynamic

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
const myObject = {
  prop1: '123',
  prop2: '234',
  'prop 3': '345',
};

const prop2 = '456';
myObject['prop2'] = '456';
myObject[prop2] = '678';

console.log(myObject[prop2]);
console.log(myObject.prop2);
```

### Solution

This logs:

```
678
456
```

#### Further Exploration

Here is another example. What do you think will be logged to the console this time, and why?

```javascript
const myObj = {};
myObj[myFunc()] = 'hello, ';

function myFunc() {
  return 'funcProp';
}

console.log(myObj);
myObj[myFunc()] = 'world!';
console.log(myObj);
```

##### FE Solution

const myObj = {
  'funcProp': 'world!',
};

This logs:

```
{ 'funcProp': 'hello, ' }
{ 'funcProp': 'world!' }
```

---

5. Array Object Part 1

What will the following code log to the console and why? Don't run the code until after you have tried to answer.

```javascript
const myArray = ['a', 'b', 'c'];

console.log(myArray[0]);
console.log(myArray[-1]);

myArray[-1] = 'd';
myArray['e'] = 5;
myArray[3] = 'f';

console.log(myArray[-1]);
console.log(myArray['e']);
console.log(myArray);
```

### Solution

const myArray = ['a', 'b', 'c', 'f', '-1': 'd', 'e': 5,];

This will log:

```
a
undefined
d
5
[ 'a', 'b', 'c', 'f', '-1': 'd', 'e': 5 ]

```

---

6. Array Object Part 2

A user wrote a function that takes an array as an argument and returns its average. Given the code below, the user expects the `average` function to return `5`. Is the user's expectation correct? Why or why not?

```javascript
const myArray = [5, 5];
myArray[-1] = 5;
myArray[-2] = 5;

function average(array) {
  let sum = 0;

  for (let i = -2; i < array.length; i += 1) {
    sum += array[i];
  }

  return sum / array.length;
}

average(myArray);
```

### Solution

The user's expectation is incorrect; this code will log `10`, not `5`. When the `average` function is called, `myArray` has two elements that both hold the value `5`, and two non-element key/value pairs also holding the value `5`. The `for` loop iterates over both elements as well as both non-element values (since the `-2` and `-1` values of `index` are coerced to strings and match the non-index keys of `"-1"` and `"-2"`.) This results in the `sum` being `20`, but an Array's `length` property is only `2`, not `4`, since it only counts elements. As a result, this code sums four different numbers but only divides the sum by 2, not 4.

#### Further Exploration

Refactor the `average` function so that it returns the result that the user expected, `5`.

##### FE Solution

This could be done two ways. 1) Only iterate over the elements and ignore non-element values:

```javascript
const myArray = [5, 5];
myArray[-1] = 5;
myArray[-2] = 5;

function average(array) {
  let sum = 0;

  for (let i = 0; i < array.length; i += 1) {
    sum += array[i];
  }

  return sum / array.length;
}

average(myArray);   // 5
```

2) Iterate over all values and divide by the number of keys, not just the number of elements:

```javascript
const myArray = [5, 5];
myArray[-1] = 5;
myArray[-2] = 5;

function average(array) {
  let sum = 0;

  for (let i = -2; i < array.length; i += 1) {
    sum += array[i];
  }

  return sum / Object.keys(array).length;
}

average(myArray);   // 5
```

---

7. What's my Bonus

The `calculateBonus` function calculates the bonus for a given salary. It makes use of two arguments for determining the bonus: a salary amount and a boolean switch. If the boolean is `true`, the bonus should be half of the salary; otherwise the bonus should be `0`. Fill in the blanks in the function so that it will work, then explain why it works.

Examples:

```javascript
function calculateBonus() {
  return _________[1] ? _________[0] / 2 : 0;
}

calculateBonus(2800, true);               // 1400
calculateBonus(1000, false);              // 0
calculateBonus(50000, true);              // 25000
```

### Solution

```javascript
function calculateBonus() {
  return arguments[1] ? arguments[0] / 2 : 0;
}

calculateBonus(2800, true);               // 1400
calculateBonus(1000, false);              // 0
calculateBonus(50000, true);              // 25000
```

This works because JavaScript makes the `arguments` local variable available which points to an *array-like* object containing every argument passed to the function call. While `arguments` can't directly use `Array` methods, its elements can be accessed with bracket notation as seen here.

---

8. The End is Near But Not Here

The `penultimate` function takes a string as an argument and returns the next-to-last word in the string. The function assumes that "words" are any sequence of non-whitespace characters. The function also assumes that the input string will always contain at least two words. The `penultimate` function in the example below does not return the expected result. Run the code below, check the current result, identify the problem, explain what the problem is, and provide a working solution.

Examples:

```javascript
function penultimate(string) {
  return string.split(' ')[-2];
}

penultimate('last word');                    // expected: "last"
penultimate('Launch School is great!');      // expected: "is"
```

### Solution

The problem is the negative index on line 2: `string.split(' ')[-2]`. Array indexes are non-negative integers. When attempting to access a negative index, JavaScript coerces the negative number to a string and looks for a key of the value `"-2"` since Arrays are Objects. As is, this code returns `undefined`, because the array returned by `string.split()` does not have a key of the value `"-2"`. This can be fixed by using the array's `length` property to compute the correct index:

```javascript
function penultimate(string) {
  let words = string.split(' ');
  return words[words.length - 2];
}

penultimate('last word');                    // expected: "last"
penultimate('Launch School is great!');      // expected: "is"
```

---

9. After Midnight Part 1

We can use the number of minutes before or after midnight to represent the time of day. If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight.

The `timeOfDay` function shown below takes a time argument using this minute-based format, and returns the time of day in 24-hour format (`"hh:mm"`). Reimplement the function using JavaScript's `Date` object.

Examples:

```javascript
timeOfDay(0);          // "00:00"
timeOfDay(-3);         // "23:57"
timeOfDay(35);         // "00:35"
timeOfDay(-1437);      // "00:03"
timeOfDay(3000);       // "02:00"
timeOfDay(800);        // "13:20"
timeOfDay(-4231);      // "01:29"
```

Note: Disregard Daylight Saving Time, Standard Time, and other complications.

```javascript
const MINUTES_PER_HOUR = 60;
const HOURS_PER_DAY = 24;
const MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR;

function timeOfDay(deltaMinutes) {
  deltaMinutes = deltaMinutes % MINUTES_PER_DAY;
  if (deltaMinutes < 0) {
    deltaMinutes = MINUTES_PER_DAY + deltaMinutes;
  }

  let hours = Math.floor(deltaMinutes / MINUTES_PER_HOUR);
  let minutes = deltaMinutes % MINUTES_PER_HOUR;

  return `${padWithZeroes(hours, 2)}:${padWithZeroes(minutes, 2)}`;
}

function padWithZeroes(number, length) {
  let numberString = String(number);

  while (numberString.length < length) {
    numberString = `0${numberString}`;
  }

  return numberString;
}
```

### Solution

```javascript
const MILLISECONDS_PER_MINUTE = 60 * 1000;

function timeOfDay(deltaMinutes) {
  let midnight = new Date();
  midnight.setHours(0, 0, 0, 0);

  let deltaMilliseconds = deltaMinutes * MILLISECONDS_PER_MINUTE;
  let timestamp = new Date(midnight.getTime() + deltaMilliseconds);

  return `${padWithZeroes(timestamp.getHours(), 2)}:${padWithZeroes(timestamp.getMinutes(), 2)}`;
}

function padWithZeroes(number, length) {
  let numberString = String(number);

  while (numberString.length < length) {
    numberString = `0${numberString}`;
  }

  return numberString;
}
```

---

10. After Midnight Part 2

As seen in the previous exercise, the time of day can be represented as the number of minutes before or after midnight. If the number of minutes is positive, the time is after midnight. If the number of minutes is negative, the time is before midnight.

The two functions below do the reverse of the previous exercise. They take a 24-hour time argument and return the number of minutes before or after midnight, respectively. Both functions should return a value between `0` and `1439` (inclusive). Refactor the functions using the `Date` object.

Examples:

```javascript
afterMidnight('00:00');       // 0
beforeMidnight('00:00');      // 0
afterMidnight('12:34');       // 754
beforeMidnight('12:34');      // 686
```

Note: Disregard Daylight Saving Time, Standard Time, and other irregularities.

```javascript
const MINUTES_PER_HOUR = 60;
const HOURS_PER_DAY = 24;
const MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR;

function afterMidnight(timeStr) {
  const timeComponents = timeStr.split(':');
  const hours = parseInt(timeComponents[0], 10);
  const minutes = parseInt(timeComponents[1], 10);

  return hours * MINUTES_PER_HOUR + minutes;
}

function beforeMidnight(timeStr) {
  let deltaMinutes = MINUTES_PER_DAY - afterMidnight(timeStr);
  if (deltaMinutes === MINUTES_PER_DAY) {
    deltaMinutes = 0;
  }

  return deltaMinutes;
}
```

### Solution

```javascript
const MINUTES_PER_DAY = 24 * 60;
const MILLISECONDS_PER_MINUTE = 60 * 1000;

function afterMidnight(timeStr) {
  const timeComponents = timeStr.split(':');
  const hours = parseInt(timeComponents[0], 10);
  const minutes = parseInt(timeComponents[1], 10);

  let midnight = new Date();
  midnight.setHours(0, 0, 0, 0);

  let timestamp = new Date();
  timestamp.setHours(hours, minutes, 0, 0);

  let deltaMilliseconds = timestamp.getTime() - midnight.getTime();
  let deltaMinutes = Math.floor(deltaMilliseconds / MILLISECONDS_PER_MINUTE);

  return deltaMinutes % MINUTES_PER_DAY;
}

function beforeMidnight(timeStr) {
  const timeComponents = timeStr.split(':');
  const hours = parseInt(timeComponents[0], 10);
  const minutes = parseInt(timeComponents[1], 10);

  let midnight = new Date();
  midnight.setHours(0, 0, 0, 0);

  let timestamp = new Date();
  timestamp.setDate(midnight.getDate() - 1);
  timestamp.setHours(hours, minutes, 0, 0);

  let deltaMilliseconds = midnight.getTime() - timestamp.getTime();
  let deltaMinutes = Math.floor(deltaMilliseconds / MILLISECONDS_PER_MINUTE);

  return deltaMinutes % MINUTES_PER_DAY;
}
```
