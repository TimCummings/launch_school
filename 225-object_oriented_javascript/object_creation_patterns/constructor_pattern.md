
# Constructor Pattern - 1/28/2021

## Problems

1. What naming convention separates constructor functions from other functions?

### Solution


Constructor functions, by convention, should be capitalized, e.g. `Person`.

---

2. What will the code below output? Why?

```javascript
function Lizard() {
  this.scamper = function() {
    console.log("I'm scampering!");
  };
}

let lizzy = Lizard();
lizzy.scamper(); // ?
```

### Solution

This will raise an error due to `scamper` not being a property of `undefined`: constructor functions need to be called with the `new` operator, otherwise they'll be evaluated like a normal function. In this code, when `Lizard` is invoked on line 7, `this` inside `Lizard` is the global object, which is where the `scamper` property is added. Since `Lizard` does not explicitly return a value, `lizzy` is assigned `undefined` on line 7. Line 8 invokes `scamper` on `undefined` which has no such property and causes the specified error.

---

3. Alter the code in problem 2 so that it produces the desired output.

### Solution

```javascript
function Lizard() {
  this.scamper = function() {
    console.log("I'm scampering!");
  };
}

let lizzy = new Lizard();
lizzy.scamper(); // I'm scampering!
```
