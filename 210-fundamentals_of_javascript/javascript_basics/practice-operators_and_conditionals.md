
# Practice Operators and Conditionals - 10/22/2020

1. Set a variable, `apples`, to 3. Set a second variable, `bananas`, to 5. Write a conditional using `==` that checks whether `apples` is equal to `bananas`. Log a message if true.

### Solution

```javascript
let apples = 3;
let bananas = 5;

if (apples == bananas) {
  console.log('True!');
}
```

---

2. Set the value of `bananas` to the string value "3". Use the same conditional as the previous problem.

```javascript
bananas = '3';

if (apples == bananas) {
  console.log('True!');
}

// => True!
```

---

3. Change the conditional from the previous practice problem to use `===` instead. Why doesn't this one output a message?

### Solution

```javascript
if (apples === bananas) {
  console.log('True!');
}
```

`apples` and `bananas` are different types (`apples` is a number and `bananas` is a string) and the strict equality operator `===` does not coerce its operands; it only returns true if they are the same value *and* type.

---

4. Write an `else` clause that logs a different message if false.

### Solution

```javascript
if (apples === bananas) {
  console.log('Strictly equal!');
} else {
  console.log('Not strictly equal!');
}

// Not strictly equal!
```

---

5. Between the `if` and `else` clauses, insert an `else if` clause that checks whether `apples == bananas`. Log a message stating that the two are the same number but different types.

### Solution

```javascript
if (apples === bananas) {
  console.log('Strictly equal!');
} else if (apples == bananas) {
  console.log('The number is the same but the types are different!');
} else {
  console.log('Not strictly equal!');
}

// Not strictly equal!
```

---

6. Move the `else if` clause into the `else` clause and change it to an `if` statement. After your `if` statement, append an `else` clause that outputs your "not strictly equal" message as before. The structure of the code should look like:

```javascript
else {
  if (…) {
    …
  }
  else {
    …
  }
}
```

### Solution

```javascript
if (apples === bananas) {
  console.log('Strictly equal!');
} else {
  if (apples == bananas) {
    console.log('The number is the same but the types are different!');
  } else {
    console.log('Not strictly equal!');
  }
}

// Not strictly equal!
```

---

7. Set the variables `apples` and `bananas` to 3. Set a variable, `areEqual`, to the value of `apples` compared to `bananas`. This works the same way as the `if` statements we have been writing, but instead of an `if` and the condition in parentheses, we just use the condition from within the parentheses as the new value for our variable. Log the value of `areEqual`.

### Solution

```javascript
apples = 3;
bananas = 3;

let areEqual = (apples === bananas);

console.log(areEqual);
// => true
```

---

8. Set the value of `apples` to 3 and `bananas` to `undefined`. Set a variable named `eitherOr` to the value of `apples` or `bananas`. This works the same as the previous problem, where you write the comparison as the assignment of the variable. Log the value of `eitherOr`.

### Solution

```javascript
apples = 3;
bananas = undefined;

let eitherOr = (apples || bananas);

console.log(eitherOr);
// => 3
```

---

9. Set the value of `bananas` to 1. Perform the same assignment for `eitherOr`. Log the value of `eitherOr`. Afterward, assign `bananas || apples` to the `eitherOr` variable. Note that the value is now the `bananas` variable instead of `apples`. JavaScript reads this statement from left to right. If the left-side has a truthy value, it is used. Otherwise, the right-side value is used.

### Solution

```javascript
bananas = 1;

eitherOr = (apples || bananas);
console.log(eitherOr);
// => 3

eitherOr = bananas || apples;
console.log(eitherOr);
// => 1
```

---

10. The ternary operator is another useful method for defining a variable to one of two possible values. This can also replace an `if` and `else` statement, but can sometimes be confusing when used that way.

Create two new variables, `lastName` and `familyMessage`. Set `lastName` to your last name, then use a ternary that checks whether `lastName` is equal to your last name to set `familyMessage` to either "You're part of the family!" or "You're not family."

### Solution

```javascript
let lastName = 'Cummings';
let familyMessage = (lastName === 'Cummings') ? "You're part of the family!" : "You're not family."

console.log(familyMessage);
// => You're part of the family!
```
