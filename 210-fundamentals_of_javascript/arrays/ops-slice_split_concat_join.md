
# Array Operations: slice, split, concat, and join - 10/30/2020

1. Write a function named `slice` that accepts three arguments: an Array, a start index, and an end index. The function should return a new Array that contains values from the original Array starting with the value at the starting index, and including all values up to but not including the end index. Do not modify the original Array.

*You may use functions that were answers to previous practice problems to complete this problem, but do not use any built-in Array methods.*

```javascript
slice([1, 2, 3, 4, 5], 0, 2);                      // [ 1, 2 ]
slice(['a', 'b', 'c', 'd', 'e', 'f', 'g'], 1, 3);  // [ 'b', 'c' ]
```

### Solution

```javascript
function slice(array, start, end) {
  if (start > array.length || start > end) return [];
  if (end > array.length) end = array.length;

  let result = [];
  for (let index = start; index < end; index += 1) {
    push(result, array[index]);
  }

  return result;
}
```

---

2. Write a function named `splice` that accepts three arguments: an Array, a start index, and the number of values to remove. The function should remove values from the original Array, starting with the first index and removing the specified number of values. The function should return the removed values in a new Array.

*You may use functions that were answers to previous practice problems to complete this problem, but do not use any built-in Array methods.*

```javascript
let count = [1, 2, 3, 4, 5, 6, 7, 8];
splice(count, 2, 5);                   // [ 3, 4, 5, 6, 7 ]
count;                                 // [ 1, 2, 8 ]
```

### Solution

```javascript
function splice(array, start, count) {
  if (start > array.length) return [];
  if (count > array.length - start) count = array.length - start;

  let result = [];
  let offset = start + count;
  for (let index = start; index < offset; index += 1) {
    push(result, array[index]);
    array[index] = array[index + count];
  }

  array.length -= count;
  return result;
}
```

#### Adjustments based on provided solution

I have a huge error: my solution doesn't work for cases where there are leftover elements after the removed section, because my `for` loop stops at `offset` which is `start + count` instead of continuing to the end of the array (not to remove elements, but to left-shift them the appropriate amount.)

```javascript
function splice(array, start, count) {
  if (start > array.length) return [];
  if (count > array.length - start) count = array.length - start;

  let result = [];
  for (let index = start; index < array.length; index += 1) {
    if (index < start + count) push(result, array[index]);
    array[index] = array[index + count];
  }

  array.length -= count;
  return result;
}
```

---

3. Write a function named `concat` that accepts two Array arguments. The function should return a new Array that contains the values from each of the original Arrays.

*You may use functions that were answers to previous practice problems to complete this problem, but do not use any built-in Array methods.*

```javascript
concat([1, 2, 3], [4, 5, 6]);       // [ 1, 2, 3, 4, 5, 6 ]
```

### Solution

```javascript
function concat(array1, array2) {
  let result = []

  for (let index = 0; index < array1.length; index += 1) {
    push(result, array1[index]);
  }
  for (let index = 0; index < array2.length; index += 1) {
    push(result, array2[index]);
  }

  return result;
}
```

---

4. Write a function named `join` that accepts two arguments: an Array and a String. The function should coerce each value in the Array to a String, and then join those values together using the second argument as a separator. You may assume that a separator will always be passed.

You can call the `String` function on any JavaScript value to get its String representation.

```javascript
join(['bri', 'tru', 'wha'], 'ck ');       // 'brick truck wha'
join([1, 2, 3], ' and ');                 // '1 and 2 and 3'
```

### Solution

```javascript
function join(array, separator) {
  let joined = '';
  for (let index = 0; index < array.length - 1; index += 1) {
    joined += (String(array[index]) + separator);
  }

  joined += String(array[array.length - 1]);
  return joined;
}
```
