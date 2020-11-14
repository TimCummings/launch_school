// Converting Strings to Lower Case

// Write a function that returns a string converted to lowercase.

// To convert a single uppercase character to a lowercase character, get its ASCII numeric representation from the [ASCII table](http://www.asciitable.com/), add 32 to that number, then convert the number back to a character using the same ASCII table. You can use the String.fromCharCode and the String.charCodeAt methods for these operations. For example:

// let string = 'A';
// let asciiNumeric = string.charCodeAt(0);         // 65
// let asciiNumeric += 32;
// string = String.fromCharCode(asciiNumeric);  // "a", converted to lowercase

// Examples

// function toLowerCase(string) {
//   // …
// }

console.log(toLowerCase('ALPHABET'));    // "alphabet"
console.log(toLowerCase('123'));         // "123"
console.log(toLowerCase('abcDEF'));      // "abcdef"

// You may use the square brackets ([]) to access a character by index (as shown below), and the length property to find the string length. However, you may not use any other properties or methods from JavaScript's built-in String class.

// 'hello'[0];    // "h"
// 'hello'[4];    // "o"

// function toLowerCase(string) {
//   const UPPER_TO_LOWER_OFFSET = 32;
//   const A_CHAR_CODE = 'A'.charCodeAt(0);
//   const Z_CHAR_CODE = 'Z'.charCodeAt(0);

//   let lowerString = '';

//   for (let index = 0; index < string.length; index += 1) {
//     let currentCode = string[index].charCodeAt(0);
//     if (currentCode >= A_CHAR_CODE && currentCode <= Z_CHAR_CODE) {
//       let lowerChar = String.fromCharCode(currentCode + UPPER_TO_LOWER_OFFSET);
//       lowerString += lowerChar;
//     } else {
//       lowerString += string[index];
//     }
//   }

//   return lowerString;
// }



// Adjustments based on provided solution
// Recall that JavaScript compares string lexicographically. To determine whether a character is uppercase, it can be compared directly to 'A' and 'Z'; there is no need to compare against their ASCII codes. This simplifies our code, makes it easier to read, and eliminates two `const`s.

function toLowerCase(string) {
  const UPPER_TO_LOWER_OFFSET = 32;

  let lowerString = '';

  for (let index = 0; index < string.length; index += 1) {
    if (string[index] >= 'A' && string[index] <= 'Z') {
      let currentCode = string[index].charCodeAt(0);
      let lowerChar = String.fromCharCode(currentCode + UPPER_TO_LOWER_OFFSET);
      lowerString += lowerChar;
    } else {
      lowerString += string[index];
    }
  }

  return lowerString;
}
