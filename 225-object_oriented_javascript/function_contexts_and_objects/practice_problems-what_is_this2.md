
# Practice Problems: What is this? (2) - 12/28/2020

> While working through these practice problems, assume that the code runs within a web page.

1. What does `this` point to in the code below, and what does the method return?

```javascript
let myObject = {
  count: 1,
  myChildObject: {
    myMethod() {
      return this.count;
    },
  },
};

myObject.myChildObject.myMethod();
```

### Solution

`this` on line 5 is the inner object, `myChildObject`; the method returns `undefined`, because `myChildObject` does not have a `count` property.

---

2. In the previous problem, how would you change the context, or the value of `this`, to be the parent `myObject`?

### Solution

To change the context to the parent object, you can bind the `myMethod` method to the parent object:

```javascript
let myObject = {
  count: 1,
  myChildObject: {
    myMethod: function() {
      return this.count;
    }.bind(myObject),
  },
};

myObject.myChildObject.myMethod();
```

---

3. What does the following code log to the console?

```javascript
let person = {
  firstName: 'Peter',
  lastName: 'Parker',
  fullName() {
    console.log(this.firstName + ' ' + this.lastName +
                ' is the Amazing Spiderman!');
  },
};

let whoIsSpiderman = person.fullName.bind(person);
whoIsSpiderman();
```

### Solution

This logs `Peter Parker is the Amazing Spiderman!`, because, althought assigning the `fullName` method to a variable removes it from its context, binding it to `person` restores its original context, so the `firstName` and `lastName` properties are again accessible.

---

4. What does the following code log to the console?

```javascript
let computer = {
  price: 30000,
  shipping: 2000,
  total() {
    let tax = 3000;
    function specialDiscount() {
      if (this.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    }

    return this.price + this.shipping + tax - specialDiscount();
  }
};

console.log(computer.total());
```

If you want this program to log `34000`, how would you fix it?

### Solution

This logs `35000`, because `this` inside the `specialDiscount` function is the global object, which does not have a `price` property, so `this.price` evaluates to `undefined` causing the `if` condition to always evaluate to `false` and always return a special discount of `0`.

To get this program to log `34000`, you can make the `specialDiscount` function an arrow function, which will not establish its own `this`, but use the `this` of its lexical context, which would be the `this` of the `total` method, the `computer` object:

```javascript
let computer = {
  price: 30000,
  shipping: 2000,
  total() {
    let tax = 3000;
    let specialDiscount = () => {
      if (this.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    };

    return this.price + this.shipping + tax - specialDiscount();
  }
};
```
