
# Practice Problems: Variable Scopes in JavaScript (1) - 10/23/2020

Please predict the output of the following programs, and explain why they output what they do.

1. Problem 1

```javascript
let a = 'outer';

function testScope() {
  let a = 'inner';
  console.log(a);
}

console.log(a);
testScope();
console.log(a);
```

### Solution

```
outer
inner
outer
```

The outer `a` on line 1 and the inner `a` on line 4 are two different variables: the inner `a` shadows the outer `a`, so the assignment on line 4 does not affect the outer `a`.

---

2. Problem 2

```javascript
let a = 'outer';

function testScope() {
  a = 'inner';
  console.log(a);
}

console.log(a);
testScope();
console.log(a);
```

### Solution

```
outer
inner
inner
```

Line 8 evaluates `a` to the outer variable on line 1 with a value of `'outer'` and logs it.
Line 9 invokes the `testScope()` function which reassigns `a` to `'inner'` on line 4 and logs it on line 5.
Line 10 evalutes `a` to the outer variable on line 1, but its value was reassigned inside the `testScope()` function to`'inner'`.

---

3. Problem 3

```javascript
let basket = 'empty';

function goShopping() {
  function shop1() {
    basket = 'tv';
  }

  console.log(basket);

  let shop2 = function() {
    basket = 'computer';
  };

  const shop3 = () => {
    let basket = 'play station';
    console.log(basket);
  };

  shop1();
  shop2();
  shop3();

  console.log(basket);
}

goShopping();
```

### Solution

---

```
empty
play station
computer
```

Line 26 calls `goShopping()`.
Line 8 logs `basket` from line 1 with a value of `'empty'`.
Line 19 calls `shop1()` which reassigns `basket` from line 1 to `'tv'` but doesn't log anything.
Line 20 calls `shop2()` which reassigns `basket` from line 1 to `'computer'` but doesn't log anything.
Line 21 calls `shop3()` which creates a new variable `basket` on line 15 (shadowing `basket` from line 1), assigns it the value `'play station'`, and logs it on line 16.
Line 23 logs `basket` from line 1 with a value of `'computer'`.

---

4. Problem 4

```javascript
function hello() {
  a = 'hi';
}

hello();
console.log(a);
```

### Solution

```
hi
```

Line 2 creates a new global variable `a` since no other variable `a` has been declared.
Line 6 logs this global variable `a` with a value of `'hi'` from its assignment on line 2.

---

5. Problem 5

```javascript
function hello() {
  let a = 'hello';
}

hello();
console.log(a);
```

### Solution

This doesn't log anything but throws a `ReferenceError` due to line 6 referencing a variable `a` which has not been declared.

---

6. Problem 6

```javascript
console.log(a);

var a = 1;
```

### Solution

```
undefined
```

`a` is hoisted and, since it was declared with `var`, has an initial value of `undefined`. Line 1 tries to log `a` which has been declared, due to hoisting, but has not yet been initialized.

---

7. Problem 7

```javascript
console.log(a);

let a = 1;
```

### Solution

This raises a `ReferenceError`. Like the previous problem, variable `a` acts like it has already been declared due to hoisting, however, since it was defined with `let`, it is initially unset instead of `undefined` and referencing it before it's initialized raises an error.

#### Adjustments based on provided solution

Mention the TDZ.

---

8. Problem 8

```javascript
console.log(a);

function hello() {
  a = 1;
}
```

### Solution

This raises a `ReferenceError` since variable `a` does not exist.
