
# JS210 Small Problems - Advanced 1 - 11/29/2020

## 1. Madlibs Revisited

Let's build another program using madlibs. We made a similar program in the Easy exercises, but this time the requirements are a bit different.

Build a madlibs program that takes a text `template` as input, plugs in a selection of randomized nouns, verbs, adjectives, and adverbs into that text, and then returns it. You can build your lists of nouns, verbs, adjectives, and adverbs directly into your program. Your program should read this text and, for each line, place random words of the appropriate types into the text and return the result.

The challenge of this program isn't just about writing your solution — it's about choosing the structure of the text `template`. Choose the right way to structure your `template` and this problem becomes much easier. Consequently, this exercise is a bit more open-ended since the input is also something that you'll be defining.

Examples:

*Note: The quotes in the example strings returned by the `madlibs` function are only shown for emphasis. These quotes are not present in the actual output strings. The words in quotes come from the list of texts and it is the `madlibs` function that puts them in.*

```javascript
function madlibs(template) {
  // ...
}

// These examples use the following list of replacement texts:
adjectives: quick lazy sleepy noisy hungry
nouns: fox dog head leg tail cat
verbs: jumps lifts bites licks pats
adverbs: easily lazily noisily excitedly
------

madlibs(template1);
// The "sleepy" brown "cat" "noisily"
// "licks" the "sleepy" yellow
// "dog", who "lazily" "licks" his
// "tail" and looks around.

madlibs(template1);
// The "hungry" brown "cat" "lazily"
// "licks" the "noisy" yellow
// "dog", who "lazily" "licks" his
// "leg" and looks around.

madlibs(template2);      // The "fox" "bites" the "dog"'s "tail".

madlibs(template2);      // The "cat" "pats" the "cat"'s "head".
```

### Solution

```javascript
const NOUNS = ['fox', 'dog', 'head', 'leg', 'tail', 'cat'];
const ADJECTIVES = ['quick', 'lazy', 'sleepy', 'noisy', 'hungry'];
const VERBS = ['jumps', 'lifts', 'bites', 'licks', 'pats'];
const ADVERBS = ['easily', 'lazily', 'noisily', 'excitedly'];

let randomInt = function randomInt(min, max) {
  return Math.floor((Math.random() * (max - min)) + min);
};

let getRandom = function getRandom(match, type) {
  switch (type) {
    case 'noun': return NOUNS[randomInt(0, NOUNS.length)];
    case 'adjective': return ADJECTIVES[randomInt(0, ADJECTIVES.length)];
    case 'verb': return VERBS[randomInt(0, VERBS.length)];
    case 'adverb': return ADVERBS[randomInt(0, ADVERBS.length)];
    default: return 'invalid';
  }
};

let madlibs = function madlibs(template) {
  ['noun', 'adjective', 'verb', 'adverb'].forEach(type => {
    let regexp = new RegExp(`#\\$!(${type})!\\$#`, 'g');
    template = template.replace(regexp, getRandom);
  });

  return template;
};

let template1 = `The #$!adjective!$# brown #$!noun!$# #$!adverb!$#
#$!verb!$# the #$!adjective!$# yellow
#$!noun!$#, who #$!adverb!$# #$!verb!$# his
#$!noun!$# and looks around.`;

let template2 = `The #$!noun!$# #$!verb!$# the #$!noun!$#'s #$!noun!$#.`
```

---

## 2. Transpose 3x3

A 3x3 matrix can be represented by an array of arrays: an outer array containing three subarrays that each contain three elements. For example, the 3x3 matrix shown below:

```
1  5  8
4  7  2
3  9  6
```

is represented by the following array of arrays:

```javascript
const matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6],
];
```

> An array of arrays is sometimes called a *"nested array"* because each inner subarray is nested inside an outer array. It also may be called a "two-dimensional array".
>
> To access an element in the matrix, you can use bracket notation twice (such as `array[][]`), and include both the row index and column index within the brackets. Given the above matrix, `matrix[0][2]` is `8`, and `matrix[2][1]` is `9`. An entire row in the matrix can be referenced using a single index: `matrix[1]` is the row (subarray) `[4, 7, 2]`. Furthermore, given a row, we can determine the total number of columns by counting the number of elements in the row. Unfortunately, a convenient notation for accessing an entire column does not exist.

The *transpose* of a 3x3 matrix is the matrix that results from exchanging the rows and columns of the original matrix. For example, the transposition of the matrix shown above is:

```
1  4  3
5  7  9
8  2  6
```

Write a function that takes an array of arrays representing a 3x3 `matrix`, and returns the transpose of the `matrix`. You should implement the function on your own, without using any external libraries.

Take care not to modify the original `matrix` — your function must produce a new matrix and leave the input `matrix` array unchanged.

Examples:

```javascript
const matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
];

const newMatrix = transpose(matrix);

console.log(newMatrix);      // [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
console.log(matrix);         // [[1, 5, 8], [4, 7, 2], [3, 9, 6]]
```

### Solution

```javascript
let transpose = function transpose(matrix) {
  let result = [[], [], []];

  for (let col = 0; col < matrix[0].length; col += 1) {
    for (let row = 0; row < matrix.length; row += 1) {
      result[col].push(matrix[row][col]);
    }
  }

  return result;
};
```

---

## 3. Transpose MxN

In the previous exercise, you wrote a function that transposed a 3x3 matrix represented by an array of arrays.

Matrix transposes are not limited to 3x3 matrices, or even square matrices. Any matrix can be transposed simply by switching columns with rows.

Modify your `transpose` function from the previous exercise so that it works with any MxN matrix with at least one row and one column.

Examples:

```javascript
transpose([[1, 2, 3, 4]]);            // [[1], [2], [3], [4]]
transpose([[1], [2], [3], [4]]);      // [[1, 2, 3, 4]]
transpose([[1]]);                     // [[1]]

transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]);
// [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
```

### Solution

```javascript
let transpose = function transpose(matrix) {
  const numberOfRows = matrix[0].length;
  let result = [];

  for (let counter = 1; counter <= numberOfRows; counter += 1) {
    result.push([]);
  }

  for (let col = 0; col < numberOfRows; col += 1) {
    for (let row = 0; row < matrix.length; row += 1) {
      result[col].push(matrix[row][col]);
    }
  }

  return result;
};
```

---

## 4. Rotating Matrices

As we saw in the previous exercises, a matrix can be represented by an array of arrays. For example, the 3x3 matrix shown below:

```
1  5  8
4  7  2
3  9  6
```

is represented by the following array of arrays:

```javascript
const matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6],
];
```

A 90-degree rotation of a matrix produces a new matrix in which each side of the matrix is rotated clockwise by 90 degrees. For example, the 90-degree rotation of the matrix shown above is:

```
3  4  1
9  7  5
6  2  8
```

A 90-degree rotation of a non-square matrix is similar. For example, given the following matrix:

```
3  4  1
9  7  5
``

its 90-degree rotation is:

```
9  3
7  4
5  1
```

Write a function that takes an arbitrary MxN `matrix`, rotates it clockwise by 90-degrees as described above, and returns the result as a new matrix. The function should not mutate the original `matrix`.

Examples:

```javascript
const matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6],
];

const matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8],
];

const newMatrix1 = rotate90(matrix1);
const newMatrix2 = rotate90(matrix2);
const newMatrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))));

console.log(newMatrix1);      // [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
console.log(newMatrix2);      // [[5, 3], [1, 7], [0, 4], [8, 2]]
console.log(newMatrix3);      // `matrix2` --> [[3, 7, 4, 2], [5, 1, 0, 8]]
```

### Solution

```javascript
let rotate90 = function rotate90(matrix) {
  const numberOfRows = matrix[0].length;
  const result = [];

  for (let counter = 1; counter <= numberOfRows; counter += 1) {
    result.push([]);
  }

  for (let row = 0; row < matrix.length; row += 1) {
    for (let col = 0; col < numberOfRows; col += 1) {
      result[col].unshift(matrix[row][col]);
    }
  }

  return result;
};
```

---

## 5. Merge Sorted Lists

Write a function that takes two sorted arrays as arguments, and returns a new array that contains all the elements from both input arrays in sorted order.

You may not provide any solution that requires you to sort the result array. You must build the result array one element at a time in the proper order.

Your solution should not mutate the input arrays.

Examples:

```javascript
merge([1, 5, 9], [2, 6, 8]);      // [1, 2, 5, 6, 8, 9]
merge([1, 1, 3], [2, 2]);         // [1, 1, 2, 2, 3]
merge([], [1, 4, 5]);             // [1, 4, 5]
merge([1, 4, 5], []);             // [1, 4, 5]
```

### Solution

```javascript
let merge = function merge(array1, array2) {
  let result = [];

  let index1 = 0;
  let index2 = 0;

  while (index1 < array1.length && index2 < array2.length) {
    if (array1[index1] <= array2[index2]) {
      result.push(array1[index1]);
      index1 += 1;
    } else {
      result.push(array2[index2]);
      index2 += 1;
    }
  }

  if (index1 < array1.length) {
    result = result.concat(array1.slice(index1));
  } else if (index2 < array2.length) {
    result = result.concat(array2.slice(index2));
  }

  return result;
};
```

---

## 6. Merge Sort

*Merge sort* is a recursive sorting algorithm that works by breaking down an array's elements into nested subarrays, then combining those nested subarrays back together in sorted order. It is best explained with an example. Given the array `[9, 5, 7, 1]`, let's walk through the process of sorting it with merge sort. We'll start off by breaking the array down into nested subarrays:

```
[9, 5, 7, 1] -->
[[9, 5], [7, 1]] -->
[[[9], [5]], [[7], [1]]]
```

We then work our way back to a flat array by merging each pair of nested subarrays back together in the proper order:

```
[[[9], [5]], [[7], [1]]] -->
[[5, 9], [1, 7]] -->
[1, 5, 7, 9]
```

Write a function that takes an array, and returns a new array that contains the values from the input array in sorted order. The function should sort the array using the merge sort algorithm as described above. You may assume that every element of the array will be of the same data type—either all numbers or all strings.

Feel free to use the `merge` function you wrote in the previous exercise.

Examples:

```javascript
mergeSort([9, 5, 7, 1]);           // [1, 5, 7, 9]
mergeSort([5, 3]);                 // [3, 5]
mergeSort([6, 2, 7, 1, 4]);        // [1, 2, 4, 6, 7]

mergeSort(['Sue', 'Pete', 'Alice', 'Tyler', 'Rachel', 'Kim', 'Bonnie']);
// ["Alice", "Bonnie", "Kim", "Pete", "Rachel", "Sue", "Tyler"]

mergeSort([7, 3, 9, 15, 23, 1, 6, 51, 22, 37, 54, 43, 5, 25, 35, 18, 46]);
// [1, 3, 5, 6, 7, 9, 15, 18, 22, 23, 25, 35, 37, 43, 46, 51, 54]
```

### Solution

```javascript
let mergeSort = function mergeSort(array) {
  if (array.length === 1) return array;

  let middleIndex = Math.floor(array.length / 2);
  let firstHalf = array.slice(0, middleIndex);
  let secondHalf = array.slice(middleIndex);

  return merge(mergeSort(firstHalf), mergeSort(secondHalf));
};
```

---

## 7. Binary Search

It is quite common to find yourself in a situation where you need to perform a search on some data to find something you're looking for. Imagine that you need to search through the [yellow pages](https://en.wikipedia.org/wiki/Yellow_pages) to find the phone number of a particular business. A straightforward way to do this would be to go through the yellow pages one business at a time, checking if the current business name is the one you're trying to find.

This may be a simple and easy way to search, but it's not very efficient. In the worst case scenario, it could mean having to search through every single business name before finding out that the business isn't listed—or, slightly better, having to go through every letter from `'A'` to `'Z'` before finding the business. A *linear search* such as this can take quite a long time.

A *binary search* algorithm is a much more efficient alternative. This algorithm allows you to cut the search area in half on each iteration by discarding the half that you know your search term doesn't exist in. The binary search algorithm is able to do this by relying on the data being `sorted`. Going back to the yellow pages example, let's say that we're searching the following `yellowPages` data for the search item `'Pizzeria'`:

```javascript
// Yellow pages list of business names data:
const yellowPages = ['Apple Store', 'Bags Galore',
                     'Bike Store',  'Donuts R Us',
                     'Eat a Lot',   'Good Food',
                     'Pasta Place', 'Pizzeria',
                     'Tiki Lounge', 'Zooper'];
```

With a linear search, we would have to sequentially go through each of the items until we found the search item `'Pizzeria'`. In a binary search, however, the following sequence happens:

* Retrieve the middle value from the data (assume truncation to integer) --> `'Eat a Lot'`.
* If the middle value is equal to `'Pizzeria'`, stop the search.
* If the middle value is less than `'Pizzeria'`:
  * Discard the lower half, including the middle value --> `['Apple Store', 'Bags Galore', 'Bike Store', 'Donuts R Us', 'Eat a Lot']`.
  * Repeat the process from the top, using the upper half as the starting data --> `['Good Food', 'Pasta Place', 'Pizzeria', 'Tiki Lounge', 'Zooper']`.
* If the middle value is greater than `'Pizzeria'`, do the same as the previous step, but with opposite halves.

Using the process described above, the search successfully ends on the second iteration when the middle value is `'Pizzeria'`.

Implement a `binarySearch` function that takes an `array` and a `searchItem` as arguments, and returns the index of the `searchItem` if found, or `-1` otherwise. You may assume that the `array` argument will always be sorted.

Examples:

```javascript
const yellowPages = ['Apple Store', 'Bags Galore', 'Bike Store', 'Donuts R Us', 'Eat a Lot', 'Good Food', 'Pasta Place', 'Pizzeria', 'Tiki Lounge', 'Zooper'];
binarySearch(yellowPages, 'Pizzeria');                   // 7
binarySearch(yellowPages, 'Apple Store');                // 0

binarySearch([1, 5, 7, 11, 23, 45, 65, 89, 102], 77);    // -1
binarySearch([1, 5, 7, 11, 23, 45, 65, 89, 102], 89);    // 7
binarySearch([1, 5, 7, 11, 23, 45, 65, 89, 102], 5);     // 1

binarySearch(['Alice', 'Bonnie', 'Kim', 'Pete', 'Rachel', 'Sue', 'Tyler'], 'Peter');  // -1
binarySearch(['Alice', 'Bonnie', 'Kim', 'Pete', 'Rachel', 'Sue', 'Tyler'], 'Tyler');  // 6
```

### Solution

```javascript
let getMiddleIndex = function getMiddleIndex(beginIndex, endIndex) {
  return Math.floor((endIndex - beginIndex) / 2) + beginIndex;
};

let binarySearch = function binarySearch(array, searchItem) {
  let beginIndex = 0;
  let endIndex = array.length - 1;

  while (beginIndex < endIndex) {
    let currentIndex = getMiddleIndex(beginIndex, endIndex);
    if (searchItem === array[currentIndex]) return currentIndex;

    if (searchItem < array[currentIndex]) {
      endIndex = currentIndex - 1;
    } else {
      beginIndex = currentIndex + 1;
    }
  }

  if (searchItem === array[beginIndex]) return beginIndex;
  return -1;
}
```

#### Adjustments based on provided solution

The last `searchItem` check before returning `-1` can be removed if the `while` condition is changed:

```javascript
let binarySearch = function binarySearch(array, searchItem) {
  let beginIndex = 0;
  let endIndex = array.length - 1;

  while (beginIndex <= endIndex) {
    let currentIndex = getMiddleIndex(beginIndex, endIndex);
    if (searchItem === array[currentIndex]) return currentIndex;

    if (searchItem < array[currentIndex]) {
      endIndex = currentIndex - 1;
    } else {
      beginIndex = currentIndex + 1;
    }
  }

  return -1;
}
```
