
# Practice Problems: Find Missing Numbers - 11/1/2020

Write a function that takes a sorted array of integers as an argument, and returns an array that includes all the missing integers (in order) between the first and last elements of the argument.

Examples:

```javascript
missing([-3, -2, 1, 5]);                  // [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]);                    // []
missing([1, 5]);                          // [2, 3, 4]
missing([6]);                             // []
```

### Solution

```javascript
function missing(array) {
  let start = array[0];
  let missingNumbers = [];

  for (let index = 0; index < array.length; index += 1) {
    if (start < array[index]) {
      do {
        missingNumbers.push(start);
        start += 1;
      } while (start < array[index]);
    }

    start += 1;
  }

  return missingNumbers;
}
```
