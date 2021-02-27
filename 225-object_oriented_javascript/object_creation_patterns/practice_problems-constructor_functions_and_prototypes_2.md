
# Practice Problems: Constructor Functions and Prototypes (2) - 1/29/2020

## 1. Follow the steps below:

1. Create an object called `shape` that has a `getType` method.
2. Define a `Triangle` constructor function whose prototype is `shape`. Objects created with `Triangle` should have four own properties: `a`, `b`, `c` (representing the sides of a triangle), and `type`.
3. Add a new method to the prototype called `getPerimeter`.

Test your implementation with the following code:

```javascript
let t = new Triangle(3, 4, 5);
t.constructor;                 // Triangle(a, b, c)
shape.isPrototypeOf(t);        // true
t.getPerimeter();              // 12
t.getType();                   // "triangle"
```

### Solution

```javascript
let shape = {
  getType() {
    return this.type;
  },
};

function Triangle(a, b, c) {
  this.a = a;
  this.b = b;
  this.c = c;
  this.type = 'triangle';
}

Triangle.prototype = shape;
Triangle.prototype.getPerimeter = function() {
  return this.a + this.b + this.c;
};
```

#### Adjustments based on provided solution

Since we substituted our own prototype object for `Triangle`, we also have to set its constructor: `Triangle.prototype.constructor = Triangle;`.

---

2. Since a constructor is just a function, it can be called without the `new` operator, and this can lead to unexpected results and errors especially for inexperienced programmers.

Write a constructor function that can be used with or without the `new` operator, and return the same result in either form. Use the code below to check your solution:

```javascript
function User(first, last) {
  // ...
}

let name = 'Jane Doe';
let user1 = new User('John', 'Doe');
let user2 = User('John', 'Doe');

console.log(name);         // => Jane Doe
console.log(user1.name);   // => John Doe
console.log(user2.name);   // => John Doe
```



> In the constructor function, first check the value of `this` to see if it is an instance created by the constructor function. Since, if it's called with the `new` operator JavaScript sets the value of `this` behind the scenes. Given that, check if it's used as a regular function (invoked without the `new`), if it is invoke itself with the `new` operator and return the result. If it is used as a constructor function, run the rest of the code in the function.

### Solution

```javascript
function User(first, last) {
  let self = Object.create(User.prototype);
  self.name = `${first} ${last}`.trim();
  return self;
}
```

#### Adjustments based on hint

### Solution

```javascript
function User(first, last) {
  if (!(this instanceof User)) return new User(first, last);
  this.name = `${first} ${last}`.trim();
}
```

---

3. Create a function that can create an object with a given object as its prototype, without using `Object.create`.

```javascsript
function createObject(obj) {
  // ...
}

let foo = {
  a: 1
};

let bar = createObject(foo);
foo.isPrototypeOf(bar);         // true
```

> Hint: You could work through the `[[Prototype]]` property, but a better solution is to create a "temporary" function, and set its prototype to the given object, then use the function to create objects. You don't have to worry about browser compatibility with this solution.


### Solution

```javascript
function createObject(obj) {
  let result = {};
  Object.setPrototypeOf(result, obj);
  return result;
}
```

#### Adjustments based on hint

```javascript
function createObject(obj) {
  let ObjConstructor = function() {};
  ObjConstructor.prototype = obj;
  return new ObjConstructor();
}
```

---

4. Similar to the problem above, without using `Object.create`, create a `begetObject` method that you can call on any object to create an object inherited from it:

```javascript
let foo = {
  a: 1,
};

let bar = foo.begetObject();
foo.isPrototypeOf(bar);         // true
```

Hint: What prototype object do we have to add a method to so that "**any**" object will be able to look it up? Check out the lesson on [Prototypal Inheritance and Behavior Delegation](https://launchschool.com/lessons/24a4613a/assignments/7143264c) for a refresher.

### Solution

```javascript
let foo = {
  a: 1,
  begetObject() {
    let Begetter = function() {};
    Begetter.prototype = this;
    return new Begetter();
  },
};
```

#### Adjustments based on provided solution

The problem does not ask for a method on `foo`; it asks for a method that can be called on *any object*. As such, it needs to be added to the function prototype of Object:

```javascript
Object.prototype.begetObject = function() {
  let Begetter = function() {};
  Begetter.prototype = this;
  return new Begetter();
};
```

---

5. Create a function `neww`, so that it works like the `new` operator. For this practice problem, you may use `Object.create`.

```javascript
function neww(constructor, args) {
  // ..
}

function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

Person.prototype.greeting = function() {
  console.log('Hello, ' + this.firstName + ' ' + this.lastName);
};

let john = neww(Person, ['John', 'Doe']);
john.greeting();          // => Hello, John Doe
john.constructor;         // Person(firstName, lastName) {...}
```

Hint: You may want to go back to the [Constructor Functions](https://launchschool.com/lessons/24a4613a/assignments/c659f8e4) and [Constructors and Prototypes](https://launchschool.com/lessons/24a4613a/assignments/441a520a) assignments and review what happens when a function is used as a constructor and what happens behind the scenes. Note that if the constructor function has no explicit return, the created object will be returned.

### Solution

```javascript
function neww(constructor, args) {
  let self = Object.create(constructor.prototype);
  constructor.apply(self, args);
  return self;
}
```

#### Adjustments based on provided solution

Beware of the constructor returning a different object:

```javascript
function neww(constructor, args) {
  let self = Object.create(constructor.prototype);
  let result = constructor.apply(self, args);
  return typeof result === 'object' ? result : self;
}
```
