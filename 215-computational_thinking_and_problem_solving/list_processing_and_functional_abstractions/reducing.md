
# Reducing - 11/14/2020

Write a function named `myReduce` that's similar to the [Array.prototype.reduce](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce) method. It takes an array and a function as arguments, and optionally, a third argument that serves as an initial value. If the caller omits the initial value, `myReduce` should use the first element of the Array as the initial value. `myReduce` should return the value returned by the last invocation of the callback function.

```javascript
function myReduce(array, func, initial) {
  // ...
}

let smallest = (result, value) => (result <= value ? result : value);
let sum = (result, value) => result + value;

myReduce([5, 12, 15, 1, 6], smallest);           // 1
myReduce([5, 12, 15, 1, 6], sum, 10);            // 49
```

### Solution

```javascript
function myReduce(array, func, initial) {
  let index;
  let result;

  if (initial === undefined) {
    result = array[0];
    index = 1;
  } else {
    result = initial;
    index = 0;
  }

  for (index; index < array.length; index += 1) {
    result = func(result, array[index], index, array);
  }

  return result;
}

let smallest = (result, value) => (result <= value ? result : value);
let sum = (result, value) => result + value;

myReduce([5, 12, 15, 1, 6], smallest);           // 1
myReduce([5, 12, 15, 1, 6], sum, 10);            // 49
```
