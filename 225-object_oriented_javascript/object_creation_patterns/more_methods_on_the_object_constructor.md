
# More Methods on the Object Constructor - 1/31/2021

## Problems

1. Using this method, create a function that constructs a new object with a `log` method that is read-only. The log method will use console.log to output the `name` property on itself.

```javascript
function newPerson(name) {
  // ...
}

let me = newPerson('Shane Riley');
me.log();     // => Shane Riley
me.log = function() { console.log('Amanda Rose'); };
me.log();     // => Shane Riley
```

### Solution

```javascript
function newPerson(name) {
  let person = {};
  Object.defineProperty(person, 'log', {
    value: function() { console.log(this.name); },
    writable: false,
  });

  person.name = name;
  return person;
}
```

#### Adjustments based on provided solution

`Object.defineProperty` and `Object.defineProperties` return the passed-in object, so our code can be cleaned up:

```javascript
function newPerson(name) {
  return Object.defineProperties({ name: name }, {
    log: {
      value() {
        console.log(this.name);
      },
      writable: false,
    },
  });
}
```

---

2. In regards to a frozen object: can you explain why the array and object properties are changed, but the method is not?

```javascript
let frozen = {
  integer: 4,
  string: 'String',
  array: [1, 2, 3],
  object: {
    foo: 'bar'
  },
  func() {
    console.log('I\'m frozen');
  },
};

Object.freeze(frozen);
frozen.integer = 8;
frozen.string = 'Number';
frozen.array.pop();
frozen.object.foo = 'baz';
frozen.func = function() {
  console.log('I\'m not really frozen');
};

console.log(frozen.integer);      // => 4
console.log(frozen.string);       // => String
console.log(frozen.array);        // => [1, 2]
console.log(frozen.object.foo);   // => baz
frozen.func();                    // => I'm frozen
```

### Solution

The `array` and `object` properties on the `frozen` object are not allowed to be changed (deleted or assigned new values), however the array and object they point to can still be mutated unless they are also frozen.

---

