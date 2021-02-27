
# How Closures Affect Garbage Collection - 1/14/2021

## Problems

1. In the following code, when can JavaScript garbage collect the values assigned to the variables `a`, `b`, and `c`?

```javascript
let a = 'abc';

function add(b) {
  a += b;
}

function run() {
  let c = add('xyz');
}

run();
```

### Solution

Theoretically, all values assigned to variables `a` , `b`, and `c` should be retained until after line 11:

* `a` should be preserved in the closures of the `add` and `run` functions.
* `b` is used inside the `add` function which is the last thing called in the `run` function.
* `c` is local to the `run` function and should be preserved in its closure until it's finished.

#### Adjustments based on provided solution

The question does not ask when the *variables* can be garbage collected, but when the *values assigned to the variables* can be garbage collected:

* `a`: answer remains the same - it is accessible to the `add` and `run` functions and should theoretically persist in their closures until they're both finished (after line 11), but modern engines might GC it after line 8 once its value is copied to `c`.
* `b`: can be GC after line 5 once the `add` function finishes.
* `c`:  can be GC after line 9 since it's no longer accessible.

---

2. In the following code, when can JavaScript garbage collect the value `"Steve"`?

```javascript
function makeHello(name) {
  return function() {
    console.log("Hello, " + name + "!");
  };
}

let helloSteve = makeHello("Steve");
```

### Solution

`"Steve"` can't be garbage collected until after line 7 because it should persist in the closure of the anonymous function assigned the variable `helloSteve`.
