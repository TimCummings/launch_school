
# Practice Problem: Comparing Arrays - 10/31/2020

In the last assignment, we saw that JavaScript's equality operators don't examine the values in the arrays—instead, they check that the arrays are the same object. It's more likely that you'll want to know whether two arrays contain the same values. To do this, you need to write your own function.

Write a function named `arraysEqual` that takes two arrays as arguments. The function should return `true` if the arrays contain the same values, or `false` if they do not.

Test the function with arrays that contain number, string, and boolean values. Don't worry about handling arrays that contain other Arrays or Objects.

```javascript
arraysEqual([1], [1]);                               // true
arraysEqual([1], [2]);                               // false
arraysEqual([1, 2], [1, 2, 3]);                      // false
arraysEqual([1, 'hi', true], [1, 'hi', true]);       // true
arraysEqual([1, 'hi', true], [1, 'hi', false]);      // false
arraysEqual([1, 'hi', true], [1, 'hello', true]);    // false
arraysEqual([1, 'hi', true], [2, 'hi', true]);       // false
```

### Solution

```javascript
function arraysEqual(array1, array2) {
  if (array1.length !== array2.length) return false;

  for (let index = 0; index < array1.length; index += 1) {
    if (array1[index] !== array2[index]) return false;
  }

  return true;
}
```
