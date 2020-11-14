
# Errors - 11/9/2020

## Common Error Types

### ReferenceError

A `ReferenceError` occurs when you attempt to use a variable or function that doesn't exist:

```javascript
a;
a();
```

### TypeError

A `TypeError` usually occurs when you try to access a property on a value that does not have any properties, such as `null`. Trying to call something that isn't a function can also raise a `TypeError`:

```javascript
var a;
typeof(a);   // undefined

a.name;      // TypeError: Cannot read property 'name' of undefined

a = 1;
a();         // TypeError: Property 'a' is not a function
```

### SyntaxError

A `SyntaxError` is special in that one usually occurs immediately after loading a JavaScript program and before it begins to run. Unlike `ReferenceError` and `TypeError`, which are dependent upon specific variables and values encountered at runtime, JavaScript detects `SyntaxError`s solely from the text of your program.

```javascript
function ( {}   // SyntaxError: Unexpected token (
```

```javascript
JSON.parse('not really JSON');   // SyntaxError: Unexpected token i in JSON at position 0
```

## Preventing Errors

Errors typically occur where assumptions are made in code. Thus, a good way to prevent them is to plan your code in advance and consider the possible combinations of inputs as well as edge cases (where the input might be different in some way than would generally be expected, e.g. an empty string, a string that begins and/or ends with whitespace, etc.

Within your programs, your code should generally be able to trust other parts of itself, but for situations where you can't be sure of the input you're receiving, e.g. user input, consider using appropriate guard clauses:

```javascript
function lowerInitial(word) {
  return word[0].toLowerCase();
}

lowerInitial('Joe');     // "j"
lowerInitial('Karen');   // "k"

// But what happens when we pass an empty string?
lowerInitial('');        // TypeError: cannot read property 'toLowerCase' of undefined
```

Let's rewrite `lowerInitial` with a guard clause:

```javascript
function lowerInitial(word) {
  if (word.length === 0) {
    return '-';
  }

  return word[0].toLowerCase();
}

lowerInitial('');   // '-'
```

## Catching Errors

It's not possible to prevent all errors. Consider the previous JSON parsing example:

```javascript
JSON.parse('not really JSON');   // SyntaxError: Unexpected token i in JSON at position 0
```

The only way to prevent errors in `JSON.parse` is to parse the input string... which is what `JSON.parse` does. It's not practical to try to re-implement a stricter JSON parser in order to prevent errors in `JSON.parse`; avoiding errors here isn't realistic. Instead, we can try to catch errors `JSON.parse` might throw with a `try/catch/finally` block (syntactically similar to an `if/else` block:

```javascript
try {
  // do something here that might fail and throw an error
} catch (error) {
  // this clause only runs if something in the try clause throws an error
  // `error` will contain the Error object
} finally {
  // this clause always runs, whether an error is thrown in the try clause or not
  // finally is optional and may be omitted
}
```

Let's use a `try/catch/finally` block with `JSON.parse`:

```javascript
function parseJSON(data) {
  let result;

  try {
    result = JSON.parse(data);
  } catch (e) {
    console.log('There was a', e.name, 'parsing JSON data:', e.message);
    result = null;
  } finally {
    console.log('Finished parsing data.');
  }

  return result;
}

parseJSON('not valid JSON');
// logs: "There was a SyntaxError parsing JSON data: Unexpected token i in JSON at position 0"
// logs: "Finished parsing data."
// returns: null
```

### When to Use Try/Catch

Only use `try/catch/finally` when both of these are true:

* A built-in JavaScript function or method can throw an Error and you need to handled or prevent it.
* A guard clause is impossible or impractical.

> JSON strings look a lot like JavaScript object literals. The main differences are that we double quote the keys, and the literal value appears inside a String:
>
> ```javascript
> let object = { 'name': 'Ferdinand', 'age': 13 };  // object literal
> let json = '{ "name": "Ferdinand", "age": 13 }';  // JSON string
> ```
>
> We'll learn more about JSON later when we learn how to use JavaScript to connect to servers.
