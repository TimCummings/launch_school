
# Practice Problems: Dealing with Context Loss - 12/14/2020

1. Our desired output for the code below is: `Christopher Turk is a Surgeon.`. What will the code output, and what explains the difference, if any, between the actual and desired outputs?

```javascript
let turk = {
  firstName: 'Christopher',
  lastName: 'Turk',
  occupation: 'Surgeon',
  getDescription() {
    return this.firstName + ' ' + this.lastName + ' is a ' + this.occupation + '.';
  }
};

function logReturnVal(func) {
  let returnVal = func();
  console.log(returnVal);
}

logReturnVal(turk.getDescription);
```

### Solution

This code logs: `'undefined undefined is a undefined.'`. The explanation for the different output is that the `getDescription` method is passed as an argument to `logReturnVal` where it's invoked without an explicit context, so JavaScript uses the global object as the context. When `getDescription` is invoked as a function on line 11 with the global object as its implied context, the global object does not have `firstName`, `lastName`, or `occupation` properties, so all three of them evaluate to undefined, which are coerced to the string `'undefined'` when concatenated on line 6.

---

2. Alter `logReturnVal` such that it takes an additional `context` argument, and use one of the methods we've learned in this lesson to invoke `func` inside of `logReturnVal` with `context` as its function execution context. Alter the invocation of `logReturnVal` and supply `turk` as the context argument.

### Solution

```javascript
let turk = {
  firstName: 'Christopher',
  lastName: 'Turk',
  occupation: 'Surgeon',
  getDescription() {
    return this.firstName + ' ' + this.lastName + ' is a ' + this.occupation + '.';
  }
};

function logReturnVal(func, context) {
  let returnVal = func.call(context);
  console.log(returnVal);
}

logReturnVal(turk.getDescription, turk);
```

---

3. Suppose that we want to extract `getDescription` from `turk`, but always have it execute with `turk` as context. Use one of the methods we've learned in the last lesson to assign such a permanently bound function to a new variable, `getTurkDescription`.

### Solution

```javascript
let getTurkDescription = turk.getDescription.bind(turk);
```

---

4. Consider the code below, and our desired output:

```javascript
let TESgames = {
  titles: ['Arena', 'Daggerfall', 'Morrowind', 'Oblivion', 'Skyrim'],
  seriesTitle: 'The Elder Scrolls',
  listGames() {
    this.titles.forEach(function(title) {
      console.log(this.seriesTitle + ' ' + title);
    });
  }
};

TESgames.listGames();
```

Desired output:

```
The Elder Scrolls Arena
The Elder Scrolls Daggerfall
The Elder Scrolls Morrowind
The Elder Scrolls Oblivion
The Elder Scrolls Skyrim
```

Will this code log our desired output? Why or why not?

### Solution

This will not log the desired output; it will instead log:

```
undefined Arena
undefined Daggerfall
undefined Morrowind
undefined Oblivion
undefined Skyrim
```

The reason for the incorrect output is that the `listGames` method invokes `forEach`: the individual titles are accessible because they are the elements through which `forEach` iterates. However, `this` inside `forEach` is the global object because `forEach` is invoked without an explicit context, so JavaScript implicitly uses the global object. Since the global object does not have a `seriesTitle` property, `this.seriesTitle` inside `forEach` evaluates to `undefined`.

---

5. Use an arrow function so that the code logs our desired output.

### Solution

```javascript
let TESgames = {
  titles: ['Arena', 'Daggerfall', 'Morrowind', 'Oblivion', 'Skyrim'],
  seriesTitle: 'The Elder Scrolls',
  listGames() {
    this.titles.forEach(title => console.log(this.seriesTitle + ' ' + title));
  },
};

TESgames.listGames();
```

---

6. Use the `let self = this` fix to alter `TESgames.listGames` such that it logs our desired output to the console.

### Solution

```javascript
let TESgames = {
  titles: ['Arena', 'Daggerfall', 'Morrowind', 'Oblivion', 'Skyrim'],
  seriesTitle: 'The Elder Scrolls',
  listGames() {
    let self = this;
    this.titles.forEach(function(title) {
      console.log(self.seriesTitle + ' ' + title);
    });
  }
};

TESgames.listGames();
```

---

7. If we don't want to rely on `let self = this`, `forEach` provides us with an alternative means of supplying execution context to the inner function. Use this means to achieve our desired output.

### Solution

```javascript
let TESgames = {
  titles: ['Arena', 'Daggerfall', 'Morrowind', 'Oblivion', 'Skyrim'],
  seriesTitle: 'The Elder Scrolls',
  listGames() {
    this.titles.forEach(function(title) {
      console.log(this.seriesTitle + ' ' + title);
    }, this);
  }
};

TESgames.listGames();
```

---

8. Consider the code below:

```javascript
let foo = {
  a: 0,
  incrementA() {
    function increment() {
      this.a += 1;
    }

    increment();
  }
};

foo.incrementA();
foo.incrementA();
foo.incrementA();
```

What will the value of `foo.a` be after this code has executed?

### Solution

After this code has executed, `foo.a` will be `0`: the `increment` function is invoked without an explicit context, so `this` inside `increment` will be the global object. None of the `incrementA` calls modify `foo.a`.

---

9. Use one of the methods we learned in this lesson to invoke `increment` with explicit context such that `foo.a` is incremented with each invocation of `incrementA`.

### Solution

```javascript
let foo = {
  a: 0,
  incrementA() {
    function increment() {
      this.a += 1;
    }

    increment.call(this);
  }
};
```

---

10. We decide that we want each invocation of `foo.incrementA` to increment `foo.a` by `3`, rather than `1`, and alter our code accordingly:

```javascript
let foo = {
  a: 0,
  incrementA() {
    function increment() {
      this.a += 1;
    }

    increment.apply(this);
    increment.apply(this);
    increment.apply(this);
  }
};
```

Calling `apply` three times seems repetitive, though. Use `bind` to permanently set `foo` as `increment`'s execution context.

### Solution

```javascript
let foo = {
  a: 0,
  incrementA() {
    let increment = function() {
      this.a += 1;
    }.bind(this);

    increment();
    increment();
    increment();
  }
};

foo.incrementA();
console.log(foo.a);
```
