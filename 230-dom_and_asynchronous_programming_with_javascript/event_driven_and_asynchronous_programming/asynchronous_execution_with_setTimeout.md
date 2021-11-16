
# Asynchronous Execution with setTimeout - 3/5/2021

## Problems

1. Write a JavaScript function named `delayLog` that loops through the numbers from 1 to 10, and logs each number after that number of seconds. It should log `1` after 1 second, `2` after 2 seconds, etc. Note that the computation of the time is not dependent on when a previous number was logged. This means that for 10 numbers a total of 10 seconds would have passed.

```
> delayLog();
1  // 1 second later
2  // 2 seconds later
3  // 3 seconds later
4  // etc...
5
6
7
8
9
10
```

### Solution

```javascript
function delayLog() {
  for (let seconds = 1; seconds <= 10; seconds += 1) {
    setTimeout(() => console.log(seconds), seconds * 1000);
  }
}
```

---

2. In what sequence will the JavaScript runtime run the following lines of code? Number them from 1-8 to show the order of execution.

```javascript
setTimeout(() => {
  console.log('Once');
}, 1000);

setTimeout(() => {
  console.log('upon');
}, 3000);

setTimeout(() => {
  console.log('a');
}, 2000);

setTimeout(() => {
  console.log('time');
}, 4000);
```

### Solution

```javascript
setTimeout(() => {       // 1
  console.log('Once');   // 5
}, 1000);

setTimeout(() => {       // 2
  console.log('upon');   // 7
}, 3000);

setTimeout(() => {       // 3
  console.log('a');      // 6
}, 2000);

setTimeout(() => {       // 4
  console.log('time');   // 8
}, 4000);
```

---

3. In what sequence does the JavaScript runtime run the functions `q`, `d`, `n`, `z`, `s`, `f`, and `g` in the following code?

```javascript
setTimeout(() => {
  setTimeout(() => {
    q();
  }, 15);

  d();

  setTimeout(() => {
    n();
  }, 5);

  z();
}, 10);

setTimeout(() => {
  s();
}, 20);

setTimeout(() => {
  f();
});

g();
```

### Solution

The functions run in the following order: `f`, `g`, `d`, `z`, `n`, `s`, `q`.

#### Adjustments based on provided solution

`g` still runs before `f`: https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/setTimeout. This behavior will be discussed in a later lesson in regards to the event cycle.

Note: It's possible for `setTimeout`s to fluctuate up to ~50ish milliseconds, and results can differ from what is expected when several timeouts are close to one another.

---

4. Write a function named `afterNSeconds` that takes two arguments: a callback and a time duration in seconds. The function should wait for the indicated period, then invoke the callback function.

### Solution

```javascript
function afterNSeconds(callback, seconds) {
  setTimeout(callback, seconds * 1000);
}
```
