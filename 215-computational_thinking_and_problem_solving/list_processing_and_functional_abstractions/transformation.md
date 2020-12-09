
# Transformation - 11/14/2020

Write a Function named `myMap` that is similar to the built-in [Array.prototype.map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) method. Your Function should take an array and another Function (the callback) as arguments, and return a new Array. The new Array's values should be the return values of the callback Function.

```javascript
function myMap(array, func) {
  // ...
}

let plusOne = n => n + 1;
myMap([1, 2, 3, 4], plusOne);       // [ 2, 3, 4, 5 ]
```

### Solution

```javascript
function myMap(array, func) {
  let result = [];
  array.forEach(value => result.push(func(value)));
  return result;
}

let plusOne = n => n + 1;
myMap([1, 2, 3, 4], plusOne);       // [ 2, 3, 4, 5 ]
```
