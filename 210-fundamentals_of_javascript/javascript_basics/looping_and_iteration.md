
# Looping and Iteration - 10/22/2020

## The "while" Loop

A `while` loop evaluates a condition then executes the statements in the loop body if the condition has a truthy value. Once it has reached the end of the block, control returns to the conditional expression again and the loop body repeats if the expression is still truthy. This continues until the expression evaluates to a falsy value. Accordingly, make sure a component of your condition changes in the loop body or you'll find yourself in an infinite loop.

You can further control loops with the `break` and `continue` statements:

```javascript
let counter = 0;
let limit = 10;

while (true) {
  counter += 2;
  if (counter === 4) {
    continue;
  }

  if (counter > limit) {
    break;
  }

  console.log(counter);
}

// 2
// 6
// 8
// 10
// note: 4 is not logged
```

## The "do... while" Loop

The `do... while` loop is similar to a `while` loop except it always iterates at least once (before evaluating the condition.)

```javascript
let counter = 0;
let limit = 0;

do {
  console.log(counter);
  counter += 1;
} while (counter < limit);
```

## The "for" Loop

The `for` loop is the most common looping structure in JavaScript. It lets you combine three key loop elements (setting the initial value, evaluating a condition, and making a change before re-evaluating) into a single statement:

```javascript
for (initialExpression; condition; incrementExpression) {
  // statements
}
```

```javascript
for (let i = 0; i < 10; i += 1) {
  console.log(i);
}

// logs:
// 0
// 1
// 2
// 3
// 4
// 5
// 6
// 7
// 8
// 9
```

While using a single letter variable such as `i` or `j` is common, we encourage you to use a more descriptive name, like `index`, even if it's still fairly generic.

The execution of a `for` loop flows as follows:

1. execute the initialization statement (which may include variable declarations)
2. evalute the condition; stop execution if false
3. execute the loop body
4. execute the increment expression
5. return to step 2 for the next iteration

Any of the three looping components may be skipped:

```javascript
// put initialization outside of the loop

let index = 0;
for (; index < 10; index += 1) {
  console.log(index);
}
```

```javascript
// manually check condition and break out of the loop
// If you omit the condition component in the "for", JavaScript assumes true

for (let index = 0; ; index += 1) {
  if (index >= 10) {
    break;
  }

  console.log(index);
}
```

```javascript
// manually increment the iterator

for (let index = 0; index < 10; ) {
  console.log(index);
  index += 1;
}
```
