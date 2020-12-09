
# Example Problem: Comparing Version Numbers - 11/22/2020

To look at the steps of this problem solving approach in depth, we will work through a problem and see how to apply each step in the process. The problem we will look at compares software version numbers.

While version numbers often appear to be decimal numbers, they are, in fact, a convenient notation for a more complicated number system. The following are all legal version numbers:

```
1
1.0
1.2
3.2.3
3.0.0
4.2.3.0
```

Write a function that takes any two version numbers in this format and compares them, with the result of this comparison showing whether the first is less than, equal to, or greater than the second version:

* If `version1 > version2`, we should return `1`.
* If `version1 < version2`, we should return `-1`.
* If `version1 === version2`, we should return `0`.
* If either version number contains characters other than digits and the `.` character, we should return `null`.

Here is an example of version number ordering:

```javascript
0.1 < 1 = 1.0 < 1.1 < 1.2 = 1.2.0.0 < 1.18.2 < 13.37

function compareVersions(version1, version2) {
  // ...
}
```

### Solution

```javascript
// Input: two version numbers
//   must be strings to allow multiple decimals
// Output: a number representing the comparison of the two version numbers
//   1 if v1 > v2
//   0 if v1 == v2
//   -1 if v1 < v2
//   null if either number is invalid (invalid: contains characters other than numbers or .)
// Rules/Implicit Knowledge
//   valid version number
//     contains only digits and .s
//     group of 1 or more digits, optionally followed by a single . then another digit group
// Examples
//   compareVersions(0.1, 1) => -1
//   compareVersions(1, 0.1) => 1
//   compareVersions(1, 1.0) => 0
//   compareVersions(13.37, 1.18.2) => 1
//   compareVersions(1.18.2, 13.37) => -1
//   compareVersions() => null
//   compareVersions('a', 1) => null
// Edge Cases
//   empty input: return null
//   invalid input: return null
//   same number: return 0
// Data Structure
//   arrays (split version number strings on .s)
// Algorithm
//   validate inputs with regexp; return null if invalid
//     one or more digit groups separated by a single period (no period if only one group)
//     digit group: one or more numbers
//     ^\d+(\.\d+)*$
//   split version strings on .s
//   find the longest length array
//   if one version array is shorter than the other, push zero strings ('0') until lengths match
//   iterate through array elements by index (use for loop to enable early return)
//     coerce number groups at current index in both arrays to numbers and compare them
//     if 1 is greater, return 1
//     if 1 is less, return -1
//     if equal, allow loop to continue
//   once iteration has ended, if it hasn't already returned, versions are equal, return 0
// Code

let max = function max(values) {
  return values.reduce((maxValue, currentValue) => {
    if (currentValue > maxValue) return currentValue;
    return maxValue;
  });
};

let balanceLengths = function balanceLengths(array1, array2) {
  let maxLength = max([array1.length, array2.length]);

  [array1, array2].forEach( array => {
    let counter = array.length;
    for (counter; counter < maxLength; counter += 1) {
      array.push('0');
    }
  });
};

let compareVersions = function compareVersions(version1, version2) {
  // return null unless inputs are valid
  let regexp = /^\d+(\.\d+)*$/;
  if (!regexp.test(version1) || !regexp.test(version2)) return null;

  let vArray1 = version1.split('.');
  let vArray2 = version2.split('.');
  balanceLengths(vArray1, vArray2);

  for (let index = 0; index < vArray1.length; index += 1) {
    if (Number(vArray1[index]) > Number(vArray2[index])) return 1;
    if (Number(vArray1[index]) < Number(vArray2[index])) return -1;
  }

  return 0;
};

console.log(compareVersions('0.1', '1') === -1);
console.log(compareVersions('1', '0.1') === 1);
console.log(compareVersions('1', '1.0') === 0);
console.log(compareVersions('13.37', '1.18.2') === 1);
console.log(compareVersions('1.18.2', '13.37') === -1);
console.log(compareVersions() === null);
console.log(compareVersions('a', '1') === null);
```

#### Adjustments based on provided solution

* Regexp can be given a clearer name.
* `maxLength` can be easily determined with `Math.max()` function.
* version arrays don't have to be explicitly padded with zeroes; assign number (or 0) to local variables then compare.

```javascript
let compareVersions = function compareVersions(version1, version2) {
  let validChars = /^\d+(\.\d+)*$/;
  if (!validChars.test(version1) || !validChars.test(version2)) return null;

  let vArray1 = version1.split('.');
  let vArray2 = version2.split('.');
  let maxLength = Math.max(vArray1.length, vArray2.length);

  for (let index = 0; index < maxLength; index += 1) {
    let num1 = vArray1[index] || 0;
    let num2 = vArray2[index] || 0;

    if (num1 > num2) return 1;
    if (num1 < num2) return -1;
  }

  return 0;
};
```
