
# Practice Problems: Garbage Collection - 1/14/2021

1. Is JavaScript a garbage-collected language, and if so, what does this entail?

### Solution

JavaScript is a garbage collected language, which mainly entails automatic instead of manual memory management. The JavaScript runtime will periodically attempt to detect which values are no longer reachable so that it can deallocate the memory in which those values are stored, freeing the memory up for other uses.

---

2. Consider the code below:

```javascript
let myNum = 1;

function foo() {
  let myStr = 'A string';
  // what is eligible for GC here?
}

foo();

// what is eligible for GC here?

// more code
```

Are either of the values `1` or `'A string'` eligible for garbage collection on line 5? What about on line 10?

### Solution

`'A string'` is eligible for garbage collection on line 5. We can't say when `1` is elligible for garbage collection without knowing what exactly the `// more code` is on line 12.

#### Adjustments based on provided solution

`1` is a primitive value and is (usually) not subject to GC.

`'A String'` is eligible for GC on line 10 after the function `foo` finishes running.

---

3. In the code below, is the value of `outerFoo` eligible for garbage collection on line 10?

```javascript
let outerFoo;

function bar() {
  let innerFoo = 'abc';
  outerFoo = innerFoo;
}

bar();

// can outerFoo's value be garbage collected here?

// more code
```

### Solution

No, because it is still in scope and could be referenced on the `// more code`.

---

4. Consider the code below:

```javascript
function makeString() {
  let index = 'abc';
  return function() {
    return index += 'xyz';
  };
}

let str = makeString();

// is 'abc' eligible for GC here?

// more code
```

Is `'abc'` eligible for garbage collection on line 10?

### Solution

No, because it is still referenced in the closure of the anonymous function that is referenced by the variable `str`.

---

5. Consider the script below:

```javascript
let bash = "Some val";
```

Will the value `"Some val"` ever be eligible for garbage collection?

### Solution

Since `"Some val"` is in the global scope, it will be eligible for GC once the program finishes running.
