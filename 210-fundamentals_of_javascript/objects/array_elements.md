
# Arrays: What is an Element? - 11/2/2020

## Array Keys

When is an array empty? There is some ambiguity here:

```javascript
let arr = [2, 4, 6];
arr[-3] = 5;
arr['foo'] = 'a';
console.log(arr);                // [ 2, 4, 6, '-3': 5, foo: 'a' ]
console.log(arr.length);          // 3
console.log(Object.keys(arr));   // [ '0', '1', '2', '-3', 'foo' ]
arr.map(x => x + 1);             // [ 3, 5, 7 ]
```

Notice that `map` ignores the non-element values; this is the case for all built-in Array methods.

```javascript
let arr = [];
arr[-3] = 5;
arr['foo'] = 'a';

// Is arr empty?
console.log(arr.length);          // 0: Yes
console.log(Objects.keys(arr));   // [ "-3", "foo" ]: No
```

There is no right answer; it is for you to determine based on the needs of your program.

## Sparse Arrays

JavaScript uses **sparse arrays**: the number of elements in an array is not necessarily equal to the array's length. There can be gaps, such as occurs when manually increasing the length property. Note that such an empty element may evaluate to `undefined` when accessed by its index, it is an *empty* element; this is *different* than an element with a value of `undefined`:

```javascript
let array = [2, 4, 6];
array.length = 5;
array[4] = undefined;
console.log(array);               // [ 2, 4, 6, <1 empty item>, undefined ]
console.log(array.length);        // 5
console.log(Object.keys(array));   // [ '0', '1', '2', '4' ]
```

This leads to further ambiguity about when an array is empty, but the answer is still the same - it depends on the needs of your program:

```javascript
let array = [];
array.length = 3;

// Is array empty?
console.log(array.length);         // 3: no
console.log(Object.keys(array));   // []: yes
```
