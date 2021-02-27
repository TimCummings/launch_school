
# Practice Problems: IIFEs - 1/20/2021

1. Will the code below execute?

```javascript
function() {
  console.log("Sometimes, syntax isn't intuitive!")
}();
```

### Solution

No; this is invalid JavaScript syntax.

---

2. Edit the code from problem one so it executes without error.

### Solution

```javascript
(function() {
  console.log("Sometimes, syntax isn't intuitive!");
})();

// or...

(function() {
  console.log("Sometimes, syntax isn't intuitive!");
}());
```

---

3. The code below throws an error:

```javascript
var sum = 0;
var numbers;

sum += 10;
sum += 31;

numbers = [1, 7, -3, 3];

function sum(arr) {
  return arr.reduce(function(sum, number) {
    sum += number;
    return sum;
  }, 0);
}

sum += sum(numbers);  // ?
```

What kind of problem does this error highlight? Use an IIFE to address it, so that code runs without error.

### Solution

The main issue is that `sum` is being used to refer to several different things: a function and a number. Hoisting also contributes to the problems here, but that could be avoided with more clear variable names. When `sum` is invoked on line 16, it's a number, not a function, which raises a type error.

```javascript
var sum = 0;
var numbers;

sum += 10;
sum += 31;

numbers = [1, 7, -3, 3];

sum += (function(arr) {
  return arr.reduce(function(sum, number) {
    sum += number;
    return sum;
  }, 0);
})(numbers);

console.log(sum);
```

---

4. Consider the output below:

```javascript
countdown(7);
7
6
5
4
3
2
1
0
Done!
```

Implement a function `countdown` that uses an IIFE to generate the desired output.

### Solution

```javascript
function countdown(start) {
  (function(number) {
    do {
      console.log(number);
      number -= 1;
    } while (number >= 0);
    console.log('Done!');
  })(start);
}

countdown(7);
```

---

5. Is the named function in this IIFE accessible in the global scope?

```javascript
(function foo() {
  console.log('Bar');
})();

foo() // ?
```

### Solution

No. The IIFE, being a function, establishes its own scope which is not accessible to outer scopes such as the global scope.

---

6. For an extra challenge, refactor the solution to problem 4 using recursion, bearing in mind that a named function created in an IIFE can be referenced inside of the IIFE.

### Solution

```javascript
function countdown(start) {
  (function logAndDecrement(number) {
    if (number >= 0) {
      console.log(number);
      logAndDecrement(number - 1);
    } else {
      console.log('Done!');
    }
  })(start);
}

countdown(7);
```
