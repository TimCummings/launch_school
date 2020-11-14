
# JavaScript Language Fundamentals - Medium 1 - 11/5/2020

1. Logical Operation

What will each line of the following code return? Don't run the code until after you have tried to answer.

```javascript
(false && undefined);
(false || undefined);
((false && undefined) || (false || undefined));
((false || undefined) || (false && undefined));
((false && undefined) && (false || undefined));
((false || undefined) && (false && undefined));
('a' || (false && undefined) || '');
((false && undefined) || 'a' || '');
('a' && (false || undefined) && '');
((false || undefined) && 'a' && '');
```

### Solution

1) false
2) undefined
3) undefined: `(false) || (undefined)`
4) false: `(undefined) || (false)`
5) false: `(false) && (undefined)`
6) undefined: `(undefined) && (false)`
7) 'a': `'a' || (false) || ''`
8) 'a': `(false) || 'a' || ''`
9) undefined: `'a' && (undefined) && ''`
10) undefined: `(undefined) && 'a' && ''`

---

2. Conditional Loop

The following program is expected to log each number between `0` and `9` (inclusive) that is a multiple of `3`. Read through the code shown below. Will it produce the expected result? Why or why not?

```javascript
let i = 0;
while (i < 10) {
  if (i % 3 === 0) {
    console.log(i);
  } else {
    i += 1;
  }
}
```

### Solution

This code will not produce the expected result. It will get stuck in an infinite loop repeatedly logging `3` to the console. This is because the true branch of the if conditional does not increment `i`. Until `i` is `3`, each iteration will follow the false branch of the if conditional. Once `i` is `3`, it will always follow the true branch of the if conditional and never get incremented again.

#### Adjustments based on provided solution

`i` never even makes it to `3`; it gets stuck on the first iteration with `i` equal to `0` because `0 % 3` is `0`.

---

3. Multiplication Table

The following program is expected to log a multiplication table for the numbers from `1` to `10` to the console. Read through the code shown below. Will it produce the expected result? Why or why not?

```javascript
function padLeft(number) {
  const stringNumber = String(number);
  switch (stringNumber.length) {
    case 1:  return `  ${stringNumber}`;
    case 2:  return ` ${stringNumber}`;
    default: return stringNumber;
  }
}

for (let i = 1; i < 10; i += 1) {
  let row = '';
  for (let j = 1; j <= 10; j += 1) {
    row += `${padLeft(i * j)} `;
  }

  console.log(row);
}
```

### Solution

This code only logs multiplication tables for numbers 1-9; the outer for loop stops after `i` is `9`.

---

4. Selected Columns

The `getSelectedColumns` function selects and extracts specific columns to a new array. Currently, the function is not producing the expected result. Go over the function and the sample runs shown below. What do you think the problem is?

```javascript
function getSelectedColumns(numbers, cols) {
  var result = [];

  for (var i = 0, length = numbers.length; i < length; i += 1) {
    for (var j = 0, length = cols.length; j < length; j += 1) {
      if (!result[j]) {
        result[j] = [];
      }

      result[j][i] = numbers[i][cols[j]];
    }
  }

  return result;
}

// given the following arrays of number arrays
const array1 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
const array2 = [[1, 2, 3], [1, 2, 3], [1, 2, 3]];

// `array1` in row/column format
// [[1, 2, 3],
//  [4, 5, 6],
//  [7, 8, 9]]

getSelectedColumns(array1, [0]);     // [[1]];            expected: [[1, 4, 7]]
getSelectedColumns(array1, [0, 2]);  // [[1, 4], [3, 6]]; expected: [[1, 4, 7], [3, 6, 9]]
getSelectedColumns(array2, [1, 2]);  // [[2, 2], [3, 3]]; expected: [[2, 2, 2], [3, 3, 3]]
```

### Solution

The issue is the double declaration of `var length`. `var` variables have function scope so the outer for loop `length` and the inner for loop `length` are actually the same variable.

---

5. Counter

What will the following code snippets log?

Code Snippet 1

```javascript
var counter = 5;
var rate = 3;
console.log('The total value is ' + String(counter * rate));

function counter(count) {
  // ...
}
```

Code Snippet 2

```javascript
function counter(count) {
  // ...
}

console.log('The total value is ' + String(counter * rate));

var counter = 5;
var rate = 3;
```

Code Snippet 3

```javascript
var counter = 5;
var rate = 3;

function counter(count) {
  // ...
}

console.log('The total value is ' + String(counter * rate));
```

Code Snippet 4

```javascript
let counter = 5;
let rate = 3;

function counter(count) {
  // ...
}

console.log('The total value is ' + String(counter * rate));
```

### Solution

1) The total value is 15
2) The total value is NaN
3) The total value is NaN
4) The total value is NaN

#### Adjustments based on provided solution

3) The total value is 15

The function declaration is hoisted above the variable declaration and assignment; the variable assignment overwrites the function stored in the `counter` variable.

4) raises a SyntaxError

Successive `var` declarations of the same identifier don't throw errors, but `let` does.

---

6. Logger

Read through the following code. Why will it log `'debugging'`?

```javascript
function debugIt() {
  const status = 'debugging';
  function logger() {
    console.log(status);
  }

  logger();
}

debugIt();
```

### Solution

The `status` variable is in an outer scope and is therefore accessible to the `logger` function via its closure.

---

7. Invoice

The `invoiceTotal` function in the code below computes the total amount for an invoice containing four "line items". How can you refactor the function so that it will work with invoices containing any number of line items?

```javascript
function invoiceTotal(amount1, amount2, amount3, amount4) {
  return amount1 + amount2 + amount3 + amount4;
}

invoiceTotal(20, 30, 40, 50);          // works as expected
invoiceTotal(20, 30, 40, 50, 40, 40);  // does not work; how can you make it work?
```

### Solution

You can get the `invoiceTotal` function to work with any number of line items by using the `arguments` object, or use a better approach with a rest parameter:

```javascript
function invoiceTotal(...amounts) {
  return amounts.reduce((sum, amount) => sum + amount, 0);
}

invoiceTotal(20, 30, 40, 50);          // works as expected
invoiceTotal(20, 30, 40, 50, 40, 40);  // does not work; how can you make it work?
```

---

8. Product of Sums

The `productOfSums` function shown below is expected to return the product of the sums of two arrays of numbers. Read through the following code. Will it produce the expected result? Why or why not?

```javascript
function productOfSums(array1, array2) {
  let result = total(array1) * total(array2);
  return result;
}

function total(numbers) {
  let sum;

  for (let i = 0; i < numbers.length; i += 1) {
    sum += numbers[i];
  }

  sum;
}
```

### Solution

This will not work as expected. In the `total` function, the variable `sum` is declared but not initialized, so when it is used as an operand to the `+=` operator, its value of `undefined` is coerced to `NaN`. When `NaN` is used in any arithmetic operation, the result is `NaN`.

#### Adjustments based on provided solution

That was not the only issue. The `total` function does also not explicitly return anything, so its return value will always be `undefined`.
