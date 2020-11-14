
# JS210 Small Problems - Easy 2 - 10/27/2020

1. Ddaaiillyy ddoouubbllee

Write a function that takes a string argument, and returns a new string that contains the value of the original string with all consecutive duplicate characters collapsed into a single character.

Examples:

```
crunch('ddaaiillyy ddoouubbllee');    // "daily double"
crunch('4444abcabccba');              // "4abcabcba"
crunch('ggggggggggggggg');            // "g"
crunch('a');                          // "a"
crunch('');                           // ""
```

### Solution

```javascript
function crunch(string) {
  let crunched = '';
  let previousChar = '';
  for (let index = 0; index < string.length; index += 1) {
    if (string[index] === previousChar) continue;

    previousChar = string[index];
    crunched += string[index];
  }

  return crunched;
}
```

#### Further Exploration

You may have noticed that the solution continues iterating until `index` points past the end of the string. As a result, on the last iteration, `text[index]` is the last character in `text`, while `text[index + 1]` is `undefined`. Why does it do this? What happens if it stops iterating when `index` is equal to `text.length - 1`?

It's also possible to solve this using regular expressions. For a nice challenge, give this a try with regular expressions. Can you think of any other solutions that don't use regular expressions?

##### FE Solution

If the provided solution stops iterating when `index` is equal to `text.length - 1`, it will incorrectly omit the final character if it's unique.

```javascript
function crunch(string) {
  const regex = /(.)\1+/i
  return string.replace(regex, '$1');
}
```

---

2. Bannerizer

Write a function that will take a short line of text, and write it to the console log within a box.

Examples:

```
logInBox('To boldly go where no one has gone before.');
```

will log on the console:

```
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
```

```
logInBox('');
+--+
|  |
|  |
|  |
+--+
```

You may assume that the output will always fit in your browser window.

### Solution

```javascript
function logInBox(string) {
  let width = string.length + 4;
  let borderRow = '+' + charFill('-', width - 2) + '+';
  let paddingRow = '|' + charFill(' ', width - 2) + '|';
  let contentRow = '| ' + string + ' |';

  console.log(borderRow);
  console.log(paddingRow);
  console.log(contentRow);
  console.log(paddingRow);
  console.log(borderRow);
}

function charFill(character, length) {
  let result = '';
  for (let counter = 1; counter <= length; counter += 1) {
    result += character;
  }

  return result;
}
```

---

3. Stringy Strings

Write a function that takes one argument, a positive integer, and returns a string of alternating `'1'`s and `'0'`s, always starting with a `'1'`. The length of the string should match the given integer.

Examples:

```
stringy(6);    // "101010"
stringy(9);    // "101010101"
stringy(4);    // "1010"
stringy(7);    // "1010101"
```

### Solution

```javascript
function stringy(size) {
  let alternatingString = '';

  for (counter = 1; counter <= size; counter += 1) {
    alternatingString += String(counter % 2);
  }

  return alternatingString;
}
```

---

4. Fibonacci Number Location by Length

The Fibonacci series is a series of numbers (`1, 1, 2, 3, 5, 8, 13, 21, ...`) such that the first two numbers are `1` by definition, and each subsequent number is the sum of the two previous numbers. This series appears throughout the natural world.

Computationally, the Fibonacci series is a simple series, but the results grow at an incredibly rapid rate. For example, the 100th Fibonacci number is 354,224,848,179,261,915,075—that's enormous, especially considering that it takes six iterations just to find the first 2-digit Fibonacci number.

Write a function that calculates and returns the index of the first Fibonacci number that has the number of digits specified by the argument. (The first Fibonacci number has an index of 1.)

You may assume that the argument is always an integer greater than or equal to 2.

Examples:

```
findFibonacciIndexByLength(2);       // 7
findFibonacciIndexByLength(10);      // 45
findFibonacciIndexByLength(16);      // 74
```

### Solution

```javascript
function fibonacci(index) {
  if (index === 1 || index === 2) return 1;
  return (fibonacci(index - 1) + fibonacci(index - 2));
}

function fibonacci(index) {
  let first = 1;
  let second = 1;
  let fibonacciNumber;

  for (let counter = 1; counter <= index; counter += 1) {
    fibonacciNumber = first + second;
    first = second;
    second = fibonacciNumber;
  }

  return fibonacciNumber;
}

function findFibonacciIndexByLength(length) {
  for (let index = 1; ; index += 1) {
    let fibonacciNumber = String(fibonacci(index));
    if (fibonacciNumber.length === length) return index;
  }
}
```

#### Adjustments based on provided solution

Recursive fibonacci function is too slow; use iterative:

```javascript
function fibonacci(index) {
  if (index === 1 || index === 2) return 1;

  let first = 1;
  let second = 1;
  let fibonacciNumber;

  for (let counter = 3; counter <= index; counter += 1) {
    fibonacciNumber = first + second;
    first = second;
    second = fibonacciNumber;
  }

  return fibonacciNumber;
}
```

---

5. Right Triangles

Write a function that takes a positive integer, `n`, as an argument, and logs a right triangle whose sides each have `n` stars. The hypotenuse of the triangle (the diagonal side in the images below) should have one end at the lower-left of the triangle, and the other end at the upper-right.

Examples:

```
triangle(5);

    *
   **
  ***
 ****
*****

triangle(9);

        *
       **
      ***
     ****
    *****
   ******
  *******
 ********
*********
```

### Solution

```javascript
function triangle(n) {
  for (let counter = 1; counter <= n; counter += 1) {
    let spaces = repeat(' ', n - counter);
    let stars = repeat('*', counter);
    console.log(spaces + stars);
  }
}

function repeat(character, times) {
  let result = '';
  for (let counter = 1; counter <= times; counter += 1) {
    result += character;
  }

  return result;
}
```

---

6. Madlibs

Madlibs is a simple game where you create a story template with "blanks" for words. You, or another player, then construct a list of words and place them into the story, creating an often silly or funny story as a result.

Create a simple madlib program that prompts for a noun, a verb, an adverb, and an adjective, and injects them into a story that you create.

Example:

```
Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly

// console output
Do you walk your blue dog quickly? That's hilarious!
```

### Solution

```javascript
function madlibs() {
  const rlSync = require('readline-sync');
  let noun = rlSync.question('Enter a noun: ');
  let verb = rlSync.question('Enter a verb: ');
  let adjective = rlSync.question('Enter a adjective: ');
  let adverb = rlSync.question('Enter a adverb: ');

  console.log(`Do you ${verb} your ${adjective} ${noun} ${adverb}? That's hilarious!`);
}
```

---

7. Double Doubles

A double number is an even-length number whose left-side digits are exactly the same as its right-side digits. For example, `44`, `3333`, `103103`, and `7676` are all double numbers, whereas `444`, `334433`, and `107` are not.

Write a function that returns the number provided as an argument multiplied by two, unless the argument is a double number; return double numbers as-is.

Examples:

```
twice(37);          // 74
twice(44);          // 44
twice(334433);      // 668866
twice(444);         // 888
twice(107);         // 214
twice(103103);      // 103103
twice(3333);        // 3333
twice(7676);        // 7676
```

### Solution

```javascript
function twice(number) {
  if (isDouble(number)) {
    return number;
  } else {
    return number * 2;
  }
}

function isDouble(number) {
  number = String(number);
  if (number.length % 2 === 0) {
    let firstHalf, lastHalf;
    [firstHalf, lastHalf] = splitInHalf(number);
    return firstHalf === lastHalf;
  }

  return false;
}

function splitInHalf(string) {
  let midPoint = string.length / 2;
  let firstHalf = '';
  let lastHalf = '';

  for (let counter = 0; counter < midPoint; counter += 1) {
    firstHalf += string[counter];
  }

  for (let counter = midPoint; counter < string.length; counter += 1) {
    lastHalf += string[counter];
  }

  return [firstHalf, lastHalf];
}
```

---

8. Grade Book

Write a function that determines the mean (average) of the three scores passed to it, and returns the letter associated with that grade.

Numerical score letter grade list:

> * 90 <= score <= 100: 'A'
> * 80 <= score < 90: 'B'
> * 70 <= score < 80: 'C'
> * 60 <= score < 70: 'D'
> * 0 <= score < 60: 'F'

Tested values are all between `0` and `100`. There is no need to check for negative values or values greater than 100.

Examples:

```
getGrade(95, 90, 93);    // "A"
getGrade(50, 50, 95);    // "D"
```

### Solution

```javascript
function getGrade(score1, score2, score3) {
  let grade = average([score1, score2, score3]);

  if (grade >= 90) return 'A';
  if (grade >= 80) return 'B';
  if (grade >= 70) return 'C';
  if (grade >= 60) return 'D';
  return 'F';
}

function average(scores) {
  let sum = scores.reduce((sum, number) => sum += number, 0);
  return sum / scores.length;
}
```

---

9. Clean Up the Words

Given a string that consists of some words and an assortment of non-alphabetic characters, write a function that returns that string with all of the non-alphabetic characters replaced by spaces. If one or more non-alphabetic characters occur in a row, you should only have one space in the result (i.e., the result string should never have consecutive spaces).

Example:

```
cleanUp("---what's my +*& line?");    // " what s my line "
```

### Solution

```javascript
function cleanUp(string) {
  let cleaned = '';

  for (let index = 0; index < string.length; index += 1) {
    if (isAlpha(string[index])) {
      cleaned += string[index];
    } else {
      if (cleaned[cleaned.length - 1] !== ' ') cleaned += ' ';
    }
  }

  return cleaned;
}

function isAlpha(character) {
  return ((character >= 'a' && character <= 'z') || (character >= 'A' && character <= 'Z'));
}
```

#### Further Exploration

If you originally wrote your solution without using regular expressions, try writing it with regular expressions to see how expressive and concise your code can become. Note, however, that using regular expressions can sometimes make your code less readable.

##### FE Solution

function cleanUp(text) {
  let cleaned = text.replace(/[^a-z]/gi, ' ');
  let cleaned = cleaned.replace(/  +/gi, ' ');
  return cleaned;
}

---

10. What Century is That

Write a function that takes a year as input and returns the century. The return value should be a string that begins with the century number, and ends with `'st'`, `'nd'`, `'rd'`, or `'th'` as appropriate for that number.

New centuries begin in years that end with `01`. So, the years 1901 - 2000 comprise the 20th century.

Examples:

```
century(2000);        // "20th"
century(2001);        // "21st"
century(1965);        // "20th"
century(256);         // "3rd"
century(5);           // "1st"
century(10103);       // "102nd"
century(1052);        // "11th"
century(1127);        // "12th"
century(11201);       // "113th"
```

### Solution

```javascript
function century(year) {
  let hundreds = Math.floor(year / 100);
  let remainder = year % 100;

  if (remainder > 0) hundreds += 1;

  return String(hundreds) + numeralSuffix(hundreds);
}

function numeralSuffix(number) {
  if (number >= 11 && number <= 13) return 'th';
  switch (number % 10) {
    case 1: return 'st';
    case 2: return 'nd';
    case 3: return 'rd';
    default: return 'th';
  }
}
```

1st    11th   21st
2nd    12th   22nd
3rd    13th   23rd
4th    14th   24th
5th    15th   25th
6th    16th   26th
7th    17th   27th
8th    18th   28th
9th    19th   29th
10th   20th   30th


---
