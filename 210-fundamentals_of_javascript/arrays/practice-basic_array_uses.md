
# Practice Problems: Basic Array Uses - 10/31/2020

In the problems below, we ask you to write functions that work with Arrays. You may use Array's index access (`[]`), the `length` property, and any Array Methods you need.

1. Write a function that returns the first element of an array passed in as an argument.

```javascript
function firstElementOf(arr) {
  // …
}

firstElementOf(['U', 'S', 'A']);  // returns "U"
```

### Solution

```javascript
function firstElementOf(arr) {
  return arr[0];
}
```

---

2. Write a function that returns the last element of an array passed in as an argument.

```javascript
function lastElementOf(arr) {
  // …
}

lastElementOf(['U', 'S', 'A']);  // returns "A"
```

### Solution

```javascript
function lastElementOf(arr) {
  return arr[arr.length - 1];
}
```

---

3. Write a function that accepts two arguments, an array and an integer index position, and returns the element at the given index. What happens if the index is greater than the length of the array? What happens if it is a negative integer?

```javascript
function nthElementOf(arr, index) {
  // …
}

let digits = [4, 8, 15, 16, 23, 42];

nthElementOf(digits, 3);   // returns 16
nthElementOf(digits, 8);   // what does this return?
nthElementOf(digits, -1);  // what does this return?
```

### Solution

```javascript
function nthElementOf(arr, index) {
  return arr[index];
}
```

If the index is greater than the length of the array, index access (`[]`) or `nthElementOf()` will return `undefined`.
If the index is negative, index access (`[]`) or `nthElementOf()` will count backwards from the end of the array.

#### Adjustments based on provided solution

Array index access (`[]`) or `nthElementOf()` return `undefined` when the index is negative; they don't count backwards from the end of the array.

---

4. Can we insert data into an array at a negative index? If so, why is this possible?

### Solution

Kind of: we can insert data this way, but it's not at a negative index; instead, we're adding a property to the array (as aJavaScript arrays are really objects) with the "negative index" getting coerced to a string key with the would-be element we're trying to insert as that key's value.

---

5. Write a function that accepts an array as the first argument and an integer value, `count`, as the second. It should return a new array that contains the first `count` elements of the array.

```javascript
function firstNOf(arr, count) {
  // …
}

let digits = [4, 8, 15, 16, 23, 42];
firstNOf(digits, 3);    // returns [4, 8, 15]
```

### Solution

```javascript
function firstNOf(arr, count) {
  if (count > arr.length) count = arr.length;

  let subArray = [];
  for (let index = 0; index < count; index += 1) {
    subArray[index] = arr[index];
  }

  return subArray;
}
```

---

6. Write a function like the previous one, except this time return the last `count` elements as a new array.

```javascript
function lastNOf(arr, count) {
  // …
}

let digits = [4, 8, 15, 16, 23, 42];
lastNOf(digits, 3);    // returns [16, 23, 42]
```

### Solution

```javascript
function lastNOf(arr, count) {
  if (count > arr.length) count = arr.length;

  let subArray = [];
  for (let index = arr.length - count; index < arr.length; index += 1) {
    subArray.push(arr[index]);
  }

  return subArray;
}
```

---

7. Using the function from the previous problem, What happens if you pass a `count` greater than the length of the array? How can you fix the function so it returns a new instance of the entire array when `count` is greater than the array length?

### Solution

When passing a `count` greater than the length of the array, the value passed to `Array.slice()` as its `start` argument is negative, which counts the starting index backwards from the end of the array.

```javascript
function lastNOf(arr, count) {
  if (count > arr.length) count = arr.length;
  return arr.slice(arr.length - count);
}

let digits = [4, 8, 15, 16, 23, 42];
console.log(lastNOf(digits, 3));    // returns [16, 23, 42]
console.log(lastNOf(digits, 9));    // returns [4, 8, 15, 16, 23, 42]
```

---

8. Write a function that accepts two arrays as arguments and returns an array with the first element from the first array and the last element from the second array.

```javascript
function endsOf(beginningArr, endingArr) {
  // …
}

endsOf([4, 8, 15], [16, 23, 42]);  // returns [4, 42]
```

### Solution

```javascript
function endsOf(array1, array2) {
  let ends = [];
  ends.push(array1[0], array2[array2.length - 1]);

  return ends;
}
```
