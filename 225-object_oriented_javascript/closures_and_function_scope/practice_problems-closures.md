
# Practice Problems: Closures Functions - 1/1/2021

1. Write a function named `makeMultipleLister` that, when invoked and passed a number, returns a function that logs every positive integer multiple of that number less than 100. Usage looks like this:

```javascript
> let lister = makeMultipleLister(13);
> lister();
13
26
39
52
65
78
91
```

### Solution

```javascript
function makeMultipleLister(factor) {
  return function() {
    for (let counter = factor; counter < 100; counter += factor) {
      console.log(counter);
    }
  };
}
```

---

2. Write a program that uses two functions, `add` and `subtract`, to manipulate a running total value. When you invoke either function with a number, it should add or subtract that number from the running total and log the new total to the console. Usage looks like this:

```javascript
> add(1);
1
> add(42);
43
> subtract(39);
4
> add(6);
10
```

### Solution

```javascript
function add(number) {
  total += number;
  console.log(total);
}

function subtract(number) {
  total -= number;
  console.log(total);
}

let total = 0;

add(1);
add(42);
subtract(39);
add(6);
```

---

3. Write a function named `later` that takes two arguments: a function and an argument for that function. The return value should be a new function that calls the input function with the provided argument, like this:

```javascript
> let logWarning = later(console.log, 'The system is shutting down!');
> logWarning();
The system is shutting down!
```

### Solution

```javascript
function later(func, argument) {
  return function() {
    func(argument);
  };
}
```

---

4. Given the following code:

```javascript
function startup() {
  let status = 'ready';
  return function() {
    console.log('The system is ready.');
  };
}

let ready = startup();
let systemStatus = // ?
```

How can you set the value of `systemStatus` to the value of the inner variable `status` without changing `startup` in any way?

### Solution

You can't. The `status` variable is essentially private outside the `startup` function. The `status` variable is in scope of the function assigned to `ready`, but we can't do anything with it without modifying the `startup` function.
