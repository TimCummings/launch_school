
# Problem 4 - 11/24/2020

You are given a list of numbers in a "short-hand" range where only the significant part of the next number is written because we know the numbers are always increasing (ex. "1, 3, 7, 2, 4, 1" represents `[1, 3, 7, 12, 14, 21]`). Some people use different separators for their ranges (ex. "1-3, 1-2", "1:3, 1:2", "1..3, 1..2" represent the same numbers `[1, 2, 3, 11, 12]`). Range limits are always inclusive.

Your job is to return a list of complete numbers.

The possible separators are: `["-", ":", ".."`]

* "1, 3, 7, 2, 4, 1" --> 1, 3, 7, 12, 14, 21
* "1-3, 1-2" --> 1, 2, 3, 11, 12
* "1:5:2" --> 1, 2, 3, 4, 5, 6, ... 12
* "104-2" --> 104, 105, ... 112
* "104-02" --> 104, 105, ... 202
* "545, 64:11" --> 545, 564, 565, .. 611

### Solution

```javascript
// Input: a string representing a list of "short hand" numbers
// Output: a list of complete numbers (array of numbers?)
// Rules/Implicit Knowledge
//   * after the first number, only the significant (changed) part of the next number is given
//   * parts of the provided list my be in the form of a range with "-", ":", or ".." as a separator
//   * range limits are INCLUSIVE
//   * ranges may be nested, e.g. "1:5:2" === [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
// Examples
//   console.log(expand("1, 3, 7, 2, 4, 1") === [1, 3, 7, 12, 14, 21]);
//   console.log(expand("1-2") === [1, 2]);
//   console.log(expand("1-1") === [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
//   console.log(expand("1-1-2") === [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);
//   console.log(expand("1-3, 1-2") === [1, 2, 3, 11, 12]);
//   console.log(expand("1:5:2") === [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);
//   console.log(expand("104-2") === [104, 105, 106, 107, 108, 109, 110, 111, 112]);
//   console.log(expand("104-02") === [104, 105, ... 202]);
//   console.log(expand("545, 64:11") === [545, 564, 565, ... 611]);
//   console.log(expand(1, 2, 3, 4, 5) === []);
//   console.log(expand('') === []);
//   console.log(expand('1, 2, a, 3, z') === []);
//   console.log(expand("1--3, 1--2") === [1, 2, 3, 11, 12]);
//   console.log(expand("1::3, 1--2") === [1, 2, 3, 11, 12]);
// Edge Cases
//   input not a string - return []
//   empty string input - return []
//   invalid characters (/[^\d ,\-:..]/) - return []
//   multiple separators - allow
//   different separators - allow
// Data Structure: strings look easier to work with?
//   * two primary operations:
//     * expand number
//       * first number is already expanded
//       * if not first number
//         * increment previous number until string version of current number ends with specified digits
//     * expand range (begin, end)
//       * don't expand begin
//       * increment begin until current number ends with end, pushing each into new array
// Algorithm
//   if input is not a string, return empty array
//   if input is empty string, return empty array
//   if input has invalid characters, return empty array

//   initialize expandedNumbers array
//   initialize prevNumber to 0
//   split input string to array of strings (numbers and/or ranges) and iterate
//     if current string is a number (not a range)
//       increment prevNumber until its string version ends with the current string
//       push prevNumber to expandedNumbers array
//     if current string is a range
//       initialize isFirst to true
//       split by valid separators (-, :, ..) and iterate
//         while prevNumber does not endWith current string
//         increment prevNumber
//         if not isFirst, push prevNumber to expandedNumbers array
//       push prevNumber to expandedNumbers array
//   return array of expanded numbers
// Code

let expand = function expand(list) {
  if (typeof list !== 'string' || list === '') return [];
  const invalidChars = /[^\d ,\-:.]/;
  if (invalidChars.test(list)) return [];

  let expandedNumbers = [];
  let prevNumber = 0;
  const rangeSeparators = /\-+|:+|\.{2,}/;

  list.split(', ').forEach(currentItem => {
    if (rangeSeparators.test(currentItem)) {
      let isFirst = true;
      currentItem.split(rangeSeparators).forEach((currentNum, index, array) => {
        do {
          prevNumber += 1;
          if (!isFirst) expandedNumbers.push(prevNumber);
        } while (!String(prevNumber).endsWith(currentNum));

        if (isFirst) {
          isFirst = false;
          expandedNumbers.push(prevNumber);
        }
      });
    } else {
      while (!String(prevNumber).endsWith(currentItem)) {
        prevNumber += 1;
      }

      expandedNumbers.push(prevNumber);
    }
  });

  return expandedNumbers;
};

let compareArrays = function compareArrays(first, second) {
  if (first.length !== second.length) return false;

  for (let index = 0; index < first.length; index += 1) {
    if (first[index] !== second[index]) return false;
  }

  return true;
};

console.log(compareArrays(expand("1, 3, 7, 2, 4, 1"), [1, 3, 7, 12, 14, 21]));
console.log(compareArrays(expand("5-8"), [5, 6, 7, 8]));
console.log(compareArrays(expand("1-2"), [1, 2]));
console.log(compareArrays(expand("1-1"), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]));
console.log(compareArrays(expand("1-1-2"), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
console.log(compareArrays(expand("1-3, 1-2"), [1, 2, 3, 11, 12]));
console.log(compareArrays(expand("1:5:2"), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
console.log(compareArrays(expand("104-2"), [104, 105, 106, 107, 108, 109, 110, 111, 112]));
console.log(compareArrays(expand("104-02"), [104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202]));
console.log(compareArrays(expand("545, 64:11"), [545, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611]));
console.log(compareArrays(expand(1, 2, 3, 4, 5), []));
console.log(compareArrays(expand(''), []));
console.log(compareArrays(expand('1, 2, a, 3, z'), []));
console.log(compareArrays(expand("1--3, 1--2"), [1, 2, 3, 11, 12]));
console.log(compareArrays(expand("1::3, 1--2"), [1, 2, 3, 11, 12]));
```

---

### Refactored Solution

```javascript
let isValid = function isValid(input) {
  if (typeof input !== 'string' || input === '') return false;

  const invalidChars = /[^\d ,\-:.]/;
  if (invalidChars.test(input)) return false;

  return true;
};

const RANGE_SEPARATORS = /\-+|:+|\.{2,}/;

let isRange = function isRange(shortHandNumber) {
  return RANGE_SEPARATORS.test(shortHandNumber);
};

let last = function last(array) {
  return array[array.length - 1];
}

let expandRange = function expandRange(expandedNumbers, range) {
  let prevNumber = last(expandedNumbers) || 0;
  let isFirst = true;

  range.split(RANGE_SEPARATORS).forEach(current => {
    do {
      prevNumber += 1;
      if (!isFirst) expandedNumbers.push(prevNumber);
    } while (!String(prevNumber).endsWith(current));

    if (isFirst) {
      isFirst = false;
      expandedNumbers.push(prevNumber);
    }
  });
};

let expandNumber = function expandNumber(expandedNumbers, number) {
  let prevNumber = last(expandedNumbers) || 0;

  while (!String(prevNumber).endsWith(number)) {
    prevNumber += 1;
  }

  expandedNumbers.push(prevNumber);
};

let expand = function expand(list) {
  if (!isValid(list)) return [];

  let expandedNumbers = [];
  list.split(', ').forEach(currentItem => {
    if (isRange(currentItem)) {
      expandRange(expandedNumbers, currentItem);
    } else {
      expandNumber(expandedNumbers, currentItem);
    }
  });

  return expandedNumbers;
};

let compareArrays = function compareArrays(first, second) {
  if (first.length !== second.length) return false;

  for (let index = 0; index < first.length; index += 1) {
    if (first[index] !== second[index]) return false;
  }

  return true;
};
```
