// Trimming Spaces

// Write a function that takes a string as an argument, and returns the string stripped of spaces from both ends. Do not remove or alter internal spaces.
// Example

console.log(trim('  abc  '));  // "abc"
console.log(trim('abc   '));   // "abc"
console.log(trim(' ab c'));    // "ab c"
console.log(trim(' a b  c'));  // "a b  c"
console.log(trim('      '));   // ""
console.log(trim(''));         // ""

// You may use the square brackets ([]) to access a character by index (as shown below), and the length property to find the string length. However, you may not use any other properties or methods from JavaScript's built-in String class.

// 'hello'[0];       // "h"
// 'hello'[4];       // "o"

function firstNonSpaceIndex(string) {
  for (let index = 0; index < string.length; index += 1) {
    if (string[index] === ' ') continue;
    return index;
  }
}

function lastNonSpaceIndex(string) {
  for (let index = string.length - 1; index >= 0; index -= 1) {
    if (string[index] === ' ') continue;
    return index;
  }
}

function trim(string) {
  let start = firstNonSpaceIndex(string);
  let end = lastNonSpaceIndex(string);

  // this is probably unnecessary but might make a difference with long strings
  if (start === 0 && end === string.length) return string;

  let trimmedString = '';

  for (let index = start; index <= end; index += 1) {
    trimmedString += string[index];
  }

  return trimmedString;
}
