
# Practice Problems: Partial Function Application - 1/20/2021

1. Using partial function application implement a function, `sub5`, that returns the value of a number subtracted by `5`.

```javascript
function subtract(a, b) {
  return a - b;
}

function sub5(a) {
  // implement this function using partial function application
}

sub5(10); // 5
sub5(20); // 15
```

### Solution

```javascript
function sub5(a) {
  return subtract(a, 5);
}
```

---

2. This code is a bit limited however, because we can only subtract by `5`. Implement the `makeSubN` function below so that we can supply any value we want to be subtracted from `a`, and get a new function that will always subtract this value.

```javascript
function subtract(a, b) {
  return a - b;
}

function makeSubN(n) {
  // implement this function...
}

let sub5 = makeSubN(5);
sub5(10); // 5
```

### Solution

```javascript
function makeSubN(n) {
  return function(a) {
    return subtract(a, n);
  };
}
```

---

3. Although the solution above is more flexible, we now want to be able to supply any operation, not just subtraction. Implement `makePartialFunc` below.

```javascript
function makePartialFunc(func, b) {
  // implement this function...
}

function multiply(a, b) {
  return a * b;
}

let multiplyBy5 = makePartialFunc(multiply, 5);

multiplyBy5(100); // 500
```

### Solution

```javascript
function makePartialFunc(func, b) {
  return function(a) {
    return func(a, b);
  };
}
```

---

4. In our previous solution, `multiplyBy5` retains access to `func` and `b` long after `makePartialFunc` has finished execution. What makes this possible?

### Solution

Closures make this possible: since `func` and `b` are still reachable from `multiplyBy5` by reference, the JavaScript runtime will not mark them for garbage collection yet. References from `multiplyBy5` to `func` and `b` are maintained in `multiplyBy5`'s closure.

---

5. Consider the code below:

```javascript
let subjects = {
  English: ['Bob', 'Tyrone', 'Lizzy'],
  Math: ['Fatima', 'Gary', 'Susan'],
  Biology: ['Jack', 'Sarah', 'Tanya'],
};

function rollCall(subject, students) {
  console.log(subject + ':');
  students.forEach(function(student) {
    console.log(student);
  });
}

function makeMathRollCall() {
  // implement this function...
}

let mathRollCall = makeMathRollCall();
mathRollCall(subjects['Math']);
// => Math:
// => Fatima
// => Gary
// => Susan
```

Implement `makeMathRollCall` such that it returns a partially applied `rollCall` function, with the subject as `'Math'`.


### Solution

```javascript
function makeMathRollCall() {
  return function(students) {
    return rollCall('Math', students);
  };
}
```
