
# Practice Problems: Higher-Order Functions - 12/29/2020

1. What are the characteristics that define higher-order functions?

### Solution

A higher-order function takes another function as an argument, returns another function, or does both.

---

2. Consider the code below:

```javascript
let numbers = [1, 2, 3, 4];
function checkEven(number) {
  return number % 2 === 0;
}

numbers.filter(checkEven); // [2, 4]
```

Of the two functions invoked (`checkEven` and `filter`), which is a higher-order function and why?

### Solution

`checkEven` is not a higher-order function because it neither accepts a function as an argument nor returns a function.

`filter` is a higher-order function because it takes afunction as an argument: `checkEven` in this case.

---

3. Implement `makeCheckEven` below, such that the last line of the code returns an array `[2, 4]`.

```javascript
let numbers = [1, 2, 3, 4];
function makeCheckEven() {
  // ... implement this function
}

let checkEven = makeCheckEven();

numbers.filter(checkEven); // [2, 4]
```

### Solution

```javascript
let numbers = [1, 2, 3, 4];
function makeCheckEven() {
  return number => number % 2 === 0;
}

let checkEven = makeCheckEven();

numbers.filter(checkEven); // [2, 4]
```

---

4. Implement `execute` below, such that the return values for the two function invocations match the commented values.

```javascript
function execute(func, operand) {
  // ... implement this function
}

execute(function(number) {
  return number * 2;
}, 10); // 20

execute(function(string) {
  return string.toUpperCase();
}, 'hey there buddy'); // "HEY THERE BUDDY"
```

### Solution

```javascript
function execute(func, operand) {
  return func(operand);
}
```

---

5. Implement `makeListTransformer` below such that `timesTwo`'s return value matches the commented return value.

```javascript
function makeListTransformer(func) {
  // ... implement this function
}

let timesTwo = makeListTransformer(function(number) {
  return number * 2;
});

timesTwo([1, 2, 3, 4]); // [2, 4, 6, 8]
```

### Solution

```javascript
let timesTwo = makeListTransformer(function(number) {
  return number * 2;
});
```
