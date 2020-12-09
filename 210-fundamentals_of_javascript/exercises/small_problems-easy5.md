
# JS210 Small Problems - Easy 5 - 11/25/2020

## 1. Double Char Part 1

Write a function that takes a string, doubles every character in the string, and returns the result as a new string.

Examples:

```javascript
repeater('Hello');        // "HHeelllloo"
repeater('Good job!');    // "GGoooodd  jjoobb!!"
repeater('');             // ""
```

### Solution

```javascript
let repeater = function repeater(string) {
  let repeated = '';

  for (let letter of string) {
    repeated = repeated + letter + letter;
  }

  return repeated;
};
```

---

## 2. Double Char Part 2

Write a function that takes a string, doubles every consonant character in the string, and returns the result as a new string. The function should not double vowels (`'a'`,`'e'`,`'i'`,`'o'`,`'u'`), digits, punctuation, or whitespace.

Examples:

```javascript
doubleConsonants('String');          // "SSttrrinngg"
doubleConsonants('Hello-World!');    // "HHellllo-WWorrlldd!"
doubleConsonants('July 4th');        // "JJullyy 4tthh"
doubleConsonants('');                // ""
```

### Solution

```javascript
let doubleConsonants = function doubleConsonants(string) {
  const consonants = /[bcdfghjklmnpqrstvwxyz]/i;

  let result = '';

  for (let character of string) {
    result += character;
    if (consonants.test(character)) result += character;
  }

  return result;
};
```

---

## 3. Reverse Number

Write a function that takes a positive integer as an argument, and returns that number with its digits reversed.

Examples:

```javascript
reverseNumber(12345);    // 54321
reverseNumber(12213);    // 31221
reverseNumber(456);      // 654
reverseNumber(12000);    // 21 -- Note that zeros get dropped!
reverseNumber(1);        // 1
```

### Solution

```javascript
let reverseNumber = function reverseNumber(number) {
  return Number(String(number).split('').reverse().join(''));
};
```

---

## 4. Get the Middle Character

Write a function that takes a non-empty string argument, and returns the middle character(s) of the string. If the string has an odd length, you should return exactly one character. If the string has an even length, you should return exactly two characters.

Examples:

```javascript
centerOf('I Love JavaScript'); // "a"
centerOf('Launch School');     // " "
centerOf('Launch');            // "un"
centerOf('Launchschool');      // "hs"
centerOf('x');                 // "x"
```

### Solution

```javascript
let centerOf = function centerOf(string) {
  let middleIndex = Math.ceil((string.length / 2) - 1);

  let end;
  if (string.length % 2 === 1) {
    end = middleIndex + 1;
  } else {
    end = middleIndex + 2;
  }

  return string.slice(middleIndex, end);
};
```

---

## 5. Always Return Negative

Write a function that takes a number as an argument. If the argument is a positive number, return the negative of that number. If the argument is a negative number, return it as-is.

Examples:

```javascript
negative(5);     // -5
negative(-3);    // -3
negative(0);     // -0
```

### Solution

```javascript
let negative = function negative(number) {
  if (number < 0) {
    return number;
  } else if (number > 0) {
    return number * -1;
  } else {
    return -0;
  }
};

console.log(negative(-0));     // -0
```

#### Adjustments based on provided solution

`Math.abs()` is perfect for this: `Math.abs(number) * -1`.

---

## 6. Counting Up

Write a function that takes an integer argument, and returns an array containing all integers between `1` and the argument (inclusive), in ascending order.

You may assume that the argument will always be a positive integer.

Examples:

```javascript
sequence(5);    // [1, 2, 3, 4, 5]
sequence(3);    // [1, 2, 3]
sequence(1);    // [1]
```

### Solution

```javascript
let sequence = function sequence(end) {
  let result = [];
  for (let counter = 1; counter <= end; counter += 1) {
    result.push(counter);
  }

  return result;
};
```

---

## 7. Name Swapping

Write a function that takes a string argument consisting of a first name, a space, and a last name, and returns a new string consisting of the last name, a comma, a space, and the first name.

Examples:

```javascript
swapName('Joe Roberts');    // "Roberts, Joe"
```

### Solution

```javascript
let swapName = function swapName(fullName) {
  let [firstName, lastName] = fullName.split(' ');
  return `${lastName}, ${firstName}`;
};
```

#### Further Exploration

What if the person had more than one first name? Refactor the current solution so that it can accommodate this.

##### FE Solution

```javascript
let swapName = function swapName(fullName) {
  let names = fullName.split(' ');
  let lastName = names[names.length - 1];
  let firstNames = names.slice(0, names.length - 1);

  return `${lastName}, ${firstNames.join(' ')}`;
};

console.log(swapName('Joe Roberts'));    // "Roberts, Joe"
console.log(swapName('Joe Bob Roberts'));    // "Roberts, Joe Bob"
```

---

## 8. Sequence Count

Create a function that takes two integers as arguments. The first argument is a `count`, and the second is the starting number of a sequence that your function will create. The function should return an array containing the same number of elements as the `count` argument. The value of each element should be a multiple of the starting number.

You may assume that the `count` argument will always be an integer greater than or equal to `0`. The starting number can be any integer. If the `count` is `0`, the function should return an empty array.

Examples:

```javascript
sequence(5, 1);          // [1, 2, 3, 4, 5]
sequence(4, -7);         // [-7, -14, -21, -28]
sequence(3, 0);          // [0, 0, 0]
sequence(0, 1000000);    // []
```

### Solution

```javascript
let sequence = function sequence(count, start) {
  let result = [];

  for (let counter = 1; counter <= count; counter += 1) {
    result.push(counter * start);
  }

  return result;
};
```

---

## 9. Reverse It Part 1

Write a function that takes a string argument, and returns a new string containing the words from the string argument in reverse order.

Examples:

```javascript
reverseSentence('');                       // ""
reverseSentence('Hello World');            // "World Hello"
reverseSentence('Reverse these words');    // "words these Reverse"
```

### Solution

```javascript
let reverseSentence = function reverseSentence(sentence) {
  return sentence.split(' ').reverse().join(' ');
};
```

---

## 10 Reverse It Part 2

Write a function that takes a string argument containing one or more words, and returns a new string containing the words from the string argument. All five-or-more letter words should have their letters in reverse order. The string argument will consist of only letters and spaces. Words will be separated by a single space.

Examples:

```javascript
reverseWords('Professional');             // "lanoisseforP"
reverseWords('Walk around the block');    // "Walk dnuora the kcolb"
reverseWords('Launch School');            // "hcnuaL loohcS"
```

### Solution

```javascript
let reverseWords = function reverseWords(sentence) {
  return sentence.split(' ').map(word => {
    if (word.length >= 5) return word.split('').reverse().join('');
    return word;
  }).join(' ');
};
```
