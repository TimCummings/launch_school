
# Repeating Execution with setInterval - 3/5/2021

## Problems

1. Write a function named `startCounting` that logs a number to the console every second, starting with `1`. Each number should be one greater than the previous number.

### Solution

```javascript
function startCounting() {
  let counter = 1;
  return setInterval(() => {
    console.log(counter);
    counter += 1;
  }, 1000);
}
```

---

2. Extend the code from the previous problem with a `stopCounting` function that stops the logger when called.

### Solution

The value returned by `startCounting` needs to be assigned to the `countingId` variable for this to work.

```javascript
function stopCounting() {
  clearInterval(countingId);
}
```
