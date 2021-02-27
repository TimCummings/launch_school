
# Practice Problems: Hard Binding Functions with Contexts - 12/10/2020

1. What function can we use to permanently bind a function to a particular execution context?

### Solution

`Function.prototype.bind()`

---

2. What will the code below log to console?

```javascript
let obj = {
  message: 'JavaScript',
};

function foo() {
  console.log(this.message);
}

foo.bind(obj);
```

### Solution

`'JavaScript'`

#### Adjustments based on provided solution

No, this doesn't log anything. `bind` doesn't immediately invoke a function; instead, it returns a function that can then be invoked itself.

---

3. What will the code below output?

```javascript
let obj = {
  a: 2,
  b: 3,
};

function foo() {
  return this.a + this.b;
}

let bar = foo.bind(obj);

console.log(bar());
```

### Solution

`5`

---

4. What will the code below log to the console?

```javascript
let positiveMentality = {
  message: 'JavaScript makes sense!',
};

let negativeMentality = {
  message: 'JavaScript makes no sense!',
};

function foo() {
  console.log(this.message);
}

let bar = foo.bind(positiveMentality);

negativeMentality.logMessage = bar;
negativeMentality.logMessage();
```

### Solution

`'JavaScript makes sense!'`

Even though `bar` is invoked as a method of the `negativeMentality` object which contains a different `message`, `bar` references the function returned by binding the `foo` function to the `positiveMentality` object, so any invocation of `bar`, unless it is reassigned to something else, will execute within the context of the `positiveMentality` object.

---

5. What will the code below output?

```javascript
let obj = {
  a: 'Amazebulous!',
};
let otherObj = {
  a: "That's not a real word!",
};

function foo() {
  console.log(this.a);
}

let bar = foo.bind(obj);

bar.call(otherObj);
```

### Solution

`Amazebulous`

As with the previous problem, `bar` is assigned the function returned by binding `foo` to `obj`, so it will always execute in the context of `obj`.
```javascript
```
