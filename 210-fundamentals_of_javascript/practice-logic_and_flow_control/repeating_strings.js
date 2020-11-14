// Repeating Strings

// Implement a function that takes a string and a number times as arguments. The function should return the string repeated times number of times. If times is not a number, return undefined. If it is a negative number, return undefined also. If times is 0, return an empty string. You may ignore the possibility that times is a number that isn't an integer.

// function repeat(string, times) {
//   // …
// }

console.log(repeat('abc', 1));       // "abc"
console.log(repeat('abc', 2));       // "abcabc"
console.log(repeat('abc', -1));      // undefined
console.log(repeat('abc', 0));       // ""
console.log(repeat('abc', 'a'));     // undefined
console.log(repeat('abc', false));   // undefined
console.log(repeat('abc', null));    // undefined
console.log(repeat('abc', '  '));    // undefined

// You may concatenate strings, but you may not use any other properties or methods from JavaScript's built-in String class.

function repeat(string, times) {
  if (typeof(times) !== 'number' || times < 0) return undefined;

  let repeatedString = '';

  for (let counter = 1; counter <= times; counter += 1) {
    repeatedString += string;
  }

  return repeatedString;
}
