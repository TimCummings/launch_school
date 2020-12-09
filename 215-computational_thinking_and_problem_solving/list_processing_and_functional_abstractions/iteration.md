
# Iteration - 11/14/2020

## Exercises

Write a Function named `myForEach` that is similar to the built-in [Array.prototype.forEach](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach) method. Your Function should take an array and another Function as arguments. The Function passed to `myForEach` should mutate a variable in the outer scope. In the code fragment below, the Function passed to `myForEach` mutates the `min` variable.

```javascript
function myForEach(array, func) {
  // ...
}

let min = Infinity;
let getMin = value => (min = value <= min ? value : min);
myForEach([4, 5, 12, 23, 3], getMin);
console.log(min);                        // 3
```

### Solution

```javascript
function myForEach(array, func) {
  for (let index = 0; index < array.length; index += 1) {
    func(array[index]);
  }
}

let max = -Infinity;
let getMax = number => (max = number > max ? number : max);
myForEach([4, 5, 12, 23, 3], getMax);
console.log(max);
```
