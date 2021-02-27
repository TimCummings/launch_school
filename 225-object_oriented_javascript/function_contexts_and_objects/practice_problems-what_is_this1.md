
# Practice Problems: What is this? (1) - 12/23/2020

> Be sure to use Chrome Snippets for this assignment. You can use other browser tools or Node, but we will assume that you're using Chrome. If you do use Node or another browser, you may see different results and even experience errors. We introduce Chrome Snippets in [this assignment](https://launchschool.com/lessons/c9200ad2/assignments/c8e3c9a4).

1. What does `this` point to in the code below?

```javascript
function whatIsMyContext() {
  return this;
}
```

### Solution

In this code, `this` references the global object, `window`.

#### Adjustments based on provided solution

We are only shown the function definition, not its invocation. Therefore, we don't know what `this` is, since a function's context is determined by where it's executed.

---

2. What does `this` point to in the code below?

```javascript
function whatIsMyContext() {
  return this;
}

whatIsMyContext();
```

### Solution

In this code, `this` references the global object, `window`.

---

3. What does `this` point to in the code below?

```javascript
function foo() {
  function bar() {
    function baz() {
      console.log(this);
    }

    baz();
  }

  bar();
}

foo();
```

### Solution

`this` is the global object, `window` in sloppy mode, or `undefined` in strict mode.

---

4. What does `this` point to in the code below?

```javascript
let obj = {
  count: 2,
  method() {
    return this.count;
  },
};

obj.method();
```

### Solution

Since the `method` function is invoked as a method on the `obj` object, `this` inside of `method` is the containing object, `obj`.

---

5. In strict mode, what does the following program log to the console?

```javascript
function foo() {
  console.log(this.a);
}

let a = 2;
foo();
```

### Solution

In strict mode, this will raise an error due to trying to reference the global object: since `foo` is invoked as a function without an explicit caller, `this` inside of `foo` would be the global object in sloppy mode, but is `undefined` in strict mode.

#### Adjustments based on provided solution

I need to further specify that the error is due to attempting to access the property `a` of `undefined`, which it doesn't have.

---

6. What does the following program log to the console?

```javascript
let a = 1;
function bar() {
  console.log(this.a);
}

let obj = {
  a: 2,
  foo: bar,
};

obj.foo();
```

### Solution

This will log `2` to the console, because the function `bar` is being called as a method on object `obj`.

---

7. What does the following code log to the console?

```javascript
let foo = {
  a: 1,
  bar() {
    console.log(this.baz());
  },

  baz() {
    return this;
  },
};

foo.bar();
let qux = foo.bar;
qux();
```

### Solution

This logs:

```javascript
// the object `foo`:
{a: 1, bar: f, baz: f}
undefined
```

#### Adjustments based on provided solution

Line 14 does not log `undefined` but raises an error instead, because it's trying to invoke something that isn't a function: `this.baz()` is the same as `window.baz()`, but `window.baz` is `undefined` and cannot be invoked.
