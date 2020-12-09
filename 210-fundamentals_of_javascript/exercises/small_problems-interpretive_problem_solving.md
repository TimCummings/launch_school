
# JS210 Small Problems - Interpretive Problem Solving - 12/1/2020

## 1. 1000 Lights

You have a bank of switches before you, numbered from `1` to `n`. Every switch is connected to exactly one light that is initially off. You walk down the row of switches and toggle every one of them. You walk back to the beginning of the row and start another pass. On this second pass, you toggle switches `2`, `4`, `6`, and so on. On the third pass, you go back to the beginning again, this time toggling switches `3`, `6`, `9`, and so on. You continue to repeat this process until you have gone through `n` repetitions.

Write a program that takes one argument—the total number of switches—and returns an array of the lights that are on after `n` repetitions.

Examples:

```javascript
function lightsOn(switches) {
  // ...
}

lightsOn(5);        // [1, 4]
// Detailed result of each round for `5` lights
// Round 1: all lights are on
// Round 2: lights 2 and 4 are now off;     1, 3, and 5 are on
// Round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
// Round 4: lights 2 and 3 are now off;     1, 4, and 5 are on
// Round 5: lights 2, 3, and 5 are now off; 1 and 4 are on

lightsOn(100);      // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

console.log(lightsOn(5));        // [1, 4]
// Detailed result of each round for `5` lights
//   [false, false, false, false, false]
// Round 1: all lights are on
//   [true, true, true, true, true]
// Round 2: lights 2 and 4 are now off;     1, 3, and 5 are on
//   [true, false, true, false, true]
// Round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
//   [true, false, false, false, true]
// Round 4: lights 2 and 3 are now off;     1, 4, and 5 are on
//   [true, false, false, true, true]
// Round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
//   [true, false, false, true, false]

console.log(lightsOn(100));      // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
console.log(lightsOn('1'));      // []
console.log(lightsOn(-1));       // []
console.log(lightsOn(5.25));     // [1, 4]
console.log(lightsOn(0));        // []
//   input is not a number: empty array
//   input is not an integer: floor to integer
//   input is negative: empty array
//   input is 0: empty array
```

### Solution

```javascript
// Input: n - number of switches
// Output: array representing the number of switches that are ON after n passes
// Rules/Implicit Knowledge
//   each switch connected to exactly one light
//   switches numbered 1-n
//   lights initially OFF
//   subsequent passes skip some switches in a pattern
//     start 0 or 1? 1 seems to match description's logic
//     1: toggle all switches; skip 0
//     2: toggle even switches: skip odd
//     3: toggle switches divisible by 3; skip not divisble by 3
//     PATTERN: if (switch % counter === 0) toggle switch
// Examples
//   console.log(lightsOn(5));        // [1, 4]
//   console.log(lightsOn(100));      // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
// Edge Cases
//   input is not a number: empty array
//   input is not an integer: floor to integer
//   input is negative: empty array
//   input is 0: empty array
// Data Structure
//   array
//     return value is array
//     key operations: iteration/transformation, filtering
//     *** make sure to offset index: arrays are ZERO indexed, switches are ONE indexed
// Algorithm
//   validate input
//     if not a number or less than one, return empty array
//     if not an integer, floor it
//   initialize array of n lights: boolean initialized to false
//     initialize empty array
//     loop from 1 to n, pushing false into array
//   repetitions (toggling switches)
//     loop counter from 1 to n
//       forEach light
//         toggle matching lights (match: (index + 1) % counter === 0)
//         toggle: currentValue = !currentValue
//   reduce
//     accumulator: []
//     if currentValue is true, push currentIndex to accumulator
// Code

function lightsOn(switches) {
  if (typeof switches !== 'number' || switches < 1) return [];
  switches = Math.floor(switches);

  let lights = [];
  for (let counter = 1; counter <= switches; counter += 1) {
    lights.push(false);
  }

  for (let counter = 1; counter <= switches; counter += 1) {
    lights.forEach((light, index) => {
      if ((index + 1) % counter === 0) {
        lights[index] = !light;
      }
    });
  }

  let onLights = [];
  lights.forEach((light, index) => {
    if (light) onLights.push(index + 1);
  });
  return onLights;
}

console.log(lightsOn(5));        // [1, 4]
// Detailed result of each round for `5` lights
//   [false, false, false, false, false]
// Round 1: all lights are on
//   [true, true, true, true, true]
// Round 2: lights 2 and 4 are now off;     1, 3, and 5 are on
//   [true, false, true, false, true]
// Round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
//   [true, false, false, false, true]
// Round 4: lights 2 and 3 are now off;     1, 4, and 5 are on
//   [true, false, false, true, true]
// Round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
//   [true, false, false, true, false]

console.log(lightsOn(100));      // [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
console.log(lightsOn('1'));      // []
console.log(lightsOn(-1));       // []
console.log(lightsOn(5.25));     // [1, 4]
console.log(lightsOn(0));        // []
```

---

## 2. Diamonds

Write a function that displays a four-pointed diamond in an `n`x`n` grid, where `n` is an odd integer supplied as an argument to the function. You may assume that the argument will always be an odd integer.

Examples:

```javascript
diamond(1);
// logs
*
```

```javascript
diamond(3);
// logs
 *
***
 *
```

```javascript
diamond(9);
// logs
    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
```

### Solution

```javascript
// Input: odd integer n representing square grid in which to display a diamond composed of asterisks
// Output: a diamond of asterisks in an nxn grid
// Rules/Implicit Knowledge
//   n will always be a positive integer
//   output should be nxn grid
//   diamond will be n characters tall at tallest point
//   diamond will be n characters wide at widest point
//   diamond composed of: top half, middle, bottom half (reverse of top half)
//   row composed of: padding spaces, asterisks
// Examples
//   diamond(1);
//   *
//   diamond(3);
//    *
//   ***
//    *
//   diamond(9);
//       *
//      ***
//     *****
//    *******
//   *********
//    *******
//     *****
//      ***
//       *
//   patterns:
//     diamonds: 1, 3, 5, 7, 9 (2n - 1?)
//     spaces: 4, 3, 2, 1
// Edge Cases
// Data Structure: array of strings
// Algorithm
//   guard against n = 1: print 1 asterisk
//   initialize topHalf array
//   for counter from 1 to round of (n / 2)
//     generate a row with round of (n / 2) - counter spaces and (2 * counter - 1) asterisks
//     push row into topHalf array
//   generate a row of n asterisks for the middle
//   reverse the topHalf for the bottomHalf
//   log topHalf, middle, bottomHalf
// Code


let paddedStars = function paddedStars(numPads, numStars) {
  let result = '';

  for (let counter = 1; counter <= numPads; counter += 1) {
    result += ' ';
  }

  for (let counter = 1; counter <= numStars; counter += 1) {
    result += '*';
  }

  return result;
};

let diamond = function diamond(n) {
  if (n === 1) {
    console.log('*');
    return;
  }

  let topHalf = [];
  let middle = Math.round(n / 2);

  for (let counter = 1; counter < middle; counter += 1) {
    let numSpaces = (middle - counter);
    let numStars = ((counter * 2) - 1);
    topHalf.push(paddedStars(numSpaces, numStars));
  }

  let middleRow = paddedStars(0, n);
  let bottomHalf = topHalf.slice().reverse();
  let result = topHalf.concat(middleRow, bottomHalf);

  console.log(result.join('\n'));
};

diamond(1);
diamond(3);
diamond(5);
diamond(7);
diamond(9);
```

---

## 3. Now I Know My ABCs

A collection of spelling blocks has two letters per block, as shown in this list:

```
B:O   X:K   D:Q   C:P   N:A
G:T   R:E   F:S   J:W   H:U
V:I   L:Y   Z:M
```

This limits the words you can spell with the blocks to only those words that do not use both letters from any given block. You can also only use each block once.

Write a function that takes a word string as an argument, and returns `true` if the word can be spelled using the set of blocks, or `false` otherwise. You can consider the letters to be case-insensitive when you apply the rules.

Examples:

```javascript
isBlockWord('BATCH');      // true
isBlockWord('BUTCH');      // false
isBlockWord('jest');       // true
```

### Solution

```javascript
// Input: word string
// Output: boolean: whether or not the word string can be spelled with the specified blocks
// Rules/Implicit Knowledge
//   two letters per block
//   a block may only be used once
//   only one letter of the two letters in a block can be used
//   case insensitive
// Examples
//   isBlockWord('BATCH');      // true
//   isBlockWord('BUTCH');      // false
//   isBlockWord('jest');       // true
//   isBlockWord(123);          // false
//   isBlockWord('b@d');        // false
//   isBlockWord('');           // true
// Edge Cases
//   input not a string - return false
//   input contains invalid characters (not letters) return false - handled by algorithm
//   empty string - return true - handled by algorithm
// Data Structure
//   blocks: array of arrays
//   word: string
// Algorithm
//   guard against invalid input: return false if not a string
//   initialize blocks array
//     a block is an array with two letter strings
//     blocks array contains individual blocks as sub-arrays
//   iterate through each letter of word (need early termination, so use for loop)
//     find index of block that includes current letter (uppercased)
//     if no index (index === -1) return false
//     else remove block at index from blocks array
//   if succesfully iterated through all letters, return true
// Code

let isBlockWord = function isBlockWord(word) {
  if (typeof word !== 'string') return false;

  const blocks = [['B', 'O'], ['X', 'K'], ['D', 'Q'], ['C', 'P'], ['N', 'A'],
                  ['G', 'T'], ['R', 'E'], ['F', 'S'], ['J', 'W'], ['H', 'U'],
                  ['V', 'I'], ['L', 'Y'], ['Z', 'M']];

  for (let index = 0; index < word.length; index += 1) {
    let letter = word[index].toUpperCase();

    let matchIndex = blocks.findIndex(block => block.includes(letter));

    if (matchIndex === -1) {
      return false;
    } else {
      blocks.splice(matchIndex, 1);
    }
  }

  return true;
};

console.log(isBlockWord('BATCH') === true);
console.log(isBlockWord('BUTCH') === false);
console.log(isBlockWord('jest') === true);
console.log(isBlockWord(123) === false);
console.log(isBlockWord('b@d') === false);
console.log(isBlockWord('') === true);
```

---

## 4. Caesar Cipher

Write a function that implements the *Caesar Cipher*. The Caesar Cipher is one of the earliest and simplest ways to encrypt `plaintext` so that a message can be transmitted securely. It is a substitution cipher in which each letter in a `plaintext` is substituted by the letter located a given number of positions away in the alphabet. For example, if the letter `'A'` is *right-shifted* by `3` positions, it will be substituted with the letter `'D'`. This *shift* value is often referred to as the `key`. The "encrypted `plaintext`" (`ciphertext`) can be decoded using this `key` value.

The Caesar Cipher only encrypts letters (including both lower and upper case). Any other character is left as is. The substituted letters are in the same letter case as the original letter. If the `key` value for shifting exceeds the length of the alphabet, it wraps around from the beginning.

Examples:

```javascript
// simple shift
caesarEncrypt('A', 0);       // "A"
caesarEncrypt('A', 3);       // "D"

// wrap around
caesarEncrypt('y', 5);       // "d"
caesarEncrypt('a', 47);      // "v"

// all letters
caesarEncrypt('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 25);
// "ZABCDEFGHIJKLMNOPQRSTUVWXY"
caesarEncrypt('The quick brown fox jumps over the lazy dog!', 5);
// "Ymj vznhp gwtbs ktc ozrux tajw ymj qfed itl!"

// many non-letters
caesarEncrypt('There are, as you can see, many punctuations. Right?; Wrong?', 2);
// "Vjgtg ctg, cu aqw ecp ugg, ocpa rwpevwcvkqpu. Tkijv?; Ytqpi?"
```

### Solution

```javascript
// Input
//   plaintext: string
//   key: number representing how many letters to rightshift the plaintext
// Output: ciphertext - plaintext with each letter rightshifted key letters
// Rules/Implicit Knowledge
//   only shift letters; non-letters remain the same character
//   preserve case:
//     uppercase letters should be substituted with uppercase letters
//     lowercase letters should be substituted with lowercase letters
//   shifting wraps: if a letter shifts beyond the alphabet, wrap around back to the beginning
// Examples
//   see below
// Edge Cases
//   plaintext is not a string - return undefined
//   plaintext is empty - return empty string - handled by algorithm
//   key is not a number - return undefined
//   key is negative - left shift - handled by algorithm
//   key is not an integer - floor to integer
// Data Structure
//   plaintext: split to array of characters (main operation is map)
// Algorithm
//   validate input
//     plaintext
//       if not a string return undefined
//     key
//       if not a number return undefined
//       assign key to its floor
//   split plaintext to array of characters and map (return result)
//     if character is lowercase letter, rotate lowercase key times and return
//     if character is uppercase letter, rotate uppercase key times and return
//     else return character
//
//  rotate lowercase (letter, key)
//    lower bound = 'a'.charCodeAt(0) = 97
//    upper bound = 'z'.charCodeAt(0) = 122
//    new character code = add key to letter's character code
//    if new character code is greater than upper bound
//      new character code remainder upper bound, minus one, plus lower bound
//    return character from new character code
//  rotate uppercase (letter, key)
//    lower bound = 'A'.charCodeAt(0) = 65
//    upper bound = 'Z'.charCodeAt(0) = 90
//    new character code = add key to letter's character code
//    if new character code is greater than upper bound
//      new character code remainder upper bound, minus one, plus lower bound
//    return character from new character code
// Code

let rotate = function rotate(character, key, lowerBound, upperBound) {
  let newCharCode = character.charCodeAt(0) + key;
  if (newCharCode > upperBound) {
    newCharCode = (newCharCode % upperBound) - 1 + lowerBound;
  } else if (newCharCode < lowerBound) {
    newCharCode = newCharCode + (upperBound - lowerBound);
  }

  return String.fromCharCode(newCharCode);
};

let rotateLower = function rotateLower(character, key) {
  const lowerBound = 'a'.charCodeAt(0);
  const upperBound = 'z'.charCodeAt(0);

  return rotate(character, key, lowerBound, upperBound);
};

let rotateUpper = function rotateLower(character, key) {
  const lowerBound = 'A'.charCodeAt(0);
  const upperBound = 'Z'.charCodeAt(0);

  return rotate(character, key, lowerBound, upperBound);
};

let caesarEncrypt = function caesarEncrypt(plaintext, key) {
  if (typeof plaintext !== 'string' || typeof key !== 'number') return;
  key = Math.floor(key);

  return plaintext.split('').map(character => {
    if (/[a-z]/.test(character)) {
      return rotateLower(character, key);
    } else if (/[A-Z]/.test(character)) {
      return rotateUpper(character, key);
    } else {
      return character;
    }
  }).join('');
};

// console.log(rotateLower('a', 0));       // "a"
// console.log(rotateLower('a', 1));       // "b"
// console.log(rotateLower('y', 5));       // "d"
// console.log(rotateLower('a', 47));      // "v"

// console.log(rotateUpper('A', 0));       // "A"
// console.log(rotateUpper('A', 1));       // "B"
// console.log(rotateUpper('Y', 5));       // "D"
// console.log(rotateUpper('A', 47));      // "V"

// simple shift
console.log(caesarEncrypt('A', 0));       // "A"
console.log(caesarEncrypt('A', 3));       // "D"

// wrap around
console.log(caesarEncrypt('y', 5));       // "d"
console.log(caesarEncrypt('a', 47));      // "v"

// all letters
console.log(caesarEncrypt('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 25));
// "ZABCDEFGHIJKLMNOPQRSTUVWXY"
console.log(caesarEncrypt('The quick brown fox jumps over the lazy dog!', 5));
// "Ymj vznhp gwtbs ktc ozrux tajw ymj qfed itl!"

// many non-letters
console.log(caesarEncrypt('There are, as you can see, many punctuations. Right?; Wrong?', 2));
// "Vjgtg ctg, cu aqw ecp ugg, ocpa rwpevwcvkqpu. Tkijv?; Ytqpi?"


// plaintext is not a string - return undefined
console.log(caesarEncrypt(123, 0));          // undefined
// plaintext is empty - return empty string
console.log(caesarEncrypt('', 3));           // ''
// key is not a number - return undefined
console.log(caesarEncrypt('abcdef', '3'));   // undefined
// key is negative - left shift
console.log(caesarEncrypt('abcdef', -3));    // 'xyzabc'
// key is not an integer - floor to integer
console.log(caesarEncrypt('abcdef', 3.5));    // 'defghi'
```

---

## 5. Vigenere Cipher

The *Vigenere Cipher* encrypts alphabetic text using [polyalphabetic substitution](https://en.wikipedia.org/wiki/Polyalphabetic_cipher). It uses a series of *Caesar Ciphers* based on the letters of a `keyword`. Each letter of the `keyword` is treated as a shift value. For instance, the letter `'B'` corresponds to a shift value of `1`, and the letter `'d'` corresponds to a shift value of `3`. In other words, the shift value used for a letter is equal to its index value in the alphabet. This means that the letters `'a'-'z'` are equivalent to the numbers `0-25`. The uppercase letters `'A'-'Z'` are also equivalent to `0-25`.

Applying the Vigenere Cipher is done sequentially for each character by applying the current shift value to a Caesar Cipher for that particular character. To make this more concrete, let's look at the following example:

```
plaintext: Pineapples don't go on pizzas!
keyword: meat

Applying the Vigenere Cipher for each alphabetic character:
plaintext : Pine appl esdo ntgo onpi zzas
shift     : meat meat meat meat meat meat
ciphertext: Bmnx mtpe qwdh zxgh arpb ldal

result: Bmnxmtpeqw dhz'x gh ar pbldal!
```

Notice that in the example, the key isn't moved forward if the character isn't in the alphabet. Like the Caesar Cipher, the Vigenere Cipher only encrypts alphabetic characters.

Write a function that implements the Vigenere Cipher. The case of the `keyword` doesn't matter — in other words, the resulting encryption won't change depending on the case of the `keyword`'s letters (e.g., `'MEat' === 'mEaT'`).

> For a quick lookup of a ciphertext per character, you may consult this [tabula recta](https://en.wikipedia.org/wiki/Tabula_recta). Each row of the table corresponds to a Caesar Cipher encryption using the columns' character letter as a shift value.

### Solution

```javascript
// Input
//   plaintext: string to be encrypted
//   keyword: string representing an array of shift values
// Output: ciphertext - string representing encrypted version plaintext
// Rules/Implicit Knowledge
//   each letter of the keyword represents a shift value based on letter's alphabetic index, e.g. a is 0, b is 1, z is 25
//   keyword is case insensitive (MEat is the same as mEaT)
//   keyword is applied sequentially to plaintext (only to letters) and then repeated (see example)
//   only letters are shifted; non-letters remain unchanged
// Examples
//   vigenereEncrypt("Pineapples don't go on pizzas!", 'meat');   // "Bmnxmtpeqw dhz'x gh ar pbldal!"
//     plaintext : Pine appl esdo ntgo onpi zzas
//     shift     : meat meat meat meat meat meat
//     ciphertext: Bmnx mtpe qwdh zxgh arpb ldal
// Edge Cases
//   plaintext
//     not a string - return undefined
//     empty string - return empty string - handled by algorithm
//   keyword
//     not a string - return undefined
//     empty string - return plaintext
//     invalid characters - treat as 0 shift value
// Data Structure
//   plaintext: split to array of characters (main operation is map)
//   keyword: leave as string, only need to iterate (do so with index)
//   shift value lookup: array of letters
//   shifting a letter: mathematically calculate
// Algorithm
//   validate input
//     if plaintext not a string return undefined
//     if keyword not a string return undefined
//     *** handle if keyword is empty (if not handled elsewhere) ***
//   initialize keywordIndex counter to zero to track current index in keyword
//   split plaintext to array of characters and map
//     if character is letter, rotate
//       shift value function: takes keyword, keywordIndex
//         initialize letter lookup array ['a', 'b', ..., 'z']
//         reassign keywordIndex to keywordIndex remainder keyword length
//         get keyword letter from keywordIndex (set case to match lookup array)
//         lookup shift value with keyword letter and return it
//       rotate character function: takes character, shift value
//         if lower case
//           lower bound is character code of 'a'
//           upper bound is character code of 'z'
//         if upper case
//           lower bound is character code of 'A'
//           upper bound is character code of 'Z'
//         current character code is character code of character plus shift value
//         if current character code is greater than upper bound
//           current character code remainder upper bound plus lower bound plus 1
//         return character of current character code
//       increment keywordIndex
//     else return character
//   return joined array of characters
// Code


let getShiftValue = function getShiftValue(keyword, index) {
  const letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
    'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

  index %= keyword.length;
  // if keyLetter is invalid (not a letter), use 'A' so shift value is zero
  let keyLetter = keyword[index] || 'A';

  return letters.findIndex(letter => letter === keyLetter.toUpperCase());
};

let shiftLetter = function shiftLetter(character, shiftValue) {
  let lowerBound;
  let upperBound;

  if (/[a-z]/.test(character)) {
    lowerBound = 'a'.charCodeAt(0);
    upperBound = 'z'.charCodeAt(0);
  } else if (/[A-Z]/.test(character)) {
    lowerBound = 'A'.charCodeAt(0);
    upperBound = 'Z'.charCodeAt(0);
  } else {
    return character;
  }

  let charCode = character.charCodeAt(0) + shiftValue;
  if (charCode > upperBound) charCode = (charCode % upperBound) + lowerBound - 1;
  return String.fromCharCode(charCode);
};

let vigenereEncrypt = function vigenereEncrypt(plaintext, keyword) {
  if (typeof plaintext !== 'string' || typeof keyword !== 'string') return;

  let keywordIndex = 0;

  return plaintext.split('').map(character => {
    if (/[a-z]/i.test(character)) {
      let shiftValue = getShiftValue(keyword, keywordIndex);
      let shiftedCharacter = shiftLetter(character, shiftValue);

      keywordIndex += 1;
      return shiftedCharacter;
    } else {
      return character;
    }
  }).join('');
};

console.log(vigenereEncrypt("Pineapples don't go on pizzas!", 'meat'));   // "Bmnxmtpeqw dhz'x gh ar pbldal!"

console.log(vigenereEncrypt(123, 'meat'));           // undefined
console.log(vigenereEncrypt('', 'meat'));            // ''
console.log(vigenereEncrypt('hello', 3));            // undefined
console.log(vigenereEncrypt('hello', ''));           // 'hello'
console.log(vigenereEncrypt('hello', 'popsicle'));   // 'wsadw'
console.log(vigenereEncrypt('hElLo', 'popsicle'));   // 'wSaDw'
console.log(vigenereEncrypt('h3ll0', 'popsicle'));   // 'w3za0'
```

---

## 6. Seeing Stars

Write a function that displays an 8-pointed star in an `n`x`n` grid, where `n` is an odd integer that is supplied as an argument to the function. The smallest such star you need to handle is a `7`x`7` grid (i.e., when `n` is `7`).

Examples:

```javascript
star(7);
// logs
*  *  *
 * * *
  ***
*******
  ***
 * * *
*  *  *

star(9);
// logs
*   *   *
 *  *  *
  * * *
   ***
*********
   ***
  * * *
 *  *  *
*   *   *
```

### Solution

```javascript
// Input: integer n representing number of rows and columns in nxn grid
// Output: log eight pointed star in nxn grid
// Rules/Implicit Knowledge
//   input will be odd integer of at least 7
//   logged output should have n rows and n columns
//   eight pointed star:
//     three points on the top
//     two points in the middle
//     three points on the bottom
//   bottom is inversion of top (reversed top if representing as array of strings)
//   middle is n asterisks
//   "body" of star is composed of asterisks
//   positioning accomplished by padding with spaces
//   every row but middle has 3 asterisks
//
//   start with bottom (looks easier):
//   padding spaces
//     starts as (n - 3) / 2
//     decrements by 1 each row
//     ends with 0 on last row
//   asterisk
//     starts as 3 with 0 separating spaces
//     stays as 3; separating spaces increment by 1 each row
//
// Examples (see below)
// Edge Cases
// Data Structure: array of strings
//   top can be reversed to generate bottom
// Algorithm
//   middle is n asterisks
//   bottom
//     for counter starting at 0 to less than floor of (n / 2) times
//       paddingCount: ((n - 3) / 2) - counter
//       spacingCount: counter
//       generate row (separate function, takes paddingCount, spacingCount)
//         row = padding + body
//           body = '*' + spacing + star + spacing
//   top: copy and reverse bottom
//   concatenate top, middle, and bottom then join with newlines and log
// Code

let generateRow = function generateRow(paddingCount, spacingCount) {
  let padding = ' '.repeat(paddingCount);
  let body = '*' + ' '.repeat(spacingCount) + '*' + ' '.repeat(spacingCount) + '*';
  return padding + body;
};

let star = function star(n) {
  const middle = '*'.repeat(n);

  const bottom = [];
  for (let counter = 0; counter < Math.floor(n / 2); counter += 1) {
    let paddingCount = ((n - 3) / 2) - counter;
    bottom.push(generateRow(paddingCount, counter));
  }

  const top = bottom.slice().reverse();

  console.log(top.concat(middle, bottom).join('\n'));
};

star(7);
// logs
// *  *  *
//  * * *
//   ***
// *******
//   ***
//  * * *
// *  *  *

star(9);
// logs
// *   *   *
//  *  *  *
//   * * *
//    ***
// *********
//    ***
//   * * *
//  *  *  *
// *   *   *
```
