
# Practice Problems: Prototypes and Prototypal Inheritance - 1/28/2020

1. Write a function that returns the object on a given object's prototype chain where a property is defined. See the example code below:

```javascript
function getDefiningObject(object, propKey) {
  // ...
}

let foo = {
  a: 1,
  b: 2,
};

let bar = Object.create(foo);
let baz = Object.create(bar);
let qux = Object.create(baz);

bar.c = 3;

console.log(getDefiningObject(qux, 'c') === bar);     // => true
console.log(getDefiningObject(qux, 'e'));             // => null
```

> Hint: You'll need to traverse up the prototype chain of the object and for each object, see if the property is defined, with the `hasOwnProperty` method. Note that `Object.prototype` is at the top of the prototype chain. If you can't find the property there and use `Object.getPrototypeOf` to get its prototype, you'll get `null` and that's what you should return.

### Solution

```javascript
function getDefiningObject(object, propKey) {
  if (!object[propKey]) return null;

  let currentObj = object;
  while (currentObj !== Object.prototype) {
    if (currentObj.hasOwnProperty(propKey)) return currentObj;
    currentObj = Object.getPrototypeOf(currentObj);
  }

  return Object.prototype;
}
```

#### Adjustments based on hint

```javascript
function getDefiningObject(object, propKey) {
  do {
    if (object.hasOwnProperty(propKey)) break;
    object = Object.getPrototypeOf(object);
  } while (object);

  return object;
}
```

---

3. Write a function to provide a shallow copy of an object. The object that you copy should share the same prototype chain as the original object, and it should have the same own properties that return the same values or objects when accessed. Use the code below to verify your implementation:

```javascript
function shallowCopy(object) {
  // ...
}

let foo = {
  a: 1,
  b: 2,
};

let bar = Object.create(foo);
bar.c = 3;
bar.say = function() {
  console.log('c is ' + this.c);
};

let baz = shallowCopy(bar);
console.log(baz.a);       // => 1
baz.say();                // => c is 3
baz.hasOwnProperty('a');  // false
baz.hasOwnProperty('b');  // false
```

### Solution

```javascript
function shallowCopy(object) {
  const copy = Object.create(Object.getPrototypeOf(object));

  Object.getOwnPropertyNames(object).forEach(function(prop) {
    copy[prop] = object[prop];
  });

  return copy;
}
```

---

3. Write a function that extends an object (destination object) with contents from multiple objects (source objects).

```javascript
function extend(destination) {
  // ...
}

let foo = {
  a: 0,
  b: {
    x: 1,
    y: 2,
  },
};

let joe = {
  name: 'Joe'
};

let funcs = {
  sayHello() {
    console.log('Hello, ' + this.name);
  },

  sayGoodBye() {
    console.log('Goodbye, ' + this.name);
  },
};

let object = extend({}, foo, joe, funcs);

console.log(object.b.x);          // => 1
object.sayHello();                // => Hello, Joe
```

### Solution

```javascript
function extend(destination, ...sources) {
  sources.forEach(function(source) {
    for (let prop in source) {
      destination[prop] = source[prop];
    }
  });

  return destination;
}
```
