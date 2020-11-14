
# Objects - 10/20/2020

Object Oriented Programming is a paradigm that models problems as **objects** with **behavior** (they perform actions) and **state** (they have characteristics that distinguish them from other objects.) JavaScript supports this paradigm, butfor this book we're only going to focus on objects as a complex data structure, similar to arrays.

JavaScript objects store a collection of **key-value pairs**, similar to dictionaries, associative arrays, maps, or hashes from other programming languages. An objects keys are strings; its values can be any type.

```javascript
let person = {
  name: 'Jane',
  age: 37,
  hobbies: ['photography', 'genealogy']
}
```

A specific value can be accessed two ways:
1. dot notation: `person.name`
2. bracket notation: `person['name']`

If you have a variable that contains a key's name, you must use it with bracket notation:

```javascript
let key = 'name';
person[key];
```

You can remove a key-value pair with the `delete` keyword, which will return true unless it's not able to delete the property:

```javascript
> delete person.age
= true
```

> Key-value pairs are also called object **properties** in JavaScript. We can also use "property" to refer to the key name; the meaning is typically clear from context. For instance, we can talk about the `name` property for the `person` object without mentioning the value.

Note that objects declared with `const` are similar to `const` arrays; you can't change what object a `const` references, but you can modify its properties:

```javascript
> const MyObj = { foo: "bar", qux: "xyz" }
> MyObj.qux = "hey there"
> MyObj
= { foo: 'bar', qux: 'hey there' }

> MyObj = {} // Uncaught TypeError: Assignment to constant variable.
```

You can use `Object.freeze` with objects to freeze the property values of an object, just like you can with arrays:

```javascript
> const MyObj = Object.freeze({ foo: "bar", qux: "xyz" })
> MyObj.qux = "hey there"
> MyObj
= { foo: 'bar', qux: 'xyz' }
```

As with arrays, `Object.freeze` only works one level deep in the object. If your object contains nested arrays or other objects, the values inside them can still be changed unless they are also frozen.

## Objects vs. Primitives

Recall that JavaScript has two categories of data types: primitives and objects. The primitive types are strings, numbers, booleans, `null`, and `undefined`. Objects include, but aren't limited to:

* Simple Objects
* Arrays
* Date Objects
* Functions

Objects are complex values composed of primitive values or other objects, e.g. arrays (which are objects) have a `length` property with a number value - a primitive value. Note that we can change parts of objects, so they are mutable.

## Prototypes

An interesting and handy feature of JavaScript objects is that they can **inherit** from other objects. When an object `a` inherits from object `b`, we say that `b` is the **prototype** of `a`. The practical implication is that `a` now has access to properties defined on `b` even though it doesn't define those properties itself.

> Object prototypes and inheritance have a great deal of relevance in Object Oriented Programming (OOP). We discuss these concepts here since it is relevant to our discussion of iterating over object properties in the next section. All you need to know right now is that inheritance lets one object use the properties defined by another object and that prototypes implement inheritance in JavaScript.

The static method `Object.create` provides a simple way to create a new object that inherits from an existing object:

```javascript
let bob = { name: 'Bob', age: 22 };
let studentBob = Object.create(bob);
studentBob.year = 'Senior';

console.log(studentBob.name); // => 'Bob'
```

`Object.create` creates a new object and sets the prototype for that object to the object passed in as an argument. Our example creates a new object named `studentBob` that uses `bob` as its prototype. That is, it creates an inheritance relationship from `studentBob`, the **child** object, to `bob`, the **parent** object.

Since `studentBob` inherits from `bob`, we can use the `name` property even though `studentBob` doesn't explicitly define it. `Object.create` is one way to use inheritance in JavaScript. We learn more about it and other techniques in our JavaScript courses.

## Iteration

### `for/in` loop

The `for/in` loop behaves similarly to an ordinary `for` loop. The syntax and semantics are easier to understand since you don't need an initializer, ending condition, or increment clause. Instead, the loop iterates over all the keys in the object. In each iteration, it assigns the key to a variable which you then use to access the object's values. As always, seeing a concept in action is helpful:

```javascript
let person = {
  name: 'Bob',
  age: 30,
  height: '6 ft'
};

for (let prop in person) {
  console.log(person[prop]);
}

// Bob
// 30
// 6 ft
```

One feature—or downside, depending on how you look at it—of `for/in` is that it iterates over the properties of an object's prototypes as well:

```javascript
let obj1 = { a: 1, b: 2 }
let obj2 = Object.create(obj1);
obj2.c = 3;
obj2.d = 4;

for (let prop in obj2) {
  console.log(obj2[prop]);
}

// 1
// 2
// 3
// 4
```

This behavior is undesirable when you want to limit iteration to an object's **own properties**, i.e., properties it defined for itself, not properties it inherited. We can use the `hasOwnProperty` method to get around that problem. It takes the name of a property and returns `true` if it is the name of one of the calling object's own properties, `false` if it is not.

```javascript
let obj1 = { a: 1, b: 2 }
let obj2 = Object.create(obj1);
obj2.c = 3;
obj2.d = 4;

for (let prop in obj2) {
  if (obj2.hasOwnProperty(prop)) {
    console.log(obj2[prop]);
  }
}

// 3
// 4
```

### Object.keys

The `Object.keys` static method returns an object's keys as an array. You can iterate over that array using any technique that works for arrays. For instance:

```javascript
let person = {
  name: 'Bob',
  age: 30,
  height: '6 ft'
};

let personKeys = Object.keys(person); // returns ['name', 'age', 'height']

personKeys.forEach(key => console.log(person[key]));
// Bob
// 30
// 6 ft
```

Note that `Object.keys` returns the object's own keys: it does not include any keys from the prototype objects.

### Order of Object Properties

Don't assume anything about the sequence that JavaScript uses to iterate over an object's keys. Some engines are predictable, but the JavaScript standard doesn't specify an order, so some engines take advantage of that to provide improved performance. Thus, you can't depend on the order of iteration.

## Common Operations

### Object.values

This static method extracts the values from every own property in an object to an array:

```javascript
let person = { name: 'Bob', age: 30, height: '6ft' };
let personValues = Object.values(person);
console.log(personValues); // logs [ 'Bob', 30, '6ft' ]
```

Be careful: remember that you can't predict the order of the values in the returned array.

### Object.entries

While `Object.keys` and `Object.values` return the keys and values of an object, respectively, the `Object.entries` static method returns an array of nested arrays. Each nested array has two elements: one of the object's keys and its corresponding value:

```javascript
let person = { name: 'Bob', age: 30, height: '6ft' };
console.log(Object.entries(person));
// logs [[ 'name', 'Bob' ], [ 'age', 30 ], [ 'height', '6ft' ]]
```

### Object.assign

You may sometimes want to merge two or more objects, i.e., combine the key-value pairs into a single object. The `Object.assign` static method provides this functionality. Note that:

* It does so by mutating the first argument (and not the second/rest).
* To avoid unwanted mutation, provide a new object as the first argument.
* You can provide more than two arguments.

```javascript
> let objA = { a: 'foo' }
= undefined

> let objB = { b: 'bar' }
= undefined

> Object.assign(objA, objB)
= { a: 'foo', b: 'bar' }

// mutated
> objA
= { a: 'foo', b: 'bar' }

// not mutated
> objB
= { b: 'bar' }

// provide an empty object as the first argument to avoid mutating objA or objB:
> objA = { a: 'foo' }
= undefined

> objB = { b: 'bar' }
= undefined

> Object.assign({}, objA, objB)
= { a: 'foo', b: 'bar' }

> objA
= { a: 'foo' }

> objB
= { b: 'bar' }
```

## Exercises

1. Given the following code, how can you access the name of the person?

```javascript
let person = {
  name:       'Bob',
  occupation: 'web developer',
  hobbies:    'painting',
};
```

### Solution

`person.name` or `person['name']`.

---

Which of the following values are valid keys for an object?

* `1`
* `'1'`
* `undefined`
* `'hello world'`
* `true`
* `'true'`

### Solution

Keys must be strings:

| value           | valid? | reason                  |
|-----------------|--------|-------------------------|
| `1`             | no     | number, not a string    |
| `'1'`           | yes    |                         |
| `undefined`     | no     | undefined, not a string |
| `'hello world'` | yes    |                         |
| `true`          | no     | boolean, not a string   |
| `'true'`        | yes    |                         |

#### Adjustments based on provided solution

Solution says all values are valid keys because they will be coerced to strings. I'll need to experiment with this.

---

3. Use object literal syntax (e.g., `{ key: value, ... }` notation) to create an object that behaves as an array in a `for` statement. The object should contain at least 3 elements. You should place your code between the braces in the `let` statement:

```javascript
let myArray = {
};

for (let i = 0; i < myArray.length; i += 1) {
  console.log(myArray[i]);
}
```

> Hint: Arrays use positive integers starting with `0` as indexes. An array also must have a `length` property.

### Solution

```javascript
let myArray = {
  0: 'a',
  1: 'b',
  2: 'c',
  length: 3
};

for (let i = 0; i < myArray.length; i += 1) {
  console.log(myArray[i]);
}
```

---

4. Create an array from the keys of the object `obj` below, with all of the keys converted to uppercase. Your implementation must not mutate `obj`.

```javascript
let obj = {
  b: 2,
  a: 1,
  c: 3,
};
```

The order of the array does not matter.

### Solution

```javascript
let obj = {
  b: 2,
  a: 1,
  c: 3,
};

let keys = Object.keys(obj);
keys = keys.map(string => string.toUpperCase());
```

---

5. Create a new object named `myObj` that uses `myProtoObj` as its prototype.

```javascript
let myProtoObj = {
  foo: 1,
  bar: 2,
};
```

### Solution

```javascript
let myProtoObj = {
  foo: 1,
  bar: 2,
};

let myObj = Object.create(myProtoObj);
```

---

6. Add a `qux` property with value `3` to the `myObj` object we created in the previous exercise. Now, examine the following code snippets:

**Snippet 1**

```javascript
Object.keys(myObj).forEach(function(key) {
  console.log(key);
});
```

**Snippet 2**

```javascript
for (let key in myObj) {
  console.log(key);
}
```

Without running this code, can you determine whether these two snippets produce the same output? Why?

### Solution

```javascript
let myProtoObj = {
  foo: 1,
  bar: 2,
};

let myObj = Object.create(myProtoObj);

// add qux property with value of 3:
myObj.qux = 3;
```

The two snippets will not produce the same output because `Object.keys(myObj)` excludes prototype properties, but `for (let key in myObj)` includes prototype properties.

---

7. Create a function that creates and returns a copy of an object. The function takes two arguments: the object to copy and an array of the keys that you want to copy. You can omit the array of keys, in which case you should copy all the keys of the object.

Here are some examples for your reference:

```javascript
let objToCopy = {
  foo: 1,
  bar: 2,
};

let newObj = copyObj(objToCopy);
console.log(newObj.foo);    // => 1
console.log(newObj.bar);    // => 2

let newObj2 = copyObj(objToCopy, [ 'foo' ]);
console.log(newObj2.foo);   // => 1
console.log(newObj2.bar);   // => undefined
```

### Solution

```javascript
function copyObj(originalObj, keysToCopy = []) {
  let copyObj = {};
  if (keysToCopy.length === 0) return Object.assign(copyObj, originalObj);

  keysToCopy.forEach(key => copyObj[key] = originalObj[key]);
  return copyObj;
}

let objToCopy = {
  foo: 1,
  bar: 2,
};

let newObj = copyObj(objToCopy);
console.log(newObj.foo);    // => 1
console.log(newObj.bar);    // => 2

let newObj2 = copyObj(objToCopy, [ 'foo' ]);
console.log(newObj2.foo);   // => 1
console.log(newObj2.bar);   // => undefined
```

---

8. What does the following program log to the console? Why?

```javascript
let foo = {
  a: 'hello',
  b: 'world',
};

let qux = 'hello';

function bar(argument1, argument2) {
  argument1.a = 'hi';
  argument2 = 'hi';
}

bar(foo, qux);

console.log(foo.a);
console.log(qux);
```

### Solution

This program logs:

```
hi
hello
```

Because objects are mutable, line 9 mutates the value of the key `a` from `hello` to `hi`.

Because primitives, including strings, are not mutable, line 10 points the `argument2` variable to a new string (`hi`), while leaving the `qux` variable pointing at the `hello` string.
