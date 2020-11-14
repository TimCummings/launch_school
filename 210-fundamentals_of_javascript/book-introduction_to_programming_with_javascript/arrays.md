
# Arrays - 10/19/2020

* An array is an ordered list of **elements**.
* An array is also an **indexed** list - each element has a unique index number for its position in the array.
* Elements may be **heterogeneous** - of different types.
* Arrays are enclosed in brackets `[ ]`.

Note that arrays declared with `const` are a little strange; while you can't change what array a `const` references, you can modify the array's contents:

```javascript
> const MyArray = [1, 2, 3]
> MyArray[1] = 5
> MyArray
= [1, 5, 3]

> MyArray = [4, 5, 6] // Uncaught TypeError: Assignment to constant variable.
```

This type of behavior can be confusing. It stems from the "variables as pointers" concept that we discuss a little later. Essentially, a `const` declaration prohibits changing what thing the `const` points to, but it does not prohibit changing the content of that thing. Thus, we can change an element in a `const` array, but we can't change which array the `const` points to.

If you want the elements of the array to also be const, you can use the Object.freeze method:

```javascript
> const MyArray = Object.freeze([1, 2, 3])
> MyArray[1] = 5
> MyArray
= [1, 2, 3]
```

Notice how the assignment on line 2 had no effect on the content of the array.

It's important to realize that `Object.freeze` only works one level deep in the array. If your array contains nested arrays or other objects, the values inside them can still be changed unless they are also frozen:

```javascript
> const MyArray = Object.freeze([1, 2, 3, [4, 5, 6]])
> MyArray[3][1] = 0
> MyArray
= [1, 2, 3, [4, 0, 6]]
```

If you want the sub-array to be constant as well, you have to freeze it:

```javascript
> const MyArray = Object.freeze([1, 2, 3, Object.freeze([4, 5, 6])])
> MyArray[3][1] = 0
> MyArray
= [1, 2, 3, [4, 5, 6]]
```

### Adding Elements With `push`

The `push` method adds one or more elements to the end of an array:

```javascript
> array.push('a')
= 5               // the new length of the array

> array
= [ 1, 4, 3, 10, 'a' ]

> array.push(null, 'xyz')
= 7

> array
= [ 1, 4, 3, 10, 'a', null, 'xyz' ]
```

`push` appends its arguments to the caller (the array): it mutates the caller. It returns the array's new length.

> Let's take a moment to review a point we discussed in a previous chapter: functions (and methods) have actions that they perform and values that they return. You must be careful to distinguish between these two aspects. `push`, for instance, appends elements to the end of the caller array, but it returns the updated length of that array. In particular, it does not return the modified array! New JavaScript programmers often get confused over this difference and spend hours puzzling over why a function isn't returning the value they expect. Check the documentation if you have any doubt.

### Adding Elements With `concat`

The 	concat	 method (short for concatenate) is similar to `push`, but it doesn't mutate the caller; it returns a brand new array that contains all the elements from the original array followed by the elements passed as arguments:

```javascript
> array.concat(42, 'abc')
= [ 1, 4, 3, 10, 'a', null, 'xyz', 42, 'abc' ]

> array
= [ 1, 4, 3, 10, 'a', null, 'xyz' ]
```

> How do you know which methods mutate the caller and which ones don't? Most of the time, the documentation has this information; documentation for non-mutating methods may mention that they return a new array. However, don't count on it. The way to be sure is to use the method and examine the results.

### Removing Elements With `pop`

The inverse of `push` is `pop`. This method removes and returns the last element of the caller array:

```javascript
> array.pop()
= 'xyz'            // removed element value

> array
= [ 1, 4, 3, 10, 'a', null ]
```

`pop` mutates the caller.

### Removing Elements With `splice`

The `splice` method lets you remove one or more elements from an array, even those that aren't at the end of the array:

```javascript
> array.splice(3, 2)
[ 10, 'a' ]

> array
= [ 1, 4, 3, null ]
```

In this example, we delete two elements starting at index position 3. `splice` mutates the original array and returns a new array that contains the deleted elements.

`splice` can also add and insert elements, but we'll leave that for our JavaScript courses.

## Iteration Methods

> A callback is a function that you pass to another function as an argument. The called function subsequently invokes the callback function at certain times while it runs.

### `forEach`

Note that `forEach` returns `undefined`.

We saw this in the last chapter:

```javascript
let array = [1, 2, 3];
array.forEach(function (num) {
  console.log(num);
});
// returns undefined

// Outputs
1
2
3
```

```javascript
// or as an arrow function
let array = [1, 2, 3];
array.forEach(num => console.log(num));
```

### Transforming Arrays with `map`

```javascript
> let numbers = [1, 2, 3, 4]
> let squares = numbers.map(num => num * num);
> squares
= [ 1, 4, 9, 16 ]
```

### Filtering Arrays with `filter`

The `filter` method is another array iteration method. It returns a new array that includes all elements from the calling array for which the callback returns a truthy value. That's a mouthful. Some code should help clarify what `filter` does:

```javascript
> let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2]
> numbers.filter(num => num > 4)
= [ 5, 6, 7, 8, 9, 10 ]

> numbers
= [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1, 2 ]
```

### Building New Values from Arrays with `reduce`

The `reduce` method is perhaps one of the hardest to understand, yet it is also one of the most fundamental. You can build `forEach`, `map`, and `filter` with `reduce`, as well as a number of other iterative methods defined for Arrays.

`reduce` takes two arguments: a callback function and a value that initializes something called the accumulator. The callback function takes two arguments as well: an element from the array, the current value of the accumulator. It returns a value that will be used as the accumulator in the next invocation of the callback. That sounds more complicated than it is, so let's take a look at two simple uses of `reduce`:

```javascript
> let arr = [2, 3, 5, 7]
> arr.reduce((accumulator, element) => accumulator + element, 0)
= 17

> arr.reduce((accumulator, element) => accumulator * element, 1)
= 210
```

## Arrays Can Be Odd

* zero indexed
* max index is always one less than the size (length) of the array (because they're zero indexed)
* arrays are objects! use `Array.isArray()` for detecting arrays, not `typeof()`
* changing an array's length property to a smaller number will truncate elements beyond the new length
* changing an array's length property to a larger number expands the size of the array but does NOT initialize new elements, which leads to strange behavior:

```javascript
> let arr = []
> arr.length = 3
> arr             // returns [ <3 empty items> ]
> arr[0]          // returns undefined
> arr.filter(element => element === undefined) // returns []
> arr.forEach(element => console.log(element)) // no output, but returns undefined
> arr[1] = 3
> arr             // returns [ <1 empty item>, 3, <1 empty item> ]
> arr.length      // 3
> arr.forEach(element => console.log(element)) // outputs 3
> Object.keys(arr) // ['1']
```

You can create array "elements" with indexes that use negative or non-integer values, or even non-numeric values:

```javascript
> arr = [1, 2, 3]
= [ 1, 2, 3 ]

> arr[-3] = 4
= 4

> arr
= [ 1, 2, 3, '-3': 4 ]

> arr[3.1415] = 'pi'
= [ 1, 2, 3, '-3': 4, '3.1415': 'pi' ]

> arr["cat"] = 'Fluffy'
= 'Fluffy'

> arr
= [ 1, 2, 3, '-3': 4, '3.1415': 'pi', cat: 'Fluffy' ]
```

These "elements" aren't true elements; they are properties on the array object, which we'll discuss later. Only index values (0, 1, 2, 3, and so on) count toward the length of the array.

```javascript
> arr.length
= 3
```

Since arrays are objects, you can use the `Object.keys` method to return an array's keys -- it's index values -- as an array of strings. Even negative and non-integer indexes are included.

```javascript
> arr = [1, 2, 3]
> arr[-3] = 4
> arr[3.1415] = 'pi'
> arr["cat"] = 'Fluffy'
> arr
= [ 1, 2, 3, '-3': 4, '3.1415': 'pi', cat: 'Fluffy' ]

> Object.keys(arr)
= [ '0', '1', '2', '-3', '3.1415', 'cat' ]
```

One quirk of this method is that it treats unset values in arrays differently from those that merely have a value of `undefined`. Unset values are set to `undefined` by JavaScript as an after effect of calling another method, while explicit `undefined` are ones that are purposely set in an array.

```javascript
// unset values
let a = new Array(3);
let b = [];
b.length = 3;

// undefined
let c = [undefined, undefined, undefined]

a;                      // [ <3 empty items> ]
b;                      // [ <3 empty items> ]
c;                      // [ undefined, undefined, undefined ]

a[0] === undefined;     // true
b[0] === undefined;     // true
```

While the length property of Array includes undefined in the count regardless of how it got set, Object.keys only counts those that were set explicitly.

```javascript
a.length;                //  3
b.length;                //  3
c.length;                //  3

Object.keys(a).length;   //  0
Object.keys(b).length;   //  0
Object.keys(c).length;   //  3
```

It's worth spending some time and effort to memorize these behaviors.

## Array Equality

JavaScript treats two arrays (or objects) as equal when they are the same array (or object).

To determine whether two different arrays contain the same elements, you'd have to compare them one by one, like so:

```javascript
function arraysEqual(arr1, arr2) {
  if (arr1.length !== arr2.length) return false;

  for (let i = 0; i < arr1.length; i += 1) {
    if (arr1[i] !== arr2[i]) {
      return false;
    }
  }

  return true;
}

console.log(arraysEqual([1, 2, 3], [1, 2, 3])); // logs true
console.log(arraysEqual([1, 2, 3], [4, 5, 6])); // logs false
console.log(arraysEqual([1, 2, 3], [1, 2, 3, 4])); // logs false
```

Note that this doesn't work unless all contents of the arrays are primitives.

## Other Array Methods

* `includes`: check whether or not an array includes a given element
  * `includes` uses `===` for comparison, so it can't verify nested arrays or objects
* `sort`
* `slice`: extracts and returns a portion of the array
  * with no arguments, its returns a copy of the entire array; this is especially useful to pair with desctructive methods/functions to preserve the original array
* `reverse`

## Exercises

1. In the following code, what are the final `length` values for `array1`, `array2`, `array3`, `array4`, and `array5`?

```javascript
let array1 = [1, 2, undefined, 4];

let array2 = [1];
array2.length = 5;

let array3 = [];
array3[-1] = [1];

let array4 = [1, 2, 3, 4, 5];
array4.length = 3;

let array5 = [];
array5[100] = 3;
```

### Solution

| array  | length |
|--------|--------|
| array1 | 4      |
| array2 | 5      |
| array3 | 0      |
| array4 | 3      |
| array5 | 100    |

#### Adjustments based on provided solution

Remember that arrays are zero-indexed! Assigning an element to an empty `array5` at **index** `100` means its length is **101**, not 100.

---

2. Log all of the even values from myArray to the console.

```javascript
let myArray = [1, 3, 6, 11, 4, 2,
               4, 9, 17, 16, 0];
```

### Solution

```javascript
let myArray = [1, 3, 6, 11, 4, 2,
               4, 9, 17, 16, 0];

myArray.forEach(function (number) {
  if (number % 2 === 0) {
    console.log(number);
  }
});
```

---

3. Let's make the problem a little harder. In this problem, we're again interested in even numbers, but this time the numbers are in nested arrays in a single outer array.

```javascript
let myArray = [
  [1, 3, 6, 11],
  [4, 2, 4],
  [9, 17, 16, 0],
];
```

### Solution

```javascript
let myArray = [
  [1, 3, 6, 11],
  [4, 2, 4],
  [9, 17, 16, 0],
];

myArray.forEach(function (array) {
  array.forEach(function (number) {
    if (number % 2 === 0) {
      console.log(number);
    }
  });
});
```

---

4. Let's try another variation on the even-numbers theme.

We'll return to the simpler one-dimensional array. In this problem, we want to use the `map` function to create a new array that contains one element for each element in the original array. If the element is an even value, then the corresponding element in the new array should contain the string `'even'`; otherwise, the element in the new array should contain `'odd'`.

**Example**

```javascript
let myArray = [
  1, 3, 6, 11,
  4, 2, 4, 9,
  17, 16, 0,
];
// Desired result:
//  [
//    'odd', 'odd', 'even', 'odd',
//    'even', 'even', 'even', 'odd',
//    'odd', even', 'even',
//  ]
```

If you have trouble using `map` to accomplish this, try it using a regular `for` loop instead.

### Solution

```javascript
let myArray = [
  1, 3, 6, 11,
  4, 2, 4, 9,
  17, 16, 0,
];

myArray.map(function(number) {
  if (number % 2 === 0) {
    return 'even';
  } else {
    return 'odd';
  }
});

// this can be shortened using the ternary operator
myArray.map(function(number) {
  return (number % 2 === 0) ? 'even' : 'odd';
});

// or further with ternary operator and arrow function
myArray.map(number => (number % 2 === 0) ? 'even' : 'odd');
```

---

5. Use the `filter` method to implement a function that returns a new array with all of the integers from the input array. It should ignore all non-integer values from the input.

**Example**

```javascript
let array = [1, 'a', '1', 3, NaN, 3.1415, -4, null, false];
let newArray = removeNonInteger(array);
console.log(newArray); // => [1, 3, -4]
```

> You can use `Number.isInteger(value)` to determine whether a numeric `value` is an integer. It returns `true` if the value is an integer, `false` otherwise.

### Solution

```javascript
function removeNonInteger(array) {
  return array.filter(function(element) {
    return Number.isInteger(element);
  });
}

let array = [1, 'a', '1', 3, NaN, 3.1415, -4, null, false];
let newArray = removeNonInteger(array);
console.log(newArray); // => [1, 3, -4]
```

---

6. Use `map` and `filter` to first determine the lengths of all the elements in an array of string values, then discard the even values (keep the odd values).

```javascript
let arr = ['a', 'abcd', 'abcde', 'abc', 'ab'];
console.log(oddLengths(arr)); // => [1, 5, 3]
```

> Note that it is possible to solve this problem without using `map`. However, our intent is to show how you can combine multiple functions to achieve a desired result.

> Hint: Your first step should be to create an array of the lengths, e.g., [1, 4, 5, 3, 2].

### Solution

```javascript
function oddLengths(array) {
  let stringLengths = array.map(string => string.length);
  return stringLengths.filter(length => length % 2 !== 0);
}

let arr = ['a', 'abcd', 'abcde', 'abc', 'ab'];
console.log(oddLengths(arr)); // => [1, 5, 3]
```

---

7. Use `reduce` to compute the sum of the squares of all of the numbers in an array:

```javascript
let numbers = [3, 5, 7];
console.log(sumOfSquares(numbers)); // => 83
```

Note that `83` is `3*3 + 5*5 + 7*7`.

### Solution

```javascript
function sumOfSquares(numbers) {
  return numbers.reduce(function (result, number) {
    return result + (number * number);
  }, 0);
}

let numbers = [3, 5, 7];
console.log(sumOfSquares(numbers)); // => 83
```

---

8. **This problem is more challenging than most in this book.** Don't worry if you can't solve it on your own.

Write a function similar to the `oddLengths` function from Exercise 6, but don't use `map` or `filter`. Instead, try to use the `reduce` method.

```javascript
let arr = ['a', 'abcd', 'abcde', 'abc', 'ab'];
console.log(oddLengths(arr)); // => [1, 5, 3]
```

> Hint: The accumulator in this problem must be an array.

### Solution

```javascript
function oddLengths(strings) {
  return strings.reduce(function (result, string) {
    if (string.length % 2 !== 0) {
      return result.concat(string.length);
    } else {
      return result;
    }
  }, []);
}

let arr = ['a', 'abcd', 'abcde', 'abc', 'ab'];
console.log(oddLengths(arr)); // => [1, 5, 3]
```

---

9. Without using a `for`, `while`, or `do/while` loop, write some code that checks whether the number `3` appears inside these arrays:

```javascript
> let numbers1 = [1, 3, 5, 7, 9, 11];
> let numbers2 = [];
> let numbers3 = [2, 4, 6, 8];
```

Return `true` or `false` depending on each result.

### Solution

```javascript
function hasThree(array) {
  let result = false;
  array.forEach(function(number) {
    if (number === 3) result = true;
  });

  return result;
}

let numbers1 = [1, 3, 5, 7, 9, 11];
let numbers2 = [];
let numbers3 = [2, 4, 6, 8];

hasThree(numbers1); // => true
hasThree(numbers2); // => false
hasThree(numbers3); // => false
```

#### Adjustments based on provided solution

I way overthought this. Just use `Array.prototype.includes()`:

```javascript
numbers1.includes(3);
numbers2.includes(3);
numbers3.includes(3);
```

---

10. Write some code to extract the word `'mem'` from the following nested array:

```javascript
> let arr = [["test", "hello", "world"], ["example", 6, "mem", null], [4, 8, 12]];
```

### Solution

```javascript
let arr = [["test", "hello", "world"], ["example", 6, "mem", null], [4, 8, 12]];

arr[1][2];
```
