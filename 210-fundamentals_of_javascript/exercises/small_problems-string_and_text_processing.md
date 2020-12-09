
# JS210/215 Small Problems: String and Text Processing - 11/20/2020

## 1. Uppercase Check

Write a function that takes a string argument, and returns `true` if all of the alphabetic characters inside the string are uppercase; false otherwise. Ignore characters that are not alphabetic.

Examples:

```javascript
isUppercase('t');               // false
isUppercase('T');               // true
isUppercase('Four Score');      // false
isUppercase('FOUR SCORE');      // true
isUppercase('4SCORE!');         // true
isUppercase('');                // true
```

### Solution

```javascript
let isUppercase = function isUppercase(string) {
  for (let index = 0; index < string.length; index += 1) {
    if (string[index] !== string[index].toUpperCase()) return false;
  }

  return true;
};
```

---

## 2. Delete Vowels

Write a function that takes an array of strings, and returns an array of the same strings values without the vowels (a, e, i, o, u).

Examples:

```javascript
removeVowels(['abcdefghijklmnopqrstuvwxyz']);         // ["bcdfghjklmnpqrstvwxyz"]
removeVowels(['green', 'YELLOW', 'black', 'white']);  // ["grn", "YLLW", "blck", "wht"]
removeVowels(['ABC', 'AEIOU', 'XYZ']);                // ["BC", "", "XYZ"]
```

### Solution

```javascript
let removeVowels = function removeVowels(strings) {
  return strings.map(text => text.replace(/[aeiou]/gi, ''));
};
```

---

## 3. Lettercase Counter

Write a function that takes a string and returns an object containing three properties: one representing the number of characters in the string that are lowercase letters, one representing the number of characters that are uppercase letters, and one representing the number of characters that are neither.

Examples:

```javascript
letterCaseCount('abCdef 123');  // { lowercase: 5, uppercase: 1, neither: 4 }
letterCaseCount('AbCd +Ef');    // { lowercase: 3, uppercase: 3, neither: 2 }
letterCaseCount('123');         // { lowercase: 0, uppercase: 0, neither: 3 }
letterCaseCount('');            // { lowercase: 0, uppercase: 0, neither: 0 }
```

### Solution

```javascript
let letterCaseCount = function letterCaseCount(string) {
  let lowercase = string.match(/[a-z]/g) || [];
  let uppercase = string.match(/[A-Z]/g) || [];

  return {
    lowercase: lowercase.length,
    uppercase: uppercase.length,
    neither: string.length - (lowercase.length + uppercase.length),
  };
};
```

---

## 4. Capitalize Words

Write a function that takes a string as an argument, and returns that string with the first character of every word capitalized and all subsequent characters in lowercase.

You may assume that a word is any sequence of non-whitespace characters.

Examples:

```javascript
wordCap('four score and seven');       // "Four Score And Seven"
wordCap('the javaScript language');    // "The Javascript Language"
wordCap('this is a "quoted" word');    // 'This Is A "quoted" Word'
```

### Solution

```javascript
let capitalize = function capitalize(word) {
  return word[0].toUpperCase() + word.slice(1).toLowerCase();
};

let wordCap = function wordCap(string) {
  return string.split(/\s+/)
               .map(capitalize)
               .join(' ');
};
```

---

## 5. Swap Case

Write a function that takes a string as an argument, and returns that string with every lowercase letter changed to uppercase and every uppercase letter changed to lowercase. Leave all other characters unchanged.

Examples:

```javascript
swapCase('CamelCase');              // "cAMELcASE"
swapCase('Tonight on XYZ-TV');      // "tONIGHT ON xyz-tv"
```

### Solution

```javascript
let swapCharCase = function swapCharCase(char) {
  if (/[a-z]/.test(char)) return char.toUpperCase();
  if (/[A-Z]/.test(char)) return char.toLowerCase();
  return char;
};

let swapCase = function swapCase(string) {
  return string.split('')
               .map(swapCharCase)
               .join('');
};
```

---

## 6. Staggered Caps Part 1

Write a function that takes a string as an argument, and returns that string with a staggered capitalization scheme. Every other character, starting from the first, should be capitalized and should be followed by a lowercase or non-alphabetic character. Non-alphabetic characters should not be changed, but should be counted as characters for determining when to switch between upper and lower case.

Examples:

```javascript
staggeredCase('I Love Launch School!');        // "I LoVe lAuNcH ScHoOl!"
staggeredCase('ALL_CAPS');                     // "AlL_CaPs"
staggeredCase('ignore 77 the 4444 numbers');   // "IgNoRe 77 ThE 4444 nUmBeRs"
```

### Solution

```javascript
let staggeredCase = function staggeredCase(string) {
  return string.split('').map((char, index) => {
    if (index % 2 === 0) return char.toUpperCase();
    return char.toLowerCase();
  }).join('');
};
```

---

## 7. Staggered Caps Part 2

Modify the function from the previous exercise so that it ignores non-alphabetic characters when determining whether a letter should be upper or lower case. Non-alphabetic characters should still be included in the output string, but should not be counted when determining the appropriate case.

Examples:

```javascript
staggeredCase('I Love Launch School!');        // "I lOvE lAuNcH sChOoL!"
staggeredCase('ALL CAPS');                     // "AlL cApS"
staggeredCase('ignore 77 the 444 numbers');    // "IgNoRe 77 ThE 444 nUmBeRs"
```

### Solution

```javascript
let staggeredCase = function staggeredCase(string) {
  let upperFlag = true;

  return string.split('').map(char => {
    if (char.match(/[a-z]/i)) {
      char = upperFlag ? char.toUpperCase() : char.toLowerCase();
      upperFlag = !upperFlag;
    }

    return char;
  }).join('');
};
```

---

## 8. How Long Are You

Write a function that takes a string as an argument, and returns an array that contains every word from the string, with each word followed by a space and the word's `length`. If the argument is an empty string or if no argument is passed, the function should return an empty array.

You may assume that every pair of words in the string will be separated by a single space.

Examples:

```javascript
wordLengths('cow sheep chicken');
// ["cow 3", "sheep 5", "chicken 7"]

wordLengths('baseball hot dogs and apple pie');
// ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

wordLengths("It ain't easy, is it?");
// ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

wordLengths('Supercalifragilisticexpialidocious');
// ["Supercalifragilisticexpialidocious 34"]

wordLengths('');      // []
wordLengths();        // []
```

### Solution

```javascript
let wordLengths = function wordLengths(text) {
  if (!text) return [];
  return text.split(' ').map(word => word + ` ${word.length}`);
};
```

---

## 9. Search Word Part 1

Write a function that takes a `word` and a string of `text` as arguments, and returns an integer representing the number of times the `word` appears in the `text`.

You may assume that the `word` and `text` inputs will always be provided.

Example:

```javascript
const text = 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?';

searchWord('sed', text);      // 3
```

### Solution

```javascript
let searchWord = function searchWord(word, text) {
  let regexp = new RegExp(word, 'gi');
  return text.match(regexp).length;
};
```

#### Adjustments based on provided solution

My solution errors when there are no matches: it asks for the `length` of `null`. To fix this, `null` return values from `String.prototype.match()` need to be checked for and handled:

```javascript
let searchWord = function searchWord(word, text) {
  let regexp = new RegExp(word, 'gi');
  let matches = text.match(regexp);
  return matches ? matches.length : 0;
};
```

#### Further Exploration

The current solution matches the `word` even when it is just a part of a bigger word, instead of a whole word by itself. For example, when searching for `'qui'` in the `text`, this solution would also return `'quia'` as a match:

```javascript
searchWord('qui', text);      // should return 4, NOT 13
```

Can you refactor the current solution so that it only matches whole words? In addition to this, can you also include input validation to handle cases in which one or both arguments are missing?

Hint: If you cannot figure out how to match whole words only, check out [this section](https://launchschool.com/books/regex/read/anchors#wordbounds) of our Introduction to Regular Expressions book.

##### FE Solution

```javascript
let searchWord = function searchWord(word, text) {
  let regexp = new RegExp(`\\b${word}\\b`, 'gi');
  let matches = text.match(regexp);
  return matches ? matches.length : 0;
};
```

---

## 10. Search Word Part 2

The function from the previous exercise returns the number of occurrences of a word in some text. Although this is useful, there are also situations in which we just want to find the word in the context of the text.

For this exercise, write a function that takes a `word` and a string of `text` as arguments, and returns the `text` with every instance of the `word` highlighted. To highlight a word, enclose the word with two asterisks (`'**'`) on each side and change every letter of the word to uppercase (e.g., `'**HIGHLIGHTEDWORD**'`).

Example:

```javascript
const text = 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?';

console.log(searchWord('sed', text));
// returns
// "**SED** ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, **SED** quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, **SED** quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
```

### Solution

```javascript
let searchWord = function searchWord(word, text) {
  let regexp = new RegExp(`\\b${word}\\b`, 'gi');
  return text.replace(regexp, match => `**${match.toUpperCase()}**`);
};
```

#### Adjustments based on provided solution

Since we already know what `word` is, we can simplify `String.prototype.replace()` - there's no need to pass a callback function:

```javascript
let searchWord = function searchWord(word, text) {
  let regexp = new RegExp(`\\b${word}\\b`, 'gi');
  return text.replace(regexp, `**${word.toUpperCase()}**`);
};
```
