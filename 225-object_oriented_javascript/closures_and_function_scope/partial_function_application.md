
# Partial Function Application - 1/18/2021

## Problems

1. Write a function named `greet` that takes two arguments and logs a greeting:

```javascript
> greet('howdy', 'Joe');
Howdy, Joe!
> greet('good morning', 'Sue');
Good morning, Sue!
```

### Solution

```javascript
function greet(greeting, name) {
  console.log(`${greeting}, ${name}!`);
}
```

---

2. Use the `partial` function shown above and your solution to problem 1 to create `sayHello` and `sayHi` functions that work like this:

```javascript
> sayHello('Brandon');
Hello, Brandon!
> sayHi('Sarah');
Hi, Sarah!
```

### Solution

```javascript
let sayHello = partial(greet, 'Hello');
let sayHi = partial(greet, 'Hi');
```
