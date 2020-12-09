
# Problem 3 - 11/23/2020

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
// Input: string representing a word
// Output: boolean representing whether or not the input word can be spelled with the provided collection of two letter blocks
// Rules/Implicit Knowledge
//   * word blocks:
//       B:O   X:K   D:Q   C:P   N:A
//       G:T   R:E   F:S   J:W   H:U
//       V:I   L:Y   Z:M
//     * you may only use one letter on a block (not both)
//     * a block may only be used once
//   * case does not matter ('abc' === 'ABC')
// Examples
//   console.log(isBlockWord('BATCH') === true);
//   console.log(isBlockWord('batch') === true);
//   console.log(isBlockWord('BUTCH')=== false);
//   console.log(isBlockWord('butch')=== false);
//   console.log(isBlockWord('jest') === true);
//   console.log(isBlockWord('abc xyz') === true);
//   console.log(isBlockWord('abc 123') === false);
//   console.log(isBlockWord([]) === false);
//   console.log(isBlockWord({}) === false);
//   console.log(isBlockWord(123) === false);
// Edge Cases
//   * not a string: false
//   * empty string: false
//   * string with non-letter characters: false
//   * string with more than one word: ignore whitespace
// Data Structure
//   * block lookup: array of arrays
//     * lookup by checking if block (inner array) contains the letter being sought
//     * a block (inner array) can be deleted when used
// Algorithm
//   * if input is not a string or is an empty string return false
//   * if input contains invalid characters (anything other than letters or spaces) return false
//   * initialize lookup array containing blocks as inner arrays, e.g. [ ['B', 'O'], ['X', 'K'], ... ]
//   * iterate through characters of input word
//     * continue to next iteration if current character is a space
//     * search array of blocks for current letter (using findIndex and includes)
//     * return false if matching block is not found
//     * if block is found, delete it from the array and continue iteration
//   * if iteration finishes, return true
// Code

let isBlockWord = function isBlockWord(word) {
  if (typeof word !== 'string' || word === '') return false;
  if (/[^A-Z ]/.test(word.toUpperCase())) return false;

  let blocksArray = [
    ['B', 'O'], ['X', 'K'], ['D', 'Q'], ['C', 'P'], ['N', 'A'], ['G', 'T'],
    ['R', 'E'], ['F', 'S'], ['J', 'W'], ['H', 'U'], ['V', 'I'], ['L', 'Y'],
    ['Z', 'M']
  ];

  for (let index = 0; index < word.length; index += 1) {
    let letter = word[index].toUpperCase();
    if (letter === ' ') continue;

    let blockIndex = blocksArray.findIndex(block => block.includes(letter));
    if (blockIndex === -1) return false;
    blocksArray.splice(blockIndex, 1);
  }

  return true;
};

console.log(isBlockWord('BATCH') === true);
console.log(isBlockWord('batch') === true);
console.log(isBlockWord('BUTCH') === false);
console.log(isBlockWord('butch') === false);
console.log(isBlockWord('jest') === true);
console.log(isBlockWord('abc xyz') === true);
console.log(isBlockWord('abc 123') === false);
console.log(isBlockWord([]) === false);
console.log(isBlockWord({}) === false);
console.log(isBlockWord(123) === false);
```
