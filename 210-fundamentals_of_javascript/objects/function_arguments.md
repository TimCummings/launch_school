
# Working with Function Arguments - 11/4/2020

Previously, we learned that you can pass a function too many or to few arguments, and JavaScript will continue to run without an error as omitted arguments take a value of `undefined`. There are other ways we can work with arguments:

## Traditional Approach - arguments object

The `arguments` object is an *Array-like* local variable that is available inside all functions; it contains all arguments passed to the function regardless of how many parameters are defined with the function or how many arguments are actually passed.

```javascript
function logArgs(a) {
console.log(arguments[0]);
console.log(arguments[1]);
console.log(arguments.length);

console.log(typeof arguments);
console.log(Array.isArray(arguments));
arguments.pop();
}

logArgs(1, 'a');

// logs:
// 1
// a
// 2

// object
// false
// TypeError: Object #<Object> has no method 'pop'
```

Notice that the arguments object can use bracket notation to access its members and it has a length property, but it's not an array and has no other Array methods. If we want to create an Array from the `arguments` object, we can do the following: (we'll discuss prototypes later, but for now, think of this as "borrowing" the `slice` method from the `Array` global object.)

```javascript
function logArgs() {
  let args = Array.prototype.slice.call(arguments);
  console.log(typeof args);
  console.log(Array.isArray(args));
  args.pop();
}

logArgs(1, 2);

// logs:
// object
// true
```

The usefulness of this is that we can write functions that work with any number of arguments. The downside is that such a function probably will have no parameters, which can be confusing. ES6 solves this with rest parameter syntax.

```javascript
function sum() {
  let result = 0;
  for (let index = 0; index < arguments.length; index += 1) {
    rest += arguments[index];
  }

  return result;
}

sum();                // 0
sum(1, 2, 3);         // 6
sum(1, 2, 3, 4, 5);   // 15
```

### The Modern Approach - rest parameters

ES6 introduces a clearer approach with rest parameters: an ellipsis (three dots) followed by a name tells JavaScript to place an arbitrary number of arguments (zero or more) into an array with the name provided after the ellipsis; this is an actual Array, not just an *array-like* object. Rest parameters can be mixed with other named parameters, but the rest parameter must come last.

```javascript
function logArgs(...args) {
  console.log(args[0]);
  console.log(args[1]);
  console.log(args.length);
}

logArgs(1, 'a');

// logs:
// 1
// a
// 2
```

Use rest parameters over the `arguments` object if you can help it; your code will be more clear.
