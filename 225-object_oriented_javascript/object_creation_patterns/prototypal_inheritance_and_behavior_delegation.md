
# Prototypal Inheritance and Behavior Delegation - 1/28/2021

## Problems

1. What will the code below log to the console?

```javascript
let foo = {};
let bar = Object.create(foo);

foo.a = 1;

console.log(bar.a);
```

### Solution

This will log `1` since JavaScript, when it doesn't find the `a` property on `bar`, will search up `bar`'s prototype chain for `a` and find it on `foo`.

---

2. What will the code below log to the console?

```javascript
let foo = {};
let bar = Object.create(foo);

foo.a = 1;
bar.a = 2;
console.log(bar.a);
```

### Solution

This will log `2` because JavaScript will search for the `a` property locally in `bar` first and find it.

---

3. Given the code below, do we know for certain that on the last line we are ultimately referencing a property owned by boo? How can we test that `far` is not delegating to `boo`?

```javascript
let boo = {};
boo.myProp = 1;

let far = Object.create(boo);

// lots of code

far.myProp;       // 1
```

### Solution

We can use `Object.prototype.hasOwnProperty` to determine whether or not the `'myProp'` property is local to `far`:

```javascript
far.hasOwnProperty('myProp');   // false
```

`'myProp'` is not local to `far`; it's being delegated up  the prototype chain.
