
# Conditionals - 10/22/2020

Conditional statements are sets of commands that are triggered when a condition is true. JavaScript supports `if... else` and `switch` conditionals.

## `if... else`

```javascript
let score = 80;
if (score > 70) {
  console.log('Congratulations, you passed!');
}
```

Note that:

1. `score > 70` is an expression that evaluates to a boolean. Here it is `true`.
2. `if (score > 70)` is a conditional statement. When it's `true`, the following block of code runs.
3. `{ console.log('Congratulations, you passed!'); }` is a block.

* An `if` statement may have an optional `else` statement.
* Another `if` statement may follow an `else` statement.
* `if` statements may be nested, but be careful, the logic quickly becomes difficult to follow

```javascript
if (condition1) {
  if (nestedCondtion) {
    // statements
  } else {
    // statements
  }
} else if (condition2) {
  // statements
}
```

## Truthy and Falsy

When the expression inside an `if` statement isn't a boolean value, JavaScript tries to translate it to one. There are only six so-called "falsy" values, including boolean `false`:

* `if (false)`
* `if (null)`
* `if (undefined)`
* `if (0)`
* `if (NaN)`
* `if ('')`

Any other value is truthy.

## Switch

The `switch` statement compares an expression with multiple `case` labels.

```javascript
let reaction = 'negative';

switch (reaction) {
  case 'positive':
    console.log('The sentiment of the market is positive');
    break;
  case 'negative':
    console.log('The sentiment of the market is negative');
    break;
  case 'undecided':
    console.log('The sentiment of the market is undecided');
    break;
  default:
    console.log('The market has not reacted enough');
}

// console output
The sentiment of the market is negative
```

The `break`s are necessary, otherwise evaluation will "fall through" and execute every subsequent case as well:

```javascript
let reaction = 'negative';

switch (reaction) {
  case 'positive':
    console.log('The sentiment of the market is positive');
  case 'negative':
    console.log('The sentiment of the market is negative');
  case 'undecided':
    console.log('The sentiment of the market is undecided');
  default:
    console.log('The market has not reacted enough');
}

// console output
The sentiment of the market is negative
The sentiment of the market is undecided
The market has not reacted enough
```

While normally unintended, this behavior can be used to cause multiple cases to evaluate to a single expression.

## Comparing Values with NaN

Recall that `NaN` returns false when compared with anything else, including itself! To test for `NaN`, use the `Number.isNaN()` function:

```javascript
let foo = NaN;
console.log(Number.isNaN(foo));       // true

console.log(Number.isNaN('hello'));   // false since 'hello' is not NaN
```
