
# JS210 Small Problems - Easy 3 - 11/17/2020

1. How Old is Teddy

Build a program that randomly generates Teddy's age, and logs it to the console. Have the age be a random number between `20` and `200` (inclusive).

Example Output: `Teddy is 69 years old!`

### Solution

```javascript
let randomAge = function randomAge() {
  const MIN_AGE = 20;
  const MAX_AGE = 200;
  return (Math.floor((Math.random() * (MAX_AGE - MIN_AGE)) + MIN_AGE));
};

console.log(`Teddy is ${randomAge()} years old!`);
```

#### Further Exploration

The `randomBetween` function used the `Math.floor()` method. Would it make a difference if the `Math.round()` method was used instead?

Also, how can we make the function more robust? What if the user inadvertently gave the inputs in reverse order (i.e., the value passed to `min` was greater than `max`)?

##### FE Solution

The MDN documentation says using `Math.round()` instead of `Math.floor()` would produce a non-uniform distribution.

To make the function more robust, we can compare `max` and `min`:

```javascript
let randomAge = function randomAge(min = 20, max = 200) {
  if (max < min) [min, max] = [max, min];
  return Math.floor(Math.random() * (max - min)) + min;
};
```

---

2. Searching 101

Write a program that solicits six numbers from the user, then logs a message that describes whether or not the sixth number appears amongst the first five numbers.

Examples:

```
Enter the 1st number: 25
Enter the 2nd number: 15
Enter the 3rd number: 20
Enter the 4th number: 17
Enter the 5th number: 23
Enter the last number: 17

The number 17 appears in [25, 15, 20, 17, 23].

-----

Enter the 1st number: 25
Enter the 2nd number: 15
Enter the 3rd number: 20
Enter the 4th number: 17
Enter the 5th number: 23
Enter the last number: 18

The number 18 does not appear in [25, 15, 20, 17, 23].
```

### Solution

```javascript
let ordinalize = function ordinalize(number) {
  if (number >= 11 && number <= 13) return `${number}th`;
  if (number % 10 === 1) return `${number}st`;
  if (number % 10 === 2) return `${number}nd`;
  if (number % 10 === 3) return `${number}rd`;
  return `${number}th`;
};

let promptForNumbers = function promptForNumbers(quantity) {
  const rlSync = require('readline-sync');

  let numbers = [];
  for (let count = 1; count <= quantity; count += 1) {
    let number;

    if (count === quantity) {
      number = rlSync.question(`Enter the last number: `);
    } else {
      number = rlSync.question(`Enter the ${ordinalize(count)} number: `);
    }

    numbers.push(parseInt(number, 10));
  }

  return numbers;
};

let numberSearch = function numberSearch() {
  let numbers = promptForNumbers(6);
  let [lastNumber] = numbers.splice(-1, 1);

  let answer = numbers.includes(lastNumber) ? 'appears' : 'does not appear';
  console.log(`The number ${lastNumber} ${answer} in [${numbers.join(', ')}].`);
};
```

#### Further Exploration

What if the problem was looking for a number that satisfies some condition (e.g., a number greater than `25`), instead of a specific number? Would the current solution still work? Why or why not? Think about this first before scrolling down.

##### FE Solution

`Array.prototype.includes()` would not work for a condition as it just checks for a provided value, but `Array.prototype.some()` would work perfectly:

```javascript
let numberSearch = function numberSearch() {
  let numbers = promptForNumbers(6);
  let [lastNumber] = numbers.splice(-1, 1);

  let result = numbers.some(number => number > lastNumber);
  let answer = result ? 'satisfies' : 'does not satisfy';

  console.log(`The number ${lastNumber} ${answer} the condition with [${numbers.join(', ')}].`);
};
```

---

3. When Will I Retire

Build a program that logs when the user will retire and how many more years the user has to work until retirement.

Example:

```
What is your age? 30
At what age would you like to retire? 70

It's 2017. You will retire in 2057.
You have only 40 years of work to go!
```

### Solution

```javascript
let retirementPlanner = function retirementPlanner() {
  const rlSync = require('readline-sync');

  let currentAge = Number(rlSync.question('What is your age? '));
  let retirementAge = Number(rlSync.question('At what age would you like to retire? '));
  let ageDifference = retirementAge - currentAge;

  let today = new Date();
  let retirementYear = today.getFullYear() + ageDifference;

  console.log();
  console.log(`It's ${today.getFullYear()}. You will retire in ${retirementYear}.`);
  console.log(`You only have ${ageDifference} years of work to go!`);
};
```

#### Further Exploration

What would happen if the `new` keyword wasn't used in defining the `today` variable on line 4?

##### FE Solution

Invoking `Date()` without the `new` operator returns a string instead of a `Date` object.

---

4. Palindromic Strings Part 1

Write a function that returns `true` if the string passed as an argument is a palindrome, or `false` otherwise. A palindrome reads the same forwards and backwards. For this problem, the case matters and all characters matter.

Examples:

```javascript
isPalindrome('madam');               // true
isPalindrome('Madam');               // false (case matters)
isPalindrome("madam i'm adam");      // false (all characters matter)
isPalindrome('356653');              // true
```

### Solution

```javascript
let isPalindrome = function isPalindrome(phrase) {
  return phrase === phrase.split('').reverse().join('');
};
```

---

5. Palindromic Strings Part 2

Write another function that returns `true` if the string passed as an argument is a palindrome, or `false` otherwise. This time, however, your function should be case-insensitive, and should ignore all non-alphanumeric characters. If you wish, you may simplify things by calling the `isPalindrome` function you wrote in the previous exercise.

Examples:

```javascript
isRealPalindrome('madam');               // true
isRealPalindrome('Madam');               // true (case does not matter)
isRealPalindrome("Madam, I'm Adam");     // true (only alphanumerics matter)
isRealPalindrome('356653');              // true
isRealPalindrome('356a653');             // true
isRealPalindrome('123ab321');            // false
```

### Solution

```javascript
let isRealPalindrome = function isRealPalindrome(phrase) {
  let lowerAlphasOnly = phrase.toLowerCase().replace(/[^a-zA-Z0-9]/g, '');
  return isPalindrome(lowerAlphasOnly);
};
```

---

6. Palindromic Number

Write a function that returns `true` if its integer argument is palindromic, or `false` otherwise. A palindromic number reads the same forwards and backwards.

Examples:

```javascript
isPalindromicNumber(34543);        // true
isPalindromicNumber(123210);       // false
isPalindromicNumber(22);           // true
isPalindromicNumber(5);            // true
```

### Solution

```javascript
let isPalindromicNumber = function isPalindromicNumber(number) {
  return isRealPalindrome(String(number));
};
```

#### Further Exploration

Suppose the number argument begins with one or more `0`s. Will the solution still work? Why or why not? Is there any way to address this?

It works, but not as expected: numbers prefixed with `0` are treated as octal (base 8) numbers. Whether or not input is palindromic will be evaluated based on the octal digits, not the decimal digits:

```javascript
isPalindromicNumber(0102);  // true; same as:
isPalindromicNumber(66);    // true
```

I've not been able to find a way to handle this special case and make numeric inputs with leading zeroes not be treated as octal numbers. The workaround would be to pass in numbers with leading zeroes as strings instead of numbers.

---

7. Running Totals

Write a function that takes an array of numbers, and returns an array with the same number of elements, with each element's value being the running total from the original array.

Examples:

```javascript
runningTotal([2, 5, 13]);             // [2, 7, 20]
runningTotal([14, 11, 7, 15, 20]);    // [14, 25, 32, 47, 67]
runningTotal([3]);                    // [3]
runningTotal([]);                     // []
```

### Solution

```javascript
let runningTotal = function runningTotal(numbers) {
  return numbers.map((_element, index) => {
    let subArray = numbers.slice(0, index + 1);
    return subArray.reduce((sum, number) => sum + number, 0);
  });
};
```

---

8. Letter Swap

Given a string of words separated by spaces, write a function that swaps the first and last letters of every word.

You may assume that every word contains at least one letter, and that the string will always contain at least one word. You may also assume that each string contains nothing but words and spaces, and that there are no leading, trailing, or repeated spaces.

Examples:

```javascript
swap('Oh what a wonderful day it is');  // "hO thaw a londerfuw yad ti si"
swap('Abcde');                          // "ebcdA"
swap('a');                              // "a"
```

### Solution

```javascript
let swap = function swap(phrase) {
  let words = phrase.split(' ');

  return words.map(word => {
    if (word.length === 1) return word;

    let firstLetter = word[0];
    let lastLetter = word[word.length - 1];
    if (word.length === 2) return lastLetter + firstLetter;

    let middleLetters = word.slice(1, -1);
    return lastLetter + middleLetters + firstLetter;
  }).join(' ');
};
```

#### Adjustments based on provided solution

Because of the way `String.prototype.slice()` works, the only "edge case" is strings of length 1, not 2:

```javascript
let swap = function swap(phrase) {
  let words = phrase.split(' ');

  return words.map(word => {
    if (word.length === 1) return word;

    let firstLetter = word[0];
    let lastLetter = word[word.length - 1];
    let middleLetters = word.slice(1, -1);

    return lastLetter + middleLetters + firstLetter;
  }).join(' ');
};
```

---

9. Letter Counter Part 1

Write a function that takes a string consisting of one or more space separated words, and returns an object that shows the number of words of different sizes.

Words consist of any sequence of non-space characters.

Examples:

```javascript
wordSizes('Four score and seven.');                       // { "3": 1, "4": 1, "5": 1, "6": 1 }
wordSizes('Hey diddle diddle, the cat and the fiddle!');  // { "3": 5, "6": 1, "7": 2 }
wordSizes("What's up doc?");                              // { "2": 1, "4": 1, "6": 1 }
wordSizes('');                                            // {}
```

### Solution

```javascript
let wordSizes = function wordSizes(phrase) {
  let result = {};
  if (phrase.length === 0) return result;

  let wordLengths = phrase.split(' ').map(word => word.length);

  wordLengths.forEach(wordLength => {
    if (!result[wordLength]) result[wordLength] = 0;
    result[wordLength] += 1;
  });

  return result;
};
```

---

10. Modify the `wordSizes` function from the previous exercise to exclude non-letters when determining word size. For instance, the word size of `"it's"` is `3`, not `4`.

Examples:

```javascript
wordSizes('Four score and seven.');                       // { "3": 1, "4": 1, "5": 2 }
wordSizes('Hey diddle diddle, the cat and the fiddle!');  // { "3": 5, "6": 3 }
wordSizes("What's up doc?");                              // { "5": 1, "2": 1, "3": 1 }
wordSizes('');                                            // {}
```

### Solution

```javascript
let wordSizes = function wordSizes(phrase) {
  let result = {};
  if (phrase.length === 0) return result;

  let words = phrase.split(' ');
  words.forEach(word => {
    let wordLength = word.replace(/[^a-zA-Z]/g, '').length;

    if (!result[wordLength]) result[wordLength] = 0;
    result[wordLength] += 1;
  });

  return result;
}
```
