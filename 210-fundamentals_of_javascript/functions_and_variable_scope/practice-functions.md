
# Practice Problems: Functions - 10/22/2020

1. We need a piece of reusable code that returns the average of three numbers. Define a function named `average` that takes three parameters, `a`, `b`, and `c`, and returns their average. Call the function with three numbers and log the result.

### Solution

```javascript
function average(a, b, c) {
  return (a + b + c) / 3;
}

console.log(average(5, 7, 9));
// => 7
```

---

2. We now need a function that calculates the sum of the same three values. Create a function named `sum` that takes the same three arguments as `average`, and returns the sum of the three arguments. Now modify `average` to call the `sum` function with those three arguments and use the return value to calculate the average.

### Solution

```javascript
function sum(a, b, c) {
  return a + b + c;
}

function average(a, b, c) {
return sum(a, b, c) / 3;
}

console.log(average(5, 7, 9));
// => 7
```

---

3. Suppose we have a different number of values from which to calculate an average. Our current `average` function only takes three numbers; we might need to write additional functions if we want to work with different numbers of data points. A better solution, though, is to change the function to accept an array of arbitrary length. We can calculate the average by looping over the array elements to calculate the total, then divide by the array length.

Create a variable named `total` with an initial value of `0` at the start of the `average` function. Use a `for` loop to iterate over all the elements in the array. With each iteration, add the element's value to the `total`. When the loop finishes, return the `total` divided by the array's length. Call `average` with an array of five numbers and log the result.

### Solution

```javascript
function average(numbers) {
  let total = 0;
  for (let index = 0; index < numbers.length; index++) {
    total += numbers[index];
  }

  return total / numbers.length;
}

console.log(average([5, 6, 7, 8, 9]));
// => 7
```

---

4. We should make the same changes to the `sum` function so we can continue to use it from the `average` function. Since we've already written that functionality in `average`, we can just move it from there to `sum`. Move everything from `average` into `sum`, except for the final `return` statement. The `sum` function should return the total, and `average` should call the `sum` function with the same values, then divide the return value by the array length, and return it.

As before, call `average` with an array of five numbers and log the result.

### Solution

```javascript
function sum(numbers) {
  let result = 0;
  for (let index = 0; index < numbers.length; index++) {
    result += numbers[index];
  }

  return result;
}

function average(numbers) {
  return sum(numbers) / numbers.length;
}

console.log(average([5, 6, 7, 8, 9,]));
// => 7
```

---

5. With the refactors done for question 3 and 4, we can now use our functions to determine the average of all the numbers in an arbitrary array of numbers. Create an array named `temperatures` and store five temperature values in it. Find the average temperature by passing the array to the `average` function and log the result.

### Solution

```javascript
let temperatures = [78, 60, 71, 73, 61];
console.log(average(temperatures));
// => 68.6
```
