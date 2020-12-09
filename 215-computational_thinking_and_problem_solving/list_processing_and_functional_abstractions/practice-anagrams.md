
# Practice Problem: Anagrams - 11/16/2020

Write a Function named `anagram` that takes two arguments: a word and an array of words. Your function should return an array that contains all the words from the array argument that are anagrams of the word argument. For example, given the word "listen" and an array of candidate words like "enlist", "google", "inlets", and "banana", the program should return an array that contains "enlist" and "inlets".

Examples

```javascript
function anagram(word, list) {
  // ...
}

anagram('listen', ['enlists', 'google', 'inlets', 'banana']);  // [ "inlets" ]
anagram('listen', ['enlist', 'google', 'inlets', 'banana']);   // [ "enlist", "inlets" ]
```

### Solution

1. Write a `getLetterCounts` function that takes a word as an argument and returns an object with the words letters (downcased) as keys and counts of those letters as values. Internally, this can use `forEach`.
2. Write an `isAnagram` function that takes two words and compares their letter counts, returning true or false if the counts are the same. Because JavaScript compares objects by reference (if they're the same object or not), this will need to iterate the keys of one object and compare the values to the other object (and make sure the length of keys is the same.)
3. Finally, filter the `list` array to words that are anagrams and return them.

```javascript
let getLetterCounts = function getLetterCounts(word) {
  let letterCounts = {};

  word.split('').forEach(word => {
    word = word.toLowerCase();
    if (!letterCounts[word]) letterCounts[word] = 0;
    letterCounts[word] += 1;
  });

  return letterCounts;
};

let isAnagram = function isAnagram(word1, word2) {
  if (word1.length !== word2.length) return false;

  let letterCounts1 = getLetterCounts(word1);
  let letterCounts2 = getLetterCounts(word2);

  let letters = Object.keys(letterCounts1);

  for (let index = 0; index < letters.length; index += 1) {
    let letter = letters[index];
    if (letterCounts1[letter] !== letterCounts2[letter]) return false;
  }

  return true;
};

let anagram = function anagram(word, list) {
  return list.filter(element => isAnagram(word, element));
};
```
