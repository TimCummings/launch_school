
# Problem 2 - 11/23/2020

The Luhn formula is a simple checksum formula used to validate a variety of identification numbers, such as credit card numbers and Canadian Social Insurance Numbers.

The formula verifies a number against its included check digit, which is usually appended to a partial number to generate the full number. This number must pass the following test:

* Counting from the rightmost digit and moving left, double the value of every second digit
* For any digit that thus become 10 or more, subtract 9 from the result
  * 1111 becomes 2121
  * 8763 becomes 7733 (from 2 x 6 = 12 -> 12 - 9 = 3 and 2 x 8 = 16 -> 16 - 9 = 7)
* Add all these digits together
  * 1111 becomes 2121 sums as 2 + 1 + 2 + 1 to give a checksum of 6
  * 8763 becomes 7733, and 7 + 7 + 3 + 3 is 20

If the total (the checksum) ends in 0 (put another way, if the total modulo 10 is congruent to 0), then the number is valid according to the Luhn Formula; else it is not valid. Thus, 1111 is not valid (as shown above, it comes out to 6), while 8763 is valid (as shown above, it comes out to 20).

Write a program that, given a number in string format, check if it is valid per the Luhn formula. This should treat, for example, "2323 2005 7766 3554" as valid. You can ignore all non-numeric characters in the input string.

### Solution

```javascript
// Input: number in string format (string of digits)
// Output: boolean representing whether or not the input is a valid Luhn number
// Rules/Implicit Knowledge
//   * ignore any non-digit characters
//   * a valid number number is one whose checksum ends is 0 (checksum % 10 === 0)
//   * checksum is computed by:
//     * starting from the least significant (rightmost) digit and moving left
//       * double every second digit (not the first)
//       * if a doubled digit is greater than or equal to 10, subtract 9 from it
//     * after doubling every other digit, add all digits together; this sum is the checksum
// Examples
//   * 1111: false (becomes 2121 -> checksum of 6)
//   * 8763: true ( becomes 7733 -> checksum of 20)
// Edge Cases
//   * string with invalid characters
//   * empty string
// Data Structure
//   * array of characters (will need to be reversed and iterated)
// Algorithm
//   * checksum function:
//     * split number string into array of characters and reverse it
//     * map reversed array: if index is odd:
//       * coerce string digit to number
//       * double digit
//       * if doubled digit is >= 10, subtract 9 from it
//       * return digit
//     * reduce by summing and return the sum (this is the checksum)
//   * main isLuhn function:
//     * if input is empty string or not a string, return false
//     * remove invalid characters (non-digits) and pass to checksum function
//     * return whether or not checksum is evenly divisble by 10
// Code

let checksum = function checksum(value) {
  return value.split('').reverse().map((digit, index) => {
    if (index % 2 === 1) {
      digit = Number(digit) * 2;
      if (digit >= 10) digit -= 9;
      return digit;
    } else {
      return Number(digit);
    }
  }).reduce((sum, digit) => sum + digit);
};

let isLuhn = function isLuhn(numberString) {
  if (typeof numberString !== 'string') return false;

  numberString = numberString.replace(/\D/g, '');
  if (numberString === '') return false;

  return checksum(numberString) % 10 === 0;
};

console.log(isLuhn('1111') === false);
console.log(isLuhn('11a-1.1') === false);
console.log(isLuhn('8763') === true);
console.log(isLuhn('87a-6.3') === true);
console.log(isLuhn('2323 2005 7766 3554') === true);
console.log(isLuhn('') === false);
console.log(isLuhn('abc') === false);
```
