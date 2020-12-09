
# Problem 1 - 11/23/2020

Write a program that cleans up user-entered phone numbers so that they can be sent as SMS messages. Other than digits, the number may also contain special character such as spaces, dash, dot, and parentheses that should be ignored.

The rules are as follows:

* If the phone number is less than 10 digits, assume that it is a bad number.
* If the phone number is 10 digits, assume that it is good.
* If the phone number is 11 digits and the first number is 1, trim the 1 and use the last 10 digits.
* If the phone number is 11 digits and the first number is not 1, then it is a bad number.
* If the phone number is more than 11 digits, assume that it is a bad number.

For bad numbers, just a return a string of 10 0s.

### Solution

```javascript
// Input: string representing a phone number
// Output: string representing "cleaned up" phone number
// Rules/Implicit Knowledge
//   * ignore non-digit characters
//     * problem specifies input may contain spaces, dashes, dots, or parentheses, which should be ignored
//     * What about other characters, e.g. letters? Other whitespace? Empty strings?
//       * Nobody to ask; I will return '0000000000'.
//   * return '0000000000' for any invalid phone number
//   * a valid phone number can only have 10 or 11 digits
//   * an 11 digit number must start with 1 or it is invalid
//   * for an 11 digit number that starts with 1, trim the 1 and use only the remaining 10 digits
// Examples
//   happy path
//     phoneCleaner('1234567890') === '1234567890';
//     phoneCleaner('123 456 7890') === '1234567890';
//     phoneCleaner('123-456-7890') === '1234567890';
//     phoneCleaner('123.456.7890') === '1234567890';
//     phoneCleaner('(123)4567890') === '1234567890';
//     phoneCleaner('11234567890') === '1234567890';

//   wrong number of digits
//     phoneCleaner('123456789') === '0000000000';
//     phoneCleaner('91234567890') === '0000000000';
//     phoneCleaner('1234567890') === '0000000000';
//     phoneCleaner('(123)456.789') === '0000000000';
//     phoneCleaner('9123_456 7890') === '0000000000';


//   invalid characters
//     phoneCleaner('123abc456def7890') === '0000000000';
//     phoneCleaner('123\t456\n7890') === '0000000000';

//   invalid input
//     phoneCleaner('') === '0000000000';
//     phoneCleaner([]) === '0000000000';
//     phoneCleaner({}) === '0000000000';
//     phoneCleaner(1234567890) === '1234567890';
//     phoneCleaner(11234567890) === '1234567890';
//     phoneCleaner(123456789) === '0000000000';
//     phoneCleaner(81234567890) === '0000000000';
// Edge Cases
//   * Non string input?
//     * Number? Attempt to treat it as valid?
//   Data Structure: string and regexp
// Algorithm
//   * if input is not string or number, return '0000000000'
//   * if input is number, coerce to string
//   * valid characters: /\d -\.\(\)/
//   * return '0000000000' if there are any invalid characters
//   * remove non-digit characters (replace with empty string)
//   * return '0000000000' if length is not 10 or 11
//   * if length is 11
//     * return '0000000000' if first digit is not 1
//     * if first digit is 1, trim it'
//   * return the remaining ten digit string
// Code

let phoneCleaner = function phoneCleaner(phoneNumber) {
  const badNumber = '0000000000';
  if (typeof phoneNumber !== 'string' && typeof phoneNumber !== 'number') {
    return badNumber;
  }

  if (typeof phoneNumber === 'number') phoneNumber = String(phoneNumber);

  const invalidChars = /[^\d \-.()]/;
  if (invalidChars.test(phoneNumber)) return badNumber;

  phoneNumber = phoneNumber.replace(/[^\d]/g, '');

  if (phoneNumber.length !== 10 && phoneNumber.length !== 11) return badNumber;

  if (phoneNumber.length === 11) {
    if (phoneNumber[0] !== '1') return badNumber;
    phoneNumber = phoneNumber.slice(1);
  }

  return phoneNumber;
};

console.log(phoneCleaner('1234567890') === '1234567890');
console.log(phoneCleaner('123 456 7890') === '1234567890');
console.log(phoneCleaner('123-456-7890') === '1234567890');
console.log(phoneCleaner('123.456.7890') === '1234567890');
console.log(phoneCleaner('(123)4567890') === '1234567890');
console.log(phoneCleaner('11234567890') === '1234567890');

console.log(phoneCleaner('123456789') === '0000000000');
console.log(phoneCleaner('91234567890') === '0000000000');
console.log(phoneCleaner('(123)456.789') === '0000000000');
console.log(phoneCleaner('9123_456 7890') === '0000000000');

console.log(phoneCleaner('123abc456def7890') === '0000000000');
console.log(phoneCleaner('123\t456\n7890') === '0000000000');

console.log(phoneCleaner('') === '0000000000');
console.log(phoneCleaner([]) === '0000000000');
console.log(phoneCleaner({}) === '0000000000');
console.log(phoneCleaner(1234567890) === '1234567890');
console.log(phoneCleaner(11234567890) === '1234567890');
console.log(phoneCleaner(123456789) === '0000000000');
console.log(phoneCleaner(81234567890) === '0000000000');
```
