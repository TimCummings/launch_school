
# JS210 Small Problems - Easy 4 - 11/25/2020

## 1. Cute Angles

Write a function that takes a floating point number representing an angle between 0 and 360 degrees, and returns a string representing that angle in degrees, minutes, and seconds. You should use a degree symbol (`˚`) to represent degrees, a single quote (`'`) to represent minutes, and a double quote (`"`) to represent seconds. There are 60 minutes in a degree, and 60 seconds in a minute.

Examples:

```javascript
dms(30);           // 30°00'00"
dms(76.73);        // 76°43'48"
dms(254.6);        // 254°35'59"
dms(93.034773);    // 93°02'05"
dms(0);            // 0°00'00"
dms(360);          // 360°00'00" or 0°00'00"
```

Note: your results may differ slightly depending on how you round values, but should generally be within a second or two of the results shown.

### Solution

```javascript
const MINUTES_PER_DEGREE = 60;
const SECONDS_PER_MINUTE = 60;

let dms = function dms(degreesNumber) {
  let [degrees, remainder] = String(degreesNumber).split('.');
  degrees += '˚';
  remainder = Number('0.' + remainder) || 0;
  remainder *= MINUTES_PER_DEGREE;

  let [minutes, seconds] = String(remainder).split('.');
  if (minutes.length === 1) minutes = '0' + minutes;
  minutes += '\'';

  seconds = Number('0.' + seconds) || 0;
  seconds = String(Math.round(seconds * SECONDS_PER_MINUTE));
  if (seconds.length === 1) seconds = '0' + seconds;
  seconds += '"';

  return degrees + minutes + seconds;
};
```

#### Further Exploration

Further Exploration

The current solution implementation only works with positive numbers in the range of `0` to `360` (inclusive). Can you refactor it so that it works with any positive or negative number?

Our solution returns the following results for inputs outside the range 0-360:

```javascript
dms(-1);   // -1°00'00"
dms(400);  // 400°00'00"
dms(-40);  // -40°00'00"
dms(-420); // 420°00'00"
```

Since degrees are normally restricted to the range 0-360, can you modify the code so it returns a value in the appropriate range when the input is less than 0 or greater than 360?

```javascript
dms(-1);   // 359°00'00"
dms(400);  // 40°00'00"
dms(-40);  // 320°00'00"
dms(-420); // 300°00'00"
```

##### FE Solution

My original solution already works with the first part of Further Exploration. For the second part:

### Solution

```javascript
const MINUTES_PER_DEGREE = 60;
const SECONDS_PER_MINUTE = 60;

let dms = function dms(degreesNumber) {
  let [degrees, remainder] = String(degreesNumber).split('.');

  if (Number(degrees) > 360 || Number(degrees) < 0) {
    degrees = Number(degrees) % 360;
    if (degrees < 0) degrees += 360;
    degrees = String(degrees);
  }

  degrees += '˚';
  remainder = Number('0.' + remainder) || 0;
  remainder *= MINUTES_PER_DEGREE;

  let [minutes, seconds] = String(remainder).split('.');
  if (minutes.length === 1) minutes = '0' + minutes;
  minutes += '\'';

  seconds = Number('0.' + seconds) || 0;
  seconds = String(Math.round(seconds * SECONDS_PER_MINUTE));
  if (seconds.length === 1) seconds = '0' + seconds;
  seconds += '"';

  return degrees + minutes + seconds;
};

console.log(dms(30));          // 30°00'00"
console.log(dms(76.73));       // 76°43'48"
console.log(dms(254.6));       // 254°35'59"
console.log(dms(93.034773));   // 93°02'05"
console.log(dms(0));           // 0°00'00"
console.log(dms(360));         // 360°00'00" or 0°00'00"
console.log(dms(-1));          // 359°00'00"
console.log(dms(400));         // 40°00'00"
console.log(dms(-40));         // 320°00'00"
console.log(dms(-420));        // 300°00'00"
```

---

## 2. Combining Arrays

Write a function that takes two arrays as arguments, and returns an array containing the union of the values from the two. There should be no duplication of values in the returned array, even if there are duplicates in the original arrays. You may assume that both arguments will always be arrays.

Example:

```javascript
union([1, 3, 5], [3, 6, 9]);    // [1, 3, 5, 6, 9]
```

### Solution

```javascript
let union = function union(array1, array2) {
  let result = [];

  [array1, array2].forEach(array => {
    array.forEach(value => {
      if (!result.includes(value)) result.push(value);
    });
  });

  return result;
};
```

---

## 3. Halvsies

Write a function that takes an array as an argument, and returns an array that contains two elements, each of which is an array. Put the first half of the original array elements in the first element of the return value, and put the second half in the second element. If the original array contains an odd number of elements, place the middle element in the first half array.

Examples:

```javascript
halvsies([1, 2, 3, 4]);       // [[1, 2], [3, 4]]
halvsies([1, 5, 2, 4, 3]);    // [[1, 5, 2], [4, 3]]
halvsies([5]);                // [[5], []]
halvsies([]);                 // [[], []]
```

### Solution

```javascript
let halvsies = function halvsies(array) {
  let middleIndex = Math.ceil(array.length / 2);
  let firstHalf = array.slice();
  let lastHalf = firstHalf.splice(middleIndex);

  return [firstHalf, lastHalf];
};

console.log(halvsies([1, 2, 3, 4]));       // [[1, 2], [3, 4]]
console.log(halvsies([1, 5, 2, 4, 3]));    // [[1, 5, 2], [4, 3]]
console.log(halvsies([5]));                // [[5], []]
console.log(halvsies([]));                 // [[], []]
```

---

## 4. Find the Duplicate

Given an unordered array and the information that exactly one value in the array occurs twice (every other value occurs exactly once), determine which value occurs twice. Write a function that will find and return the duplicate value that is in the array.

Examples:

```javascript
findDup([1, 5, 3, 1]);                                // 1
findDup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
         38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
         14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
         78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
         89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
         41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
         55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
         85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
         40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7, 34, 57, 74, 45, 11, 88, 67,  5, 58]);    // 73
```

### Solution

```javascript
let findDup = function findDup(array) {
  for (let outerIdx = 0; outerIdx < array.length; outerIdx += 1) {
    for (let innerIdx = outerIdx + 1; innerIdx < array.length; innerIdx += 1) {
      if (array[outerIdx] === array[innerIdx]) return array[innerIdx];
    }
  }

  return -1;
};
```

---

## 5. Combine Two Lists

Write a function that combines two arrays passed as arguments, and returns a new array that contains all elements from both array arguments, with each element taken in alternation.

You may assume that both input arrays are non-empty, and that they have the same number of elements.

Example:

```javascript
interleave([1, 2, 3], ['a', 'b', 'c']);    // [1, "a", 2, "b", 3, "c"]
```

### Solution

```javascript
let interleave = function interleave(array1, array2) {
  let result = [];

  for (let index = 0; index < array1.length; index += 1) {
    result.push(array1[index], array2[index]);
  }

  return result;
};

console.log(interleave([1, 2, 3], ['a', 'b', 'c']));    // [1, "a", 2, "b", 3, "c"]
```

---

## 6. Multiplicative Average

Write a function that takes an array of integers as input, multiplies all of the integers together, divides the result by the number of entries in the array, and returns the result as a string with the value rounded to three decimal places.

Examples:

```javascript
showMultiplicativeAverage([3, 5]);                   // "7.500"
showMultiplicativeAverage([2, 5, 7, 11, 13, 17]);    // "28361.667"
```

### Solution

```javascript
let showMultiplicativeAverage = function showMultiplicativeAverage(numbers) {
  let product = numbers.reduce((product, number) => product * number);
  return (product / numbers.length).toFixed(3);
};

console.log(showMultiplicativeAverage([3, 5]));                   // "7.500"
console.log(showMultiplicativeAverage([2, 5, 7, 11, 13, 17]));    // "28361.667"
```

---

## 7. Multiply Lists

Write a function that takes two array arguments, each containing a list of numbers, and returns a new array that contains the product of each pair of numbers from the arguments that have the same index. You may assume that the arguments contain the same number of elements.

Example:

```javascript
multiplyList([3, 5, 7], [9, 10, 11]);    // [27, 50, 77]
```

### Solution

```javascript
let multiplyList = function multiplyList(array1, array2) {
  let result = [];

  for (let index = 0; index < array1.length; index += 1) {
    result.push(array1[index] * array2[index]);
  }

  return result;
};

console.log(multiplyList([3, 5, 7], [9, 10, 11]));    // [27, 50, 77]
```

---

## 8. Digits List

Write a function that takes one argument, a positive integer, and returns a list of the digits in the number.

Examples:

```javascript
digitList(12345);       // [1, 2, 3, 4, 5]
digitList(7);           // [7]
digitList(375290);      // [3, 7, 5, 2, 9, 0]
digitList(444);         // [4, 4, 4]
```

### Solution

```javascript
let digitList = function digitList(number) {
  return String(number).split('').map(Number);
};

console.log(digitList(12345));       // [1, 2, 3, 4, 5]
console.log(digitList(7));           // [7]
console.log(digitList(375290));      // [3, 7, 5, 2, 9, 0]
console.log(digitList(444));         // [4, 4, 4]
```

---

## 9. How Many

Write a function that counts the number of occurrences of each element in a given array. Once counted, log each element alongside the number of occurrences.

Example:

```javascript
const vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck',
                'motorcycle', 'motorcycle', 'car', 'truck'];

countOccurrences(vehicles);

// console output
// car => 4
// truck => 3
// SUV => 1
// motorcycle => 2
```

### Solution

```javascript
const vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck',
                'motorcycle', 'motorcycle', 'car', 'truck'];

let countOccurrences = function countOccurrences(array) {
  let counts = {};

  array.forEach(value => {
    if(!counts[value]) counts[value] = 0;
    counts[value] += 1;
  });

  Object.keys(counts).forEach(key => {
    console.log(`${key} => ${counts[key]}`);
  });
};

countOccurrences(vehicles);
```

---

## 10. Array Average

Write a function that takes one argument, an array containing integers, and returns the average of all the integers in the array, rounded down to the integer component of the average. The array will never be empty, and the numbers will always be positive integers.

Examples:

```javascript
average([1, 5, 87, 45, 8, 8]);       // 25
average([9, 47, 23, 95, 16, 52]);    // 40
```

### Solution

```javascript
let average = function average(numbers) {
  let sum = numbers.reduce((sum, number) => sum + number);
  return Math.floor(sum / numbers.length);
};

console.log(average([1, 5, 87, 45, 8, 8]));       // 25
console.log(average([9, 47, 23, 95, 16, 52]));    // 40
```
