
# JS210 Small Problems - Easy 1 - 10/27/2020

1. Odd Numbers

Log all odd numbers from `1` to `99`, inclusive, to the console. Log all numbers on separate lines.

### Solution

```javascript
for(let counter = 1; counter <= 99; counter += 2) {
  console.log(counter);
}
```

#### Further Exploration

Repeat this exercise with a technique different from the one that you used, and different from the one provided. Also consider adding a way for the user to specify the limits of the odd numbers logged to the console.

##### FE Solution

```javascript
const rlSync = require('readline-sync');
let start = rlSync.question('Which odd number should we start with? ');
let end = rlSync.question('Which larger odd number should we end with? ');
let counter = start;

while (counter <= end) {
  console.log(counter);
  counter += 2;
}
```

---

2. Even Numbers

Log all even numbers from `1` to `99`, inclusive, to the console. Log all numbers on separate lines.

### Solution

```javascript
for(let counter = 2; counter < 99; counter += 2) {
  console.log(counter);
}
```

---

3. Build a program that asks the user to enter the length and width of a room in meters, and then logs the area of the room to the console in both square meters and square feet.

Note: 1 square meter == 10.7639 square feet

Do not worry about validating the input at this time. Use the `readlineSync.prompt` method to collect user input.

Example:

```
Enter the length of the room in meters:
10
Enter the width of the room in meters:
7
The area of the room is 70.00 square meters (753.47 square feet).
```

### Solution

```javascript
const rlSync = require('readline-sync');
const FEET_PER_METER = 10.7639;

console.log('Enter the length of the room in meters:');
let lengthMeters = Number(rlSync.prompt());
console.log('Enter the width of the room in meters:');
let widthMeters = Number(rlSync.prompt());

let areaMeters = lengthMeters * widthMeters;
let areaFeet = areaMeters * FEET_PER_METER;

console.log(`The area of the room is ${areaMeters} square meters (${areaFeet} square feet).`);
```

#### Adjustments based on provided solution

Specify that constant is *square* feet per square meter. Use `toFixed()` to limit decimal places of the floats being logged.

`const SQFEET_PER_SQMETER`
`${areaFeet.toFixed(2)}`

#### Further Exploration

Modify the program so that it asks the user for the input type (meters or feet). Compute for the area accordingly, and log it and its conversion in parentheses.

##### FE Solution

```javascript
const rlSync = require('readline-sync');
const SQFEET_PER_SQMETER = 10.7639;

console.log('Are you providing measurements in meters or feet?');
let units = rlSync.prompt();
console.log(`Enter the length of the room in ${units}:`);
let length = Number(rlSync.prompt());
console.log(`Enter the width of the room in ${units}:`);
let width = Number(rlSync.prompt());

let area = length * width;
let secondaryUnits;
let convertedArea;

if (units === 'meters') {
  secondaryUnits = 'feet';
  convertedArea = (area * SQFEET_PER_SQMETER).toFixed(2);
} else {
  secondaryUnits = 'meters';
  convertedArea = (area / SQFEET_PER_SQMETER).toFixed(2);
}

console.log(`The area of the room is ${area} square ${units} (${convertedArea} square ${secondaryUnits}).`);
```

---

4. Tip Calculator

Create a simple tip calculator. The program should prompt for a bill amount and a tip rate. The program must compute the tip, and then log both the tip and the total amount of the bill to the console. You can ignore input validation and assume that the user will put in numbers.

Example:

```
What is the bill? 200
What is the tip percentage? 15

The tip is $30.00
The total is $230.00
```

### Solution

```javascript
const rlSync = require('readline-sync');

let bill = rlSync.question('What is the bill? ');
bill = Number(bill);

let tipPercentage = rlSync.question('What is the tip percentage? ');
tipPercentage = Number(tipPercentage);

let tip = bill * tipPercentage / 100;
let total = bill + tip;

console.log();
console.log(`The tip is $${tip.toFixed(2)}`);
console.log(`The total is $${total.toFixed(2)}`);
```

---

5. Sum or Product of Consecutive Integers

Write a program that asks the user to enter an integer greater than `0`, then asks if the user wants to determine the sum or the product of all numbers between `1` and the entered integer, inclusive.

Examples:

```
Please enter an integer greater than 0: 5
Enter "s" to compute the sum, or "p" to compute the product. s

The sum of the integers between 1 and 5 is 15.

Please enter an integer greater than 0: 6
Enter "s" to compute the sum, or "p" to compute the product. p

The product of the integers between 1 and 6 is 720.
```

### Solution

```javascript
function sumOneTo(number) {
  let result = 0;
  for (number; number >= 1; number -= 1) {
    result += number;
  }

  return result;
}

function factorial(number) {
  let result = 1;
  for (number; number >= 1; number -= 1) {
    result *= number;
  }

  return result;
}

function sumOrProduct() {
  const rlSync = require('readline-sync');
  let number = rlSync.prompt('Please enter an integer greater than 0: ');
  number = Number(number);
  let operation = rlSync.prompt('Enter "s" to compute the sum, or "p" to compute the product. ');
  let result;

  if (operation ==='s') {
    result = sumOneTo(number);
    operation = 'sum';
  } else {
    result = factorial(number);
    operation = 'product';
  }

  console.log(`The ${operation} of the integers between 1 and ${number} is ${result}.`);
}
```

#### Further Exploration

What if the input was an array of integers instead of just a single integer? How would your `computeSum` and `computeProduct` functions change? Given that the input is an array, how might you make use of the `Array.prototype.reduce()` method?

The `computeSum` and `computeProduct` methods could be replaced entirely with `reduce`, but if we wanted to keep them for consistency and readability, their bodies could become:

```javascript
function computeSum(numbers) {
  return numbers.reduce((sum, number) => sum += number);
}

function computeProduct(numbers) {
  return numbers.reduce((product, number) => product *= number);
}
```

---

6. Short Long Short

Write a function that takes two strings as arguments, determines the longer of the two strings, and then returns the result of concatenating the shorter string, the longer string, and the shorter string once again. You may assume that the strings are of different lengths.

Examples:

```
shortLongShort('abc', 'defgh');    // "abcdefghabc"
shortLongShort('abcde', 'fgh');    // "fghabcdefgh"
shortLongShort('', 'xyz');         // "xyz"

shortLongShort('abc', 'defgh');
shortLongShort('abcde', 'fgh');
shortLongShort('', 'xyz');
```

### Solution

```javascript
function shortLongShort(string1, string2) {
  if (string1.length < string2.length) {
    return string1 + string2 + string1;
  } else {
    return string2 + string1 + string2;
  }
}
```

---

7. Leap Years Part 1

In the modern era under the Gregorian Calendar, leap years occur in every year that is evenly divisible by 4, unless the year is also divisible by 100. If the year is evenly divisible by 100, then it is not a leap year, unless the year is also evenly divisible by 400.

Assume this rule is valid for any year greater than year 0. Write a function that takes any year greater than 0 as input, and returns `true` if the year is a leap year, or `false` if it is not a leap year.

Examples:

```
isLeapYear(2016);      // true
isLeapYear(2015);      // false
isLeapYear(2100);      // false
isLeapYear(2400);      // true
isLeapYear(240000);    // true
isLeapYear(240001);    // false
isLeapYear(2000);      // true
isLeapYear(1900);      // false
isLeapYear(1752);      // true
isLeapYear(1700);      // false
isLeapYear(1);         // false
isLeapYear(100);       // false
isLeapYear(400);       // true
```

### Solution

```javascript
function divisible(dividend, divisor) {
  return (dividend % divisor) === 0;
}

// I've got two different solutions with slightly different formats, but I'm not very happy with either,
// although they both work.
function isLeapYear(year) {
  if (divisible(year, 4)) {
    if (divisible(year, 100)) {
      if (divisible(year, 400)) {
        return true;
      }

      return false;
    }

    return true;
  }

  return false;
}

function isLeapYear(year) {
  if (divisible(year, 4) && divisible(year, 100) && divisible(year, 400)) {
    return true;
  }
  if (divisible(year, 4) && divisible(year, 100)) {
    return false;
  }
  if (divisible(year, 4)) {
    return true;
  }

  return false;
}
```

#### Adjustments based on provided solution

My conditionals are unnecessarily complex:

```javascript
function isLeapYear(year) {
  if (divisible(year, 400)) {
    return true;
  } else if (divisible(year, 100)) {
    return false;
  } else {
    return divisible(year, 4);
  }
}
```

#### Further Exploration

The order in which you perform tests for a leap year calculation is important. For what years will `isLeapYear` fail if you rewrite it as shown below?

```javascript
function isLeapYear(year) {
  if (year % 100 === 0) {
    return false;
  } else if (year % 400 === 0) {
    return true;
  } else {
    return year % 4 === 0;
  }
}
```

Can you rewrite `isLeapYear` to perform its tests in the opposite order of the above solution? That is, test whether the year is divisible by 4 first, then, if necessary, test whether it is divisible by 100, and finally, if necessary, test whether it is divisible by 400. Is this solution simpler or more complex than the original solution?

##### FE Solution

The snippet fails for any year that is evenly divisible by 4, 100, and 400: it classifies them as not being leap years when they are.

You can reverse the tests if you add more conditionals. While the logic is straightforward, the code version is overly complex and hard to follow:

```javascript
function isLeapYear(year) {
  if (divisible(year, 4)) {
    if (divisible(year, 100)) {
      if (divisible(year, 400)) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  } else {
    return false;
  }
}
```

---

8. Leap Years Part 2

This is a continuation of the previous exercise.

The British Empire adopted the Gregorian Calendar in 1752, which was a leap year. Prior to 1752, they used the Julian Calendar. Under the Julian Calendar, leap years occur in any year that is evenly divisible by 4.

Using this information, update the function from the previous exercise to determine leap years both before and after 1752.

Examples:

```
isLeapYear(2016);      // true
isLeapYear(2015);      // false
isLeapYear(2100);      // false
isLeapYear(2400);      // true
isLeapYear(240000);    // true
isLeapYear(240001);    // false
isLeapYear(2000);      // true
isLeapYear(1900);      // false
isLeapYear(1752);      // true
isLeapYear(1700);      // true
isLeapYear(1);         // false
isLeapYear(100);       // true
isLeapYear(400);       // true
```

### Solution

```javascript
function divisible(dividend, divisor) {
  return (dividend % divisor) === 0;
}

function isGregorianLeapYear(year) {
  if (divisible(year, 400)) {
    return true;
  } else if (divisible(year, 100)) {
    return false;
  } else {
    return divisible(year, 4);
  }
}

function isJulianLeapYear(year) {
  return divisible(year, 4);
}

function isLeapYear(year) {
  if (year < 1752) {
    return isJulianLeapYear(year);
  } else {
    return isGregorianLeapYear(year);
  }
}
```

---

9. Multiples of 3 and 5

Write a function that computes the sum of all numbers between `1` and some other number, inclusive, that are multiples of `3` or `5`. For instance, if the supplied number is `20`, the result should be `98` (`3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20`).

You may assume that the number passed in is an integer greater than `1`.

Examples:

```
multisum(3);       // 3
multisum(5);       // 8
multisum(10);      // 33
multisum(1000);    // 234168
```

### Solution

```javascript
function divisible(dividend, divisor) {
  return dividend % divisor === 0;
}

function multisum(number) {
  let toSum = [];

  for (let counter = 1; counter <= number; counter += 1) {
    if (divisible(counter, 3) || divisible(counter, 5)) {
      toSum.push(counter);
    }
  }

  return toSum.reduce((sum, num) => sum += num, 0);
}
```

---

10. ASCII String Value

Write a function that determines and returns the ASCII string value of a string passed in as an argument. The ASCII string value is the sum of the ASCII values of every character in the string. (You may use `String.prototype.charCodeAt()` to determine the ASCII value of a character.)

Examples:

```
asciiValue('Four score');         // 984
asciiValue('Launch School');      // 1251
asciiValue('a');                  // 97
asciiValue('');                   // 0
```

### Solution

```javascript
function asciiValue(string) {
  let result = 0;
  for (let index = 0; index < string.length; index += 1) {
    result += string.charCodeAt(index);
  }

  return result;
}
```
