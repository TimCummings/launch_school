
# Array Operations: push, pop, shift, and unshift

In this practice problem set, we ask you to build several Array methods on your own; these methods all emulate Array methods that are built-in to JavaScript. These problems expose you to the most important Array methods and how they work by having you build them yourself. Doing this will help make you feel more comfortable working with arrays.

Each problem provides sample output. Read the problem text and output carefully. Observe whether the array argument is mutated or the function returns a new array. After each problem, we will ask you to read the documentation for the built-in method.

You should get to know these methods well. You will need them often; you don't want to implement them yourself every time you need them. Note that some of the built-in methods are more complex than what we ask you to do, and may have different behavior as well.

You can find [a list of all built-in Array methods here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array). Don't try to memorize them; just remember that this is the place to look for Array methods when you need them.

JavaScript has an `Array` **global object**; this object has something called a **prototype object**. It is the prototype object that defines the methods for Arrays; all JavaScript arrays inherit from the prototype object. We will discuss this in more detail later. For now, just know that you can use these methods with arrays.

---

1. Write a function named `push` that accepts two arguments: an Array and any other value. The function should append the second argument to the end of the Array, and return the new length of the Array.

```javascript
let count = [0, 1, 2];
push(count, 3);         // 4
count;                  // [ 0, 1, 2, 3 ]
```

### Solution

```javascript
function push(array, element) {
  array[array.length] = element;
  return array.length;
}
```

---

2. Write a function named `pop` that accepts one argument: an Array. The function should remove the last element from the array and return it.

```javascript
let count = [1, 2, 3];
pop(count);             // 3
count;                  // [ 1, 2 ]
```

### Solution

```javascript
function pop(array) {
  let lastElement = array[array.length - 1];
  array.length -= 1;
  return lastElement;
}
```

#### Adjustments based on provided solution

Empty arrays must be handled:

```javascript
function pop(array) {
  if (array.length === 0) return undefined;

  let lastElement = array[array.length - 1];
  array.length -= 1;
  return lastElement;
}
```

---

3. Write a function named `unshift` that accepts two arguments: an Array and a value. The function should insert the value at the beginning of the Array, and return the new `length` of the array. You will need a `for` loop for this problem.

```javascript
let count = [1, 2, 3];
unshift(count, 0);      // 4
count;                  // [ 0, 1, 2, 3 ]
```

### Solution

```javascript
function unshift(array, value) {
  for (let index = array.length; index >= 0; index -= 1) {
    array[index] = array[index - 1];
  }

  array[0] = value;
  return array.length;
}
```

---

4. Write a function named `shift` that accepts one argument: an Array. The function should remove the first value from the beginning of the Array and return it.

```javascript
let count = [1, 2, 3];
shift(count);           // 1
count;                  // [ 2, 3 ]
```

### Solution

```javascript
function shift(array) {
  if (array.length === 0) return undefined;

  let firstElement = array[0];
  for (let index = 0; index < array.length; index += 1) {
    array[index] = array[index + 1];
  }
  array.length -= 1;
  return firstElement;
}
```

#### Adjustments based on provided solution

The `for` loops termination can be one element earlier (since the last element has already been copied):

```javascript
function shift(array) {
  if (array.length === 0) return undefined;

  let firstElement = array[0];
  for (let index = 0; index < array.length - 1; index += 1) {
    array[index] = array[index + 1];
  }
  array.length -= 1;
  return firstElement;
}
```
