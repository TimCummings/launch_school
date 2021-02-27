
# Practice Problems: The Global Object - 12/10/2020

> Be sure to use Chrome Snippets for this assignment. You can use other browser tools or Node, but we will assume that you're using Chrome. If you do use Node or another browser, you may see different results and even experience errors. We introduce Chrome Snippets in [this assignment](https://launchschool.com/lessons/c9200ad2/assignments/c8e3c9a4).

1. With strict mode not enabled, what object serves as the implicit execution context? What happens when strict mode is enabled?

### Solution

In sloppy mode, the implicit execution context is the global object, which is `window` in a browser or `global` in a non-browser JavaScript environment.

In strict mode, defining a global variable without a declaration throws an error.

---

2. What does the code below log?

```javascript
a = 10;

console.log(window.a === a);
```

### Solution

`true`

---

3. In strict mode, what does the code in the previous question log?

### Solution

Nothing. It raises a `ReferenceError`.

---

4. What does the code below do?

```javascript
function func() {
  let b = 1;
}

func();

console.log(b);
```

### Solution

This will raise a `ReferenceError` due to `b` being out of scope when line 7 is evaluated.

---

5. What does the code below do?

```javascript
function func() {
  b = 1;
}

func();

console.log(b);
```

### Solution

This code logs `1` since `b` is added as a property of the global object on line 2.

---

6. What does the code below log?

```javascript
"use strict"

function func() {
  b = 1;
  }

func();

console.log(b);
```

### Solution

This throws a `ReferenceError` since strict mode disallows non-declared variable initializations.
