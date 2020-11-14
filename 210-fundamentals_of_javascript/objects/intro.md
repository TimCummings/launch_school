
# Introduction to Objects - 11/2/2020

JavaScript is an *object-oriented* language: it uses objects to organize code and data. Typically, data values and the functions that operate on them are part of the same object.

## Standard Built-in Objects

You've already seen several of the built-in objects that JavaScript provides, e.g. `String`, `Array`, `Object`, `Math`, `Date`. When you apply `toUpperCase` to a string, you're calling the `toUpperCase` method on a built-in `String` object. Notice that some of these built-in objects share names with primitive data dates, e.g. `String` and `Number`. Theoretically, we can't call methods on primitive values, only on objects. So how does this work?

JavaScript *temporarily* coerces primitives to their object counterpart:

```javascript
let a = 'hi';                          // create a primtive string with the value "hi"
typeof a;                              // "string" (primitive value)

let stringObject = new String('hi');   // create a string object
typeof stringObject;                   // "object"

a.toUpperCase();                       // "HI"
stringObject.toUpperCase();            // "HI"

typeof a;                              // "string" - coercion is only temporary
typeof stringObject;                   // "object"
```

This holds true for other primitive types (except `null` and `undefined`, which don't have corresponding object types):

```javascript
42.5639.toFixed(2);   // "42.56"
true.toString();      // "true"
```

## Creating Custom Objects

You can create your own custom objects three ways:

1. object literal notation: `{ a: 1, b: 2 }`
2. object constructor function: `new String('foo');`
3. the `Object.create` method

We'll discuss #s 2 and 3 in the Object Oriented JavaScript course. Here's a more detailed example for #1:

```javascript
let colors = {
  red: '#f00',
  orange: '#ff0',
};

typeof colors;   // "object"
colors.red;      // "#f00"
colors.orange;   // "#ff0"
```

## Properties

Objects are containers for two things: data and behavior. The data consists of named items with values; these values represent the **attributes** of the object. The associations between a name/key and a value are called **properties**.

```javascript
let animal = 'turtle';
animal.length;   // 6

let colors = {
  red: '#f00',
  orange: '#ff0',
};

colors.red;     // "#f00"
'blue'.length;  // 4 - works with primitives too

let count = [0, 1, 2, 3, 4];
count.length = 2;

let colors = {
  red: '#f00',
  orange: '#ff0',
};

colors.blue = '#00f';
```

## Methods

Functions define the behavior of an object; when they are part of an object, we call them **methods**. To call an objects method, access it as if it was a property (which it is!) and call it by appending parentheses, just like a function:

```javascript
(5.234).toString();    // "5.234"
'pizza'.match(/z/);    // [ "z", index: 2, input: "pizza" ]
Math.ceil(8.675309);   // 9
Date.now();            // 1467918983610
```

## Style

As a matter of style with object literal notation, custom objects that occupy more than one line always use a trailing comma, even for the last property or method:

```javascript
let myObj = {
  prop1: 'sample data',
  method1: function () {},
  prop2: 'sample data',
}

// or with method as last:

let myObj = {
  prop1: 'sample data',
  prop2: 'sample data',
  method1: function () {},
}
```

This has two major benefits:

1. You don't have to worry about removing or adding trailing commas if you re-order your object's properties and methods.
2. Adding a property shows as changing only a single line with `git diff` instead of two.

### Compact Method Notation

ES6 introduced **compact method syntax** that allows you to omit the colon `:` and word `function`:

```javascript
// this can be rewritten...
let myObj = {
  foo: function (who) {
    console.log(`hello ${who}`);
  },

  bar: function (x, y) {
    return x + y;
  },
};

// as this:
let myObj = {
  foo(who) {
    console.log(`hello ${who}`);
  },

  bar(x, y) {
    return x + y;
  },
};
```

We recommend that you use this compact method syntax.

### Arrow Functions and Methods

It's possible to define methods as arrow functions, but it's a bad idea; don't do it. We'll explore why later. Feel free to use them in the *body* of a method, just not to define a method itself.

### Capitalization

The differences between capitalizing or not capitalizing the names of types, values, and objects are poorly defined and often ignored (we even slip sometimes.) Don't stress over these suggestions; we won't force you to use the "right" ones, but try to be consistent. Here are some suggestions:

* Use lowercase names when speaking of primitive types (e.g. `string`, `number`, `boolean`). Use Uppercase names when speaking of the object forms of primitive types (e.g. `String`, `Number`, `Boolean`.)
* Use lowercase when referring to objects in general. Use uppercase when referring to methods and properties from a class, e.g. `Object`, `Array`.
* Use uppercase for OO functions and prototype objects (we'll discuss this further in a later course): e.g. use `new Date()`, NOT `new date()`.
