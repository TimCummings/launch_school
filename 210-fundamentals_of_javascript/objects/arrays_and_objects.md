
# Arrays and Objects - 11/2/2020

JavaScript uses both arrays and objects as data structures to represent compound data. When should you use one over the other?

* If your data is like a list or if you need to maintain a specific order ,use an array.
* If your data is more like an entity with many parts or if you need to access values based on their names, use an object.

## Arrays are Objects

```javascript
let a = ['hello', 'world'];

console.log(typeof a);         // "object"
console.log(a['1']);           // "world", object's bracket notation works to access an array value by index
console.log(Object.keys(a));   // [ "0", "1" ]: the keys of the object!

// line 1 is equivalent (as far as console output is concerned) with:
let a = {
  '0': 'hello';
  '1': 'world';
};

console.log(typeof a);         // "object"
console.log(a['1']);           // "world"
console.log(Object.keys(a));   // [ "0", "1" ]
```

> While the array and object in the previous snippet are equivalent in terms of console output, there are some nuances between the two. See below!

## Arrays and the Length Property

JavaScript's built-in Array methods take the value of the `length` property into consideration while performing their operations. Some key points from the [ECMAScript documentation](http://www.ecma-international.org/ecma-262/5.1/#sec-15.4):

* The value of `length` is always a non-negative integer less than `2^32` (~4.2 billion.)
* The value of the `length` property is one greater than the largest array index (array indexes are all properties with names representing non-negative integer values.)
* You can set the value of `length` explicitly.

```javascript
let myArray = [];
myArray['foo'] = 'bar';
myArray[0] = 'baz';
myArray[1] = 'qux';

console.log(myArray);          // logs [ "baz", "qux", foo: "bar" ]
myArray.length;                // returns 2 since `foo: "bar"` is not an element
myArray.indexOf('bar');        // returns -1 since 'bar' isn't in an element

myArray[-1] = 'hello';
myArray[-2] = 'world';
myArray.length;                // returns 2
myArray.indexOf('hello');      // returns -1 since 'hello' is not in an element
myArray.indexOf('world');      // returns -1 since 'world' is not an element

console.log(myArray);          // logs [ "baz", "qux", foo: "bar", "-1": "hello", "-2": "world" ]
Object.keys(myArray).length;   // returns 5 (there are 5 keys at this point)
myArray.length;                // returns 2 (only 2 of the 5 keys ar indexes)
```

Notice from the above snippet:

* A **property name** is an **index** when it is a **non-negative integer**.
* Values that have been assigned to index properties are called **elements** of the array. All other property names and values are *not* considered elements of the array.
* `Array.prototype.indexOf()` returns `-1` if the value it is passed is not an element, even if it's the value of a non-index property.
* Logging an array logs all properties; index properties display on their value; non-index properties display their name and value.
* `Array.length` only counts elements (index properties.)
* To log all properties, including non-index properties, use `Object.keys(array).length`.

## Using Object Operations with Arrays

While you *can* use object operations such as `in` and `delete` with arrays, you generally shouldn't. You want to make your intentions clearer with more idiomatic approaches, and sometimes the results can be unexpected.

You can use the `in` operator to tell if an Object contains a certain key:

```javascript
let object = { a: 1, b: 2 };
'a' in object;     // true
0 in [];           // false
0 in ['a'];        // true: index 0 is present
```

A more idiomatic solution with arrays is to compare the desired index to the length of the array:

```javascript
let letters = ['a', 'b', 'c', 'd'];
2 , letters.length;     // true
```

To remove elements from an array, you *can* use `delete`, but you should use `splice()` instead.

## Arithmetic and Comparison Operators

Just as wit harrays, arithmetic and comparison operators are generally not useful with objects and often produce unexpected results. When one operand is an object and the other is not, JavaScript usually coerces the object to a string:

```javascript
[] + {};                   // becomes '' + '[object Object]' | '[object Object]'
[] - {};                   // becomes '' - '[object Object]' | 0 - NaN | NaN
'[object Object]' == {};   // true
'' == {};                  // false
false == {};               // false
0 == {};                   // false
```

Attempting to use an object literal in some contexts (especially at the start of a line) sometimes results in JavaScript interpreting it as a block instead:

```javascript
{} + [];                   // becomes +[] | 0
{}[0];                     // [0]
{ foo: 'bar' }['foo'];     // [ "foo" ]
{} == '[object Object]';   // SyntaxError: Unexpected token ==
```

Like arrays, objects are considered equal only if they're the same object.
