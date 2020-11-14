
# Practice Problems - Variable Scopes in JavaScript 2 - 10/25/2020

Please predict the output of the following programs, and explain why they output what they do.

1. Problem 1

```javascript
function say() {
  if (false) {
    var a = 'hello from inside a block';
  }

  console.log(a);
}

say();
```

### Solution

This will raise a `ReferenceError` due to `a` not being defined when it is referenced on line 6. While `a` is hoisted to the top of its scope, said scope is the body of the `if` statement, which is not executed.

#### Adjustments based on provided solution

I had the right idea but I missed a crucial detail: `var` variables are scoped at the **function** level, not block. Accordingly, `a` is not hoisted to the top of the `if` body, but to the top of the function. So when `a` is referenced on line 6, it has been declared (due to hoisting) but not initialized, so this code will log `undefined`.

---

2. Problem 2

```javascript
function say() {
  if (false) {
    let a = 'hello from inside a block';
  }

  console.log(a);
}

say();
```

### Solution

This will raise a `ReferenceError` due to `a` not being defined when it is referenced on line 6. While `a` is hoisted to the top of its scope, said scope is the body of the `if` statement, which is not executed.

---

3. Problem 3

```javascript
function hello() {
  a = 'hello';
  console.log(a);

  if (false) {
    var a = 'hello again';
  }
}

hello();
console.log(a);
```

### Solution

```
hello
ReferenceError
```

The `var a` declaration on line 6 is hoisted to the top of the `hello()` function (but not the assignment to `'hello again'`.)
`a` is initialized to `'hello'` on line 2 and then logged on line 3.
Line 11 raises a `ReferenceError` due to a not being defined; `a` is only available inside the `hello()` function the last `console.log` on line 11 is outside.

---

4. Problem 4

```javascript
function hello() {
  a = 'hello';
  console.log(a);

  if (false) {
    let a = 'hello again';
  }
}

hello();
console.log(a);
```

### Solution

```
hello
hello
```

Line 2 defines a global variable `a` since it hasn't been declared before the assignment.
`a` on line 6 is hoisted, but since it's declared with `let` and not `var`, it's only hoisted to the top of the `if` block, not the top of the function.
Line 3 logs the value of the global variable `a` which is `hello` from its assignment on line 2.
Line 11 logs the value of the global variable `a` which is still `hello`.

---

5. Problem 5

```javascript
var a = 'hello';

for (var index = 0; index < 5; index += 1) {
  var a = index;
}

console.log(a);
```

### Solution

`4`

Variables `a` and `index` are both declared with `var` and are both hoisted to the top of the code snippet (`var` is function scoped, not block scoped.)
The re-declaration of `a` on line 4 has no effect. `a` is assigned the value of `index` five times inside the `for` loop.
Line 7 logs `a` with the value of `4` from its reassignment in the `for` loop.

---

6. Problem 6

```javascript
let a = 'hello';

for (let index = 0; index < 5; index += 1) {
  let a = index;
}

console.log(a);
```

### Solution

`hello`

The variables `a` from line 4 and `index` are scoped to the body of the `for` statement. The `a` declared on line 4 is a different variable than `a` from line 1.
Variable `a` on line 4 shadows `a` from line 1; line 4 `a` is reassigned in the `for` loop while line 1 `a` remains unchanged.
Line 7 logs the value of `a` from line 1 which is `hello`.

---

7. Problem 7

```javascript
let a = 1;

function foo() {
  a = 2;
  let bar = function() {
    a = 3;
    return 4;
  };

  return bar();
}

console.log(foo());
console.log(a);
```

### Solution

```
4
3
```

Line 13 logs the result of calling the `foo()` function; `foo()` returns the result of calling the `bar()` function, which returns `4` on line 7.
Line 14 logs the value of `a`: `a` is declared on line 1 and assigned the value `1`; function `foo()`, invoked on line 13, reassigns a to `2` on line 4 then calls `bar()` on line 10; `bar()` assigns `a` to 3 on line 6, which is what is logged on line 14.

---

8. Problem 8

```javascript
var a = 'global';

function checkScope() {
  var a = 'local';
  const nested = function() {
    var a = 'nested';
    let superNested = () => {
      a = 'superNested';
      return a;
    };

    return superNested();
  };

  return nested();
}

console.log(checkScope());
console.log(a);
```

### Solution

```
superNested
global
```

Line 18 logs the result of calling the `checkScope()` function, which is the string `'superNested'`. This comes from the assignment on line 8 which reassigns `var a` from line 6.
Line 19 logs the value of `a` which is the string `'global'`; this is the `a` from line 1 because the other `a` variables on lines 4 and 6 shadow it.

---

9. Problem 9

```javascript
let a = 'outer';
let b = 'outer';

console.log(a);
console.log(b);
setScope(a);
console.log(a);
console.log(b);

function setScope(foo) {
  foo = 'inner';
  b = 'inner';
}
```

### Solution

```
outer
outer
outer
inner
```

Line 4 logs the value of `a` from line 1 which is `'outer'`.
Line 5 logs the value of `b` from line 2 which is `'outer'`.
Line 6 invokes the `setScope()` function which reassigns `b` to `'inner'` on line 12.
Line 8 logs the value of `a` from line 1 which is still `'outer'`.
Line 9 logs the value of `b` which is now `'inner'`.

---

10. Problem 10

```javascript
let total = 50;
let increment = 15;

function incrementBy(increment) {
  total += increment;
}

console.log(total);
incrementBy(10);
console.log(total);
console.log(increment);
```

### Solution

```
50
60
15
```

Line 8 logs the value of `total` from line 1 which is `50`.
Line 9 invokes the `incrementBy()` function which reassigns `total` from line 1 to `60`.
Line 10 logs the value of `total` which is now `60`.
Line 11 logs the value of `increment` from line 2 which is `15`.

---

11. Problem 11

```javascript
let a = 'outer';

console.log(a);
setScope();
console.log(a);

var setScope = function () {
  a = 'inner';
};
```

### Solution

```
outer
inner
```

Line 3 logs the value of `a` from line 1 which is `'outer'`.
Line 4 invokes the function `setScope()` which reassigns `a` from line 1 to `'inner'`.
Line 5 logs the value of `a` which is now `'inner'`.

#### Adjustments based on provided solution

Line 4 raises a `TypeError` due to the `setScope` variable not yet containing a function. Line 7 is a function *expression* not a function declaration. Because of hoisting, there is a declared variable `setScope`, but its value on line 4 is `undefined`, not the anonymous function starting on line 7.
