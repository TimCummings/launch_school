
# Arrays - 10/30/2020

* Arrays are the basic collection type in JavaScript.
* Arrays are indexed by a zero-based, non-negative integer value.
* Arrays can be created with literal syntax or the `Array` constructor (this is much less common):

```javascript
[]   // an empty array
[0, 1, 2,] // an array holding three values
[42, 'hello', false, [3, 5], [true, 'hello']]   // arrays can contain any other object

let count = new Array(1, 2, 3);   // array constructor
```

The main interactions with arrays are:

* iterating through the array and performing an action on each value
* accessing and manipulating specific elements of the array

## Iterating Through an Array

A `for` loop is the most basic array iteration technique:

```javascript
let count = [1, 2, 3];
count.length;   // 3

for (let index = 0; index < count.length; index += 1) {
  console.log(count[index]);
}

// logs:
// 1
// 2
// 3
```

> Earlier, we learned that bracket notation for accessing characters in a string is an *operator*, not a method. This holds true for Arrays and Objects too.

## Accessing, Modifying, and Detecting Values

You can access elements in an array and add values to an array at a specified index (zero-based) with bracket notation:

```javascript
let count = [1, 2, 3];
count[3] = 4;
count;        // [1, 2, 3, 4]
count.length; // 4

count[5] = 5;
count[9] = 9;
count[9];     // 9
count.length; // 10
```

* The `length` property returns a value one greater than its highest index.
* You can change an array's length by assigning a new value to the `length` property.
  * If the new length is shorter, elements at higher indexes will be discarded.
  * If the new length is longer, empty elements will be added.
* For indexes that aren't explicitly assigned values, JavaScripts designates them empty and accessing them returns `undefined`:

```javascript
count;        // [1, 2, 3, 4, <1 empty item>, 5, <3 empty items>, 9]
count[4];     // undefined
```

## Arrays are Objects

JavaScript Arrays are really Objects:

```javascript
typeof [];   // 'object'
```

If you need to determine whether a value is an Array, use `Array.isArray()`:

```javascript
Array.isArray([]);        // true
Array.isArray('array');   // false
```
