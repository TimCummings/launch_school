
# Objects and Prototypes - 1/28/2021

## Problems

1. Use the method we learned above to assign `foo` below to a new Object with `prot` as its prototype.

```javascript
let prot = {};

let foo = //?
```

### Solution

```javascript
let foo = Object.create(prot);
```

---

2. Use `getPrototypeOf` to demonstrate the prototypal relationship between `prot` and `foo`.

### Solution

```javascript
Object.getPrototypeOf(foo) === prot;   // true
```

---

3. Use `isPrototypeOf` to demonstrate the prototypal relationship between `prot` and `foo`.

### Solution

```javascript
prot.isPrototypeOf(foo);   // true
```

---

4. What will the last two lines of the code below return? Why?

```javascript
let prot = {};

let foo = Object.create(prot);

prot.isPrototypeOf(foo);
Object.prototype.isPrototypeOf(foo);
```

### Solution

Both of the last two lines will return `true`: `isPrototypeOf` returns `true` when its caller is in the prototype chain of its argument, not just the next immediate prototype. Put another way, `isPrototypeOf` returns `true` if its caller is any ancestor of its argument, not just the parent.
