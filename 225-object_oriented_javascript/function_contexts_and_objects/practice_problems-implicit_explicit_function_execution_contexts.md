
# Practice Problems: Implicit and Explicit Function Execution Contexts - 12/10/2020

> Be sure to use Chrome Snippets for this assignment. You can use other browser tools or Node, but we will assume that you're using Chrome. If you do use Node or another browser, you may see different results and even experience errors. We introduce Chrome Snippets in [this assignment](https://launchschool.com/lessons/c9200ad2/assignments/c8e3c9a4).

1. What will the code below output?

```javascript
function foo() {
  return this;
}

let context = foo();
console.log(context);
```

### Solution

This will log the global object, which is `window` in a browser.

---

2. What will the code in the previous question output in strict mode?

### Solution

In strict mode, this will log `undefined`.

---

3. What will the code below output? Explain the difference, if any, between this output and that of problem 1.

```javascript
let obj = {
  foo() {
    return this;
  },
};

let context = obj.foo();

console.log(context);
```

### Solution

This will log the `obj` object, which in the browser console looks like `{foo: f}`. The difference is that problem 1 invokes the `foo` function without a calling object, so JavaScript implicitly binds `foo` to the global object at function invocation on line 5. In problem 3, `foo` is invoked as a method of the `obj` object, so JavaScript binds it to the `obj` object.

---

4. What will the code below output?

```javascript
var message = 'Hello from the global scope!';

function deliverMessage() {
  console.log(this.message);
}

deliverMessage();

let bar = {
  message: 'Hello from the function scope!',
};

bar.deliverMessage = deliverMessage;

bar.deliverMessage();
```

### Solution

This logs:

```
'Hello from the global scope!'
'Hello from the function scope!'
```

---

5. What will the code below output? What would happen if we replaced `var` on line 1 with `let`? Can you explain why the output changes?

```javascript
var a = 10;
let b = 10;
let c = {
  a: -10,
  b: -10,
};

function add() {
  return this.a + b;
}

c.add = add;

console.log(add());
console.log(c.add());
```

### Solution

This logs:

```
20
0
```

If we replaced `var` on line 1 with `let`, this would log:

```
NaN
0
```

The output changes because variables declared in the global scope with `let` or `const` are not added as properties of the global object, unlike `var` variables. So, on line 14 when the `add` function is evaluated with the global object as the implicit execution context, `this.a` is equivalent to `window.a`; the global object does not have a property of `a` so it evaluates to `undefined`. `undefined` plus a number evaluates to `undefined`, which is logged to the console.

---

6. The problems above all feature *implicit* function execution context. What methods have we learned so far that let us explicitly specify what a function's execution context should be?

### Solution

`Function.prototype.call` and `Function.prototype.apply`.

---

7. In the code below, use `call` to invoke `add` as a method on `bar`, but with `foo` as the execution context. What will this return?

```javascript
let foo = {
  a: 1,
  b: 2,
};

let bar = {
   a: 'abc',
   b: 'def',
   add() {
     return this.a + this.b;
   },
};
```

### Solution

```javascript
bar.add.call(foo);   // 3
```

---

8. Given the code and desired output shown below, should you use `call` or `apply` to supply explicit context and the arguments to `outputList`? That is, which method makes the most sense to use? Implement a solution using your preferred method such that the desired output is logged, and explain your choice.

```javascript
let fruitsObj = {
  list: ['Apple', 'Banana', 'Grapefruit', 'Pineapple', 'Orange'],
  title: 'A Collection of Fruit',
};

function outputList() {
  console.log(this.title + ':');

  let args = [].slice.call(arguments);

  args.forEach(function(elem) {
    console.log(elem);
  });
}

// invoke outputList here
```

Desired output:

```
A Collection of Fruit:
Apple
Banana
Grapefruit
Pineapple
Orange
```

### Solution

```javascript
outputList.apply(fruitsObj, fruitsObj.list);
```

`Function.prototype.apply` makes more sense here, since `fruitsObj` already has its list of fruits as an array. `apply` takes an array of arguments as the its second argument, and then it provides the elements of that array as arguments to the calling function.

---

9. For an extra challenge, consider this line of code from the previous problem:

```javascript
let args = [].slice.call(arguments);
```

Inside of JavaScript functions, `arguments` is an object that holds all of the arguments passed to the function. Bearing in mind that the function author wants to iterate over the arguments later in the method using an `Array` method, why do you think he or she is invoking `call`?

### Solution

`arguments` is an array-*like* object, but it is *not* an array and does not have access to `Array` methods like `slice` and `forEach`. The author invokes `call` in this way to copy arguments from the `arguments` object into an actual array for easier handling later. Alternatively, the author could use `call` with `forEach`, although it's not as clean since `forEach` expects a callback function as an argument:

```javascript
[].forEach.call(arguments, function(elem) {
      console.log(elem);
  });
```
