
# JS210 Small Problems - Medium 2 - 11/29/2020

## 1. Lettercase Percentage Ratio

Write a function that takes a string, and returns an object containing the following three properties:

 * the percentage of characters in the string that are lowercase letters
 * the percentage of characters that are uppercase letters
 * the percentage of characters that are neither

You may assume that the string will always contain at least one character.

Examples:

```javascript
letterPercentages('abCdef 123');
// { lowercase: "50.00", uppercase: "10.00", neither: "40.00" }

letterPercentages('AbCd +Ef');
// { lowercase: "37.50", uppercase: "37.50", neither: "25.00" }

letterPercentages('123');
// { lowercase: "0.00", uppercase: "0.00", neither: "100.00" }
```

### Solution

```javascript
let letterPercentages = function letterPercentages(string) {
  let lowercaseLetters = string.match(/[a-z]/g) || [];
  let uppercaseLetters = string.match(/[A-Z]/g) || [];
  let neitherLetters = string.match(/[^a-zA-Z]/g) || [];

  let lowercase = (lowercaseLetters.length / string.length * 100).toFixed(2);
  let uppercase = (uppercaseLetters.length / string.length * 100).toFixed(2);
  let neither = (neitherLetters.length / string.length * 100).toFixed(2);

  return { lowercase, uppercase, neither };
};
```

---

## 2. Triangle Sides

A triangle is classified as follows:

* **Equilateral**: All three sides are of equal length.
* **Isosceles**: Two sides are of equal length, while the third is different.
* **Scalene**: All three sides are of different lengths.

To be a valid triangle, the sum of the lengths of the two shortest sides must be greater than the length of the longest side, and every side must have a length greater than `0`. If either of these conditions is not satisfied, the triangle is invalid.

Write a function that takes the lengths of the three sides of a triangle as arguments, and returns one of the following four strings representing the triangle's classification: `'equilateral'`, `'isosceles'`, `'scalene'`, or `'invalid'`.

Examples:

```javascript
triangle(3, 3, 3);        // "equilateral"
triangle(3, 3, 1.5);      // "isosceles"
triangle(3, 4, 5);        // "scalene"
triangle(0, 3, 3);        // "invalid"
triangle(3, 1, 1);        // "invalid"
```

### Solution

```javascript
let isValidTriangle = function(sides) {
  if (sides.length !== 3) return false;
  if (sides.some(side => side <= 0)) return false;
  if (sides[0] + sides[1] <= sides[2]) return false;

  return true;
};

let triangle = function triangle(...sides) {
  sides.sort((side1, side2) => side1 - side2);
  if (!isValidTriangle(sides)) return 'invalid';

  if (sides[0] === sides[1] && sides[1] === sides[2]) return 'equilateral';
  if (sides[1] === sides[0] || sides[1] === sides[2]) return 'isosceles';
  return 'scalene';
};
```

---

## 3. Tri-Angles

A triangle is classified as follows:

* **Right**: One angle is a right angle (exactly `90` degrees).
* **Acute**: All three angles are less than `90` degrees.
* **Obtuse**: One angle is greater than `90` degrees.

To be a valid triangle, the sum of the angles must be exactly `180` degrees, and every angle must be greater than `0`. If either of these conditions is not satisfied, the triangle is invalid.

Write a function that takes the three angles of a triangle as arguments, and returns one of the following four strings representing the triangle's classification: `'right'`, `'acute'`, `'obtuse'`, or `'invalid'`.

You may assume that all angles have integer values, so you do not have to worry about floating point errors. You may also assume that the arguments are in degrees.

Examples:

```javascript
triangle(60, 70, 50);       // "acute"
triangle(30, 90, 60);       // "right"
triangle(120, 50, 10);      // "obtuse"
triangle(0, 90, 90);        // "invalid"
triangle(50, 50, 50);       // "invalid"
```

### Solution

```javascript
let isValidTriangle = function isValidTriangle(angles) {
  if (angles[0] <= 0) return false;
  return angles.reduce((sum, angle) => sum + angle) === 180;
};

let triangle = function triangle(...angles) {
  angles.sort((angle1, angle2) => angle1 - angle2);
  if (!isValidTriangle(angles)) return 'invalid';

  if (angles.filter(angle => angle === 90).length === 1) return 'right';
  if (angles.some(angle => angle > 90)) return 'obtuse';
  return 'acute';
};
```

---

## 4. Unlucky Days

Write a function that takes a year as an argument, and returns the number of 'Friday the 13ths' in that year. You may assume that the year is greater than `1752` (when the modern Gregorian Calendar was adopted by the United Kingdom). You may also assume that the same calendar will remain in use for the foreseeable future.

Examples:

```javascript
fridayThe13ths(1986);      // 1
fridayThe13ths(2015);      // 3
fridayThe13ths(2017);      // 2
```

### Solution

```javascript
let fridayThe13ths = function fridayThe13ths(year) {
  let thirteenths = [];
  for (let monthIndex = 0; monthIndex < 12; monthIndex += 1) {
    thirteenths.push(new Date(year, monthIndex, 13));
  }

  return thirteenths.filter(date => date.getDay() === 5).length;
};
```

#### Further Exploration

Given the solution provided, do you think using the Array.prototype.reduce method was a good choice? Why or why not?

##### FE Solution

Using `reduce()` here is ok, but I prefer using `filter()` and then returning its length. The `reduce()` solution shown is a really long line of code as it is, and it's somewhat dense to understand. It could be split to multiple lines, but using `filter()` keeps everything on a single line, keeps the code easy to read and understand, and better matches the logic of our algorithm.

---

## 5. Next Featured Number Higher than a Given Value

A *featured number* (something unique to this exercise) is an odd number that is a multiple of `7`, with all of its digits occuring exactly once each. For example, `49` is a featured number, but `98` is not (it is not odd), `97` is not (it is not a multiple of `7`), and `133` is not (the digit `3` appears twice).

Write a function that takes an integer as an argument, and returns the next featured number greater than the integer. Issue an error message if there is no next featured number.

NOTE: The largest possible featured number is `9876543201`.

Examples:

```javascript
featured(12);           // 21
featured(20);           // 21
featured(21);           // 35
featured(997);          // 1029
featured(1029);         // 1043
featured(999999);       // 1023547
featured(999999987);    // 1023456987
```

### Solution

```javascript
let repeatedDigits = function repeatedDigits(number) {
  let seen = {};
  for (let digit of String(number).split('')) {
    if (seen[digit]) return true;
    seen[digit] = true;
  }

  return false;
};

let isOddMultipleOf7 = function isOddMultipleOf7(number) {
  if (number % 2 === 0) return false;
  if (number % 7 !== 0) return false;
  return true;
};

let isFeatured = function isFeatured(number) {
  if (!isOddMultipleOf7(number)) return false;
  return !repeatedDigits(number);
};

let featured = function featured(boundary) {
  const MAX = 9876543201;

  let nextOdd = (boundary % 2 === 0) ? boundary + 1 : boundary + 2;
  for (nextOdd; nextOdd <= MAX; nextOdd += 2) {
    console.log('nextOdd:', nextOdd);
    if (isOddMultipleOf7(nextOdd)) break;
  }
  let candidate = nextOdd;

  for (candidate; candidate <= MAX; candidate += 14) {
    if (isFeatured(candidate)) return candidate;
  }

  return 'ERROR - no next featured number!';
};
```

---

## 6. Sum Square - Square Sum

Write a function that computes the difference between the square of the sum of the first `n` positive integers and the sum of the squares of the first `n` positive integers.

Examples:

```javascript
sumSquareDifference(3);      // 22 --> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
sumSquareDifference(10);     // 2640
sumSquareDifference(1);      // 0
sumSquareDifference(100);    // 25164150
```

### Solution

```javascript
let sumOfSquares = function sumOfSquares(numbers) {
  return numbers.map(number => number * number)
                .reduce((sum, number) => sum + number);
};

let squareOfSums = function squareOfSums(numbers) {
  let sum = numbers.reduce((sum, number) => sum + number);
  return sum * sum;
};

let sumSquareDifference = function sumSquareDifference(number) {
  let numbers = [];
  for (let counter = 1; counter <= number; counter += 1) {
    numbers.push(counter);
  }

  return squareOfSums(numbers) - sumOfSquares(numbers);
};
```

---

## 7. Bubble Sort

'Bubble Sort' is one of the simplest sorting algorithms available. Although it is not an efficient algorithm, it is an excellent exercise for student developers. In this exercise, you will write a function that sorts an array using the bubble sort algorithm.

A bubble sort works by making multiple passes (iterations) through an array. On each pass, the two values of each pair of consecutive elements are compared. If the first value is greater than the second, the two elements are swapped. This process is repeated until a complete pass is made without performing any swaps — at which point the array is completely sorted.

|   |   |   |   |   |                            |
|---|---|---|---|---|----------------------------|
| 6 | 2 | 7 | 1 | 4 | Start: compare 6 > 2? Yes  |
| 2 | 6 | 7 | 1 | 4 | Swap                       |
| 2 | 6 | 7 | 1 | 4 | 6 > 7? No (no swap)        |
| 2 | 6 | 7 | 1 | 4 | 7 > 1? Yes                 |
| 2 | 6 | 1 | 7 | 4 | Swap                       |
| 2 | 6 | 1 | 7 | 4 | 7 > 4? Yes                 |
| 2 | 6 | 1 | 4 | 7 | Swap                       |
|   |   |   |   |   |                            |
| 2 | 6 | 1 | 4 | 7 | 2 > 6? No                  |
| 2 | 6 | 1 | 4 | 7 | 6 > 1? Yes                 |
| 2 | 1 | 6 | 4 | 7 | Swap                       |
| 2 | 1 | 6 | 4 | 7 | 6 > 4? Yes                 |
| 2 | 1 | 4 | 6 | 7 | Swap                       |
| 2 | 1 | 4 | 6 | 7 | 6 > 7? No                  |
|   |   |   |   |   |                            |
| 2 | 1 | 4 | 6 | 7 | 2 > 1? Yes                 |
| 1 | 2 | 4 | 6 | 7 | Swap                       |
| 1 | 2 | 4 | 6 | 7 | 2 > 4? No                  |
| 1 | 2 | 4 | 6 | 7 | 4 > 6? No                  |
| 1 | 2 | 4 | 6 | 7 | 6 > 7? No                  |
|   |   |   |   |   |                            |
| 1 | 2 | 4 | 6 | 7 | 1 > 2? No                  |
| 1 | 2 | 4 | 6 | 7 | 2 > 4? No                  |
| 1 | 2 | 4 | 6 | 7 | 4 > 6? No                  |
| 1 | 2 | 4 | 6 | 7 | 6 > 7? No                  |
| 1 | 2 | 4 | 6 | 7 | No swaps; all done; sorted |

We can stop iterating the first time we make a pass through the array without making any swaps because this means that the entire array is sorted.

For further information — including pseudo-code that demonstrates the algorithm, as well as a minor optimization technique — see the [Bubble Sort Wikipedia page](https://en.wikipedia.org/wiki/Bubble_sort).

Write a function that takes an array as an argument and sorts that array using the bubble sort algorithm described above. The sorting should be done "in-place" — that is, the function should mutate the array. You may assume that the array contains at least two elements.

Examples:

```javascript
const array1 = [5, 3];
bubbleSort(array1);
console.log(array1);    // [3, 5]

const array2 = [6, 2, 7, 1, 4];
bubbleSort(array2);
console.log(array2);    // [1, 2, 4, 6, 7]

const array3 = ['Sue', 'Pete', 'Alice', 'Tyler', 'Rachel', 'Kim', 'Bonnie'];
bubbleSort(array3);
console.log(array3);    // ["Alice", "Bonnie", "Kim", "Pete", "Rachel", "Sue", "Tyler"]
```

### Solution

```javascript
let bubbleSort = function bubbleSort(array) {
  let swapped;

  do {
    swapped = false;

    for (let index = 1; index < array.length; index += 1) {
      if (array[index] < array[index - 1]) {
        let [temp] = array.splice(index - 1, 1);
        array.splice(index, 0, temp);
        swapped = true;
      }
    }
  } while (swapped);

  return array;
};
```

#### Adjustments based on  provided solution

Elements don't need to be spliced; just reassign them.

Breaking out of `while` can be slightly simpler than `do...while`.


```javascript
let bubbleSort = function bubbleSort(array) {
  while (true) {
    let swapped = false;

    for (let index = 1; index < array.length; index += 1) {
      if (array[index] < array[index - 1]) {
        [array[index - 1], array[index]] = [array[index], array[index - 1]];
        swapped = true;
      }
    }

    if (!swapped) break;
  }

  return array;
};
```
