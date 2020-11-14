
# Practice Problems: Intermediate Array Uses - 10/31/2020

1. Write a function that creates and returns a new array from its array argument. The new array should contain all values from the argument array whose positions have an odd index.

```javascript
function oddElementsOf(arr) {
  // …
}

let digits = [4, 8, 15, 16, 23, 42];

oddElementsOf(digits);    // returns [8, 16, 42]
```

### Solution

```javascript
const oddElementsOf = function(arr) {
  let oddElements = [];
  for (let index = 0; index < arr.length; index += 1) {
    if (index % 2 === 1) oddElements.push(arr[index]);
  }

  return oddElements;
};
```

#### Adjustments based on provided solution

Don't check every element, just start `index` at 1 and increment by 2:

```javascript
const oddElementsOf(arr) {
  let oddElements = [];
  for (let index = 1; index < arr.length; index += 2) {
    oddElements.push(arr[index]);
  }

  return oddElements;
};
```

---

2. Write a function that takes an array argument and returns a new array that contains all the argument's elements in their original order followed by all the argument's elements in reverse order.

### Solution

```javascript
const concatReversed = function(array) {
  let reversed = [];
  for (let index = array.length - 1; index >= 0; index -= 1) {
    reversed.push(array[index]);
  }

  return array.concat(reversed);
};
```

#### Adjustments based on provided solution

I think I'm still stuck in the mindset of the operations exercises: my solutions here don't have to be basic; I can use built-in array methods! The key here is to use `slice()` to make a copy of the array before invoking `reverse()`, which is a mutating method:

```javascript
const concatReversed = function(array) {
  return array.concat(array.slice().reverse());
};
```

---

3. Use the [array sort method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/sort) to create a function that takes an array of numbers and returns a new array of the numbers sorted in descending order. Do not alter the original array.

```javascript
function sortDescending(arr) {
  // …
}

let array = [23, 4, 16, 42, 8, 15];
let result = sortDescending(array);  // returns [42, 23, 16, 15, 8, 4]
console.log(result);                 // logs    [42, 23, 16, 15, 8, 4]
console.log(array);                  // logs    [23, 4, 16, 42, 8, 15]
```

### Solution

```javascript
const sortDescending = function(array) {
  let copiedArray = array.slice();

  return copiedArray.sort((first, second) => {
    if (first >= second) {
      return -1;
    } else {
      return 1;
    }
  });
}
```

#### Adjustments based on provided solution

The `compareFunction` passed to `sort()` can be greatly simplified with basic arithmetic:

```javascript
const sortDescending = function(array) {
  let copiedArray = array.slice();
  return copiedArray.sort((first, second) => second - first);
}
```

---

4. Write a function that takes an array of arrays as an argument, and returns a new array that contains the sums of each of the sub-arrays.

```javascript
function matrixSums(arr) {
  // …
}

matrixSums([[2, 8, 5], [12, 48, 0], [12]]);  // returns [15, 60, 12]
```

### Solution

```javascript
const matrixSums = function(arr) {
  return arr.map(innerArray => innerArray.reduce((x, y) => x + y));
}
```

---

5. Write a function that takes an array, and returns a new array with duplicate elements removed.

```javascript
function uniqueElements(arr) {
  // …
}

uniqueElements([1, 2, 4, 3, 4, 1, 5, 4]);  // returns [1, 2, 4, 3, 5]
```

### Solution

```javascript
const uniqueElements = function (arr) {
  let uniques = [];

  arr.forEach(function(element) {
    if (!uniques.includes(element)) uniques.push(element);
  });

  return uniques;
}
```
