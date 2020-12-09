
# Filtering / Selection - 11/14/2020

## Exercises

Write a function that's similar to [Array.prototype.filter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter). It takes an array and a function as arguments, and returns an array whose values are only those that the function passed returns as true.

```javascript
function myFilter(array, func) {
  // ...
}

let isPythagoreanTriple = function (triple) {
  return Math.pow(triple.a, 2) + Math.pow(triple.b, 2) === Math.pow(triple.c, 2);
};

myFilter([{ a: 3, b: 4,  c: 5 },
          { a: 5, b: 12, c: 13 },
          { a: 1, b: 2,  c: 3 },], isPythagoreanTriple);

// returns [ { a: 3, b: 4, c: 5 }, { a: 5, b: 12, c: 13 } ]
```

### Solution

```javascript
function myFilter(array, func) {
  let result = [];

  for (let index = 0; index < array.length; index += 1) {
    if (func(array[index])) result.push(array[index]);
  }

  return result;
}

let isPythagoreanTriple = function (triple) {
  return Math.pow(triple.a, 2) + Math.pow(triple.b, 2) === Math.pow(triple.c, 2);
}

myFilter([{ a: 3, b: 4,  c: 5 },
          { a: 5, b: 12, c: 13 },
          { a: 1, b: 2,  c: 3 },], isPythagoreanTriple);
```

#### Adjustments based on provided solution

We already implemented our own `forEach`, so there's no reason not to further abstract that part of the code; make use of `Array.prototype.forEach`!

```javascript
function myFilter(array, func) {
  let result = [];

  array.forEach(element => {
    if (func(element)) result.push(element);
  });

  return result;
}

let isPythagoreanTriple = function (triple) {
  return Math.pow(triple.a, 2) + Math.pow(triple.b, 2) === Math.pow(triple.c, 2);
}

myFilter([{ a: 3, b: 4,  c: 5 },
          { a: 5, b: 12, c: 13 },
          { a: 1, b: 2,  c: 3 },], isPythagoreanTriple);
```

---

Example problem: Let's build a program that removes numbers that are **not** a multiple of either 3 or 5 from an array of integers and returns it.

```javascript
function multiplesOfThreeOrFive(values) {
  // ...
}

function isMultipleOfThreeOrFive(value) {
  return value % 5 === 0 || value % 3 === 0;
}

multiplesOfThreeOrFive([1, 3, 5, 7, 11, 18, 16, 15]);  // [ 3, 5, 18, 15 ]
```

### Solution

```javascript
function multiplesOfThreeOrFive(values) {
  values.filter(isMultipleofThreeOrFive);
}

function isMultipleOfThreeOrFive(value) {
  return value % 5 === 0 || value % 3 === 0;
}

multiplesOfThreeOrFive([1, 3, 5, 7, 11, 18, 16, 15]);  // [ 3, 5, 18, 15 ]
```
