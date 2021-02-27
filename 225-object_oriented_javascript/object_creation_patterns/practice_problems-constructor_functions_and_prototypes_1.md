
# Practice Problems: Constructor Functions and Prototypes (1) - 1/29/2020

1. What does the following code log to the console?

```javascript
let a = 1;
let foo;
let obj;

function Foo() {
  this.a = 2;
  this.bar = function() {
    console.log(this.a);
  };
  this.bar();
}

foo = new Foo();

foo.bar();
Foo();

obj = {};
Foo.call(obj);
obj.bar();

console.log(this.a);
```

### Solution

```javascript
2
2
2
2
2
2
```

---

2. What does the following code log to the console?

```javascript
let RECTANGLE = {
  area() {
    return this.width * this.height;
  },
  perimeter() {
    return 2 * (this.width + this.height);
  },
};

function Rectangle(width, height) {
  this.width = width;
  this.height = height;
  this.area = RECTANGLE.area();
  this.perimeter = RECTANGLE.perimeter();
}

let rect1 = new Rectangle(2, 3);
console.log(rect1.area);
console.log(rect1.perimeter);
```

### Solution

```javascript
NaN
NaN
```

When the `area` and `perimeter` methods are invoked on lines 13 and 14, `RECTANGLE` is the calling object, which means `this` inside `area` and `perimeter` are `RECTANGLE`, not `rect1`. Since `RECTANGLE` doesn't have `width` or `height` properties, the method calls on lines 13 and 14 return `NaN`, which is assigned to `rect1`'s `area` and `perimeter` properties. Logging those properties on lines 18 and 19 log `NaN`.

---

How do you fix this problem?

### Solution

`this` inside `RECTANGLE.area` and `RECTANGLE.perimeter` needs to be `rect1`, which can be accomplished with `call`:

```javascript
function Rectangle(width, height) {
  this.width = width;
  this.height = height;
  this.area = RECTANGLE.area.call(this);
  this.perimeter = RECTANGLE.perimeter.call(this);
}

// ... eventually logs 6 and 10
```

---

3. Write a constructor function `Circle`, that takes a `radius` as an argument. You should be able to call an `area` method on the created objects to get the [circle's area](https://en.wikipedia.org/wiki/Area_of_a_circle). Test your implementation with the following code:

```javascript
let a = new Circle(3);
let b = new Circle(4);

console.log(a.area().toFixed(2)); // => 28.27
console.log(b.area().toFixed(2)); // => 50.27
```

### Solution

```javascript
function Circle(radius) {
  this.radius = radius;
}

Circle.prototype.area = function() {
  return Math.PI * Math.pow(this.radius, 2);
};
```

---

4. What will the following code log out and why?

```javascript
let ninja;
function Ninja() {
  this.swung = true;
}

ninja = new Ninja();

Ninja.prototype.swingSword = function() {
  return this.swung;
};

console.log(ninja.swingSword());
```

### Solution

```javascript
true
```

---

5. What will the following code log out and why?

```javascript
let ninja;
function Ninja() {
  this.swung = true;
}

ninja = new Ninja();

Ninja.prototype = {
  swingSword: function() {
    return this.swung;
  },
};

console.log(ninja.swingSword());
```

### Solution

This will raise a type error because `ninja` does not have a `swingSword` property: `ninja`'s prototype chain includes the original function prototype of the constructor function, `Ninja`. Only new instances will reflect the change to function prototype on lines 8-10.

---

6. Implement the method described in the comments below:

```javascript
let ninjaA;
let ninjaB;
function Ninja() {
  this.swung = false;
}

ninjaA = new Ninja();
ninjaB = new Ninja();

// Add a swing method to the Ninja prototype which
// returns the calling object and modifies swung

console.log(ninjaA.swing().swung);      // must log true
console.log(ninjaB.swing().swung);      // must log true
```

### Solution

```javascript
Ninja.prototype.swing = function() {
  this.swung = true;
  return this;
};
```

---

7. In this problem, we'll ask you to create a new instance of an object, without having direct access to the constructor function:

```javascript
let ninjaA = (function() {
  function Ninja(){};
  return new Ninja();
})();

// create a ninjaB object

console.log(ninjaB.constructor === ninjaA.constructor);    // should log true
```

### Solution

```javascript
// create a ninjaB object
let ninjaB = new ninjaA.constructor();
```
