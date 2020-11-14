
# Function Invocations and Arguments - 10/22/2020

The standard way to invoke a function is to append `()` to its name:

```javascript
function startle() {
  console.log('Yikes!');
}

startle();
// => Yikes!
```

Function names are nothing special: they are just local variables that happen to have a function as a value. Since `start` is just a local variable, we can assign it to a new local variable and call it using that new name:

```javascript
let surprise = startle;
surprise();

// => Yikes!
```

> There are several other ways to invoke a function in JavaScript; we'll discuss them later.

Many functions require parameters to fulfill their purpose; when invoking a function, we call these values *arguments* and specify them as a list of names between the parentheses:

```javascript
function takeTwo(a, b) {
  console.log(a);
  console.log(b);
  console.log(a + b);
}

takeTwo(1, 2);
// => 1
// => 2
// => 3
```

What happens if we omit an argument?

```javascript
takeTwo(1);

// => 1
// undefined
// NaN
```

Note:

1. Calling a function with too few arguments *does not raise an error*!
2. Within a function, an argument that wasn't provided in the call will have the value `undefined`.
3. The `NaN` result isn't directly a result of the missing parameter; it's just the result of adding a number and `undefined`.

You can also pass too many arguments to a function without raising an error:

```javascript
takeTwo(1, 2, 4);

// => 1
// => 2
// => 3
```
