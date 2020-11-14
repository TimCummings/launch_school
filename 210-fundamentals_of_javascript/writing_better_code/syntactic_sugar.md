
# Syntactic Sugar - 11/9/2020

ES6 introduced several shorthand notations that are now experiencing wide use in new code. You don't have to memorize or use all of these (although we encourage you to use them) but you need to be aware of them and be able to recognize their use in the code you'll encounter and understand what they do.

## Concise Property Initializers

When initializing an object property where the name matches the variable providing the value, e.g.

```javascript
function xyzzy(foo, bar, qux) {
  return {
    foo: foo,
    bar: bar,
    qux: qux,
  }
}
```

you can just list the property name and JavaScript will look for a variable with the same name to use as the initial value (and you can mix this with standard syntax):

```javascript
function xyzzy(foo, bar, qux) {
  return {
    foo,
    bar,
    qux,   // or `answer: qux,` - you can mix concise syntax with regular syntax
  }
}
```

## Concise Methods

When defining a method on an object, e.g.:

```javascript
let obj = {
  foo: function() {
    // do something
  },

  bar: function(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}
```

you may omit the `:` and `function`:

```javascript
let obj = {
  foo() {
    // do something
  },

  bar(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}
```

You *can* mix and match concise and regular syntax, but you should be consistent, at least within a single object.

## Object Destructuring

**Destructuring** is a shorthand syntax that lets you perform multiple assignments in a single expression. Consider:

```javascript
let obj = {
  foo: "foo",
  bar: "bar",
  qux: 42,
};

let foo = obj.foo;
let bar = obj.bar;
let qux = obj.qux;
```

We can replace the last 3 lines with destructuring:

```javascript
let { foo, bar, qux } = obj;
console.log(bar);   // "bar"
```

The order of the variable names is not important; the variables are match to property values of the same name. The following snippet results in the same assignments as the previous snippet:

```javascript
let { qux, foo, bar } = obj;
console.log(bar);   // "bar"
```

You may omit names or provide different variable names:

```javascript
let { qux: myQux, bar } = obj;
console.log(myQux);   // 42
```

You can also destructure argument properties to function arguments:

```javascript
function xyzzy({ foo, bar, qux }) {
  console.log(qux);   // 3
  console.log(bar);   // 2
  console.log(foo);   // 1
}

let obj = {
  foo: 1,
  bar: 2,
  qux: 3,
};

xyzzy(obj);
```

If you want to use destructuring elsewhere, e.g. for assignment, you may need to enclose the expression parentheses:

```javascript
{ foo, bar, qux } = obj;     // syntax error, JavaScript thinks `{` marks the beginning of a block
({ foo, bar, qux } = obj);   // destructuring assignment!
```

## Array Destructuring

```javascript
let foo = [1, 2, 3];
let first = foo[0];
let second = foo[1];
let third = foo[2];
```

The following snippet is equivalent to the previous:

```javascript
let foo = [1, 2, 3];
let [ first, second, third ] = foo;
```

Some elements may be skipped:

```javascript
let bar = [1, 2, 3, 4, 5, 6, 7];
let [ first, , , fourth, fifth, , seventh ] = bar;
```

You can combine array destructuring with array literal notation to perform multiple assignments on a single line. This is also useful for swapping values of two variables.

```javascript
let one = 1;
let two = 2;
let three = 3;

// destructuring on the left of =, array literal on the right
let [ num1, num2, num3 ] = [one, two, three];

console.log(num1);   // 1
console.log(num2);   // 2
console.log(num3);   // 3
```

You can use rest syntax with array destructuring:

```javascript
let foo = [1, 2, 3, 4];
let [ bar, ...qux ] = foo;
console.log(bar);   // 1
console.log(qux);   // [2, 3, 4]
```

## Spread Syntax

Spread and rest syntax both use `...` and look similar, but the work distinctly. **Spread syntax** uses `...` to "spread" the elements of an array or object into separate items:

```javascript
function add3(item1, item2, item3) {
  return item1 + item2 + item3;
}

let foo = [3, 7, 11];
add3(foo[0], foo[1], foo[2]);   // 21
```

You can replace the final function call with:

```javascript
add3(...foo);   // 21
```

Common uses of spread syntax:

```javascript
// clone an array:
let foo = [1, 2, 3];
let bar = [...foo];

console.log(bar);           // [1, 2, 3]
console.log(foo === bar);   // false - bar is a new/different array

// clone an object:
let foo = { qux: 1, baz: 2 };
let bar = { ...foo };

console.log(bar);            // { qux: 1, baz: 2 }
console.log( foo === bar);   // false - bar is a new/different object
```

```javascript
// concatenate arrays:
let foo = [1, 2, 3];
let bar = [4, 5, 6];
let qux = [...foo, ...bar];

console.log(qux);   // [1, 2, 3, 4, 5, 6]

// merge objects
let foo = { qux: 1, baz: 2 };
let xyz = { baz: 3, sup: 4 };
let obj = { ...foo, ...xyz };

console.log(obj);   // { qux: 1, baz: 3, sup: 4 }
// note how the latter object's (xyz) baz property overwrote the former's: baz is 3, not 2
```

```javascript
// insert an array into another array:
let foo = [1, 2, 3];
let bar = [...foo, 4, 5, 6,, ...foo];

console.log(bar);   // [1, 2, 3, 4, 5, 6, 1, 2, 3]
```

> Note that spread syntax with objects only returns enumerable "own" properties (what would be returned with `Object.keys`. Inherited properties and the object prototype are not copied.

## Rest Syntax

**Rest syntax** can, in some ways, be thought of as the opposite of spread syntax: instead of spreading a collection out into separate items, it gathers multiple items into a collection (array or object):

```javascript
// into an array:
let foo = [1, 2, 3, 4];
let [ bar, ...otherStuff ] = foo;

console.log(bar);          // 1
console.log(otherStuff);   // [2, 3, 4]

// into an object:
let foo = { bar: 1, qux: 2, baz: 3, xyz: 4 };
let { bar, baz, ...otherStuff } = foo;

console.log(bar);          // 1
console.log(baz);          // 3
console.log(otherStuff);   // {qux: 2, xyz: 4}
```
