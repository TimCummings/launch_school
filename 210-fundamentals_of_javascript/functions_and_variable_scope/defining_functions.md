
# Defining Functions - 10/22/2020

Most programming languages let you build constructs called **procedures** to extract common code to one place and use it from anywhere else in your program. In JavaScript, we use the term **functions** to refer to procedures.

One way to define functions is to declare them. A function declaration has the following structure:

* the `function` keyword
* the name of the function
* a list of comma separated parameters
* a block of statements (the function body)

```javascript
function triple(number) {
  console.log('tripling in process...');
  return number + number + number;
}

// call function with a value argument
console.log(triple(5));            // logs 15

// call function with a variable argument
let someNumber = 5;
console.log(triple(someNumber));   // logs 15

// call function and store result in a variable
let result = triple(5);
console.log(result);               // logs 15
```

> If a function does not contain an explicit `return` statement, or the `return` statement does not include a value, the function implicitly returns the value `undefined`. This is a reason why functions are said to "have returned" rather than "finished execution". When we talk about closures in a later course this distinction will become more apparent. For now, just be mindful of the disambiguation between the `return` value (explicit or implicit) of a function and the statement that a "*function that has returned or returns*".
