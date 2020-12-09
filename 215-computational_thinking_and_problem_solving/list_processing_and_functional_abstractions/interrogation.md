
# Interrogation - 11/15/2020

## Exercises

Write a function named `myOwnEvery` that's similar to the [Array.prototype.every](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/every) method. It should take an array and a function as arguments, and return `true` if every element passed to the function evaluates as truthy.

```javascript
function myOwnEvery(array, func) {
  // ...
}

let isAString = value => typeof value === 'string';
myOwnEvery(['a', 'a234', '1abc'], isAString);       // true
```

### Solution

```javascript
function myOwnEvery(array, func) {
  array.forEach(element => if (!func(element) return false));

  return true;
}

let isAString = value => typeof value === 'string';
myOwnEvery(['a', 'a234', '1abc'], isAString);       // true
```
