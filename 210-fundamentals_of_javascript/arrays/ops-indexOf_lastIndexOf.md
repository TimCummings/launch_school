
# Array Operations: indexOf and lastIndexOf - 10/30/2020

1. Write a function `indexOf` that accepts two arguments: an array and a value. The function returns the first index at which the value can be found, or `-1` if the value is not present.

```javascript
indexOf([1, 2, 3, 3], 3);         // 2
indexOf([1, 2, 3], 4);            // -1
```

### Solution

```javascript
function indexOf(array, value) {
  for (let index = 0; index < array.length; index += 1) {
    if (array[index] === value) return index;
  }

  return -1;
}
```

---

2. Write a function `lastIndexOf` that accepts two arguments: an array and a value. The function returns the last index at which the value can be found in the array, or `-1` if the value is not present.

```javascript
lastIndexOf([1, 2, 3, 3], 3);     // 3
lastIndexOf([1, 2, 3], 4);        // -1
```

### Solution

```javascript
function lastIndexOf(array, value) {
  for (let index = array.length - 1; index >= 0; index -= 1) {
    if (array[index] === value) return index;
  }

  return -1;
}
```
