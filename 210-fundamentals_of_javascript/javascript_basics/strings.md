
# Strings - 10/21/2020

## Special Characters

* Strings can hold any UTF-16 character.
* characters can be escaped with backslash `\`
* some special characters have their own escape sequence:

| **Code** | **Character**   |
|----------|-----------------|
| `\n`     | newline         |
| `\t`     | tab             |
| `\r`     | carriage return |
| `\v`     | vertical tab    |
| `\b`     | backspace       |

## Concatenation

JavaScript always performs concatenation (not addition) when `+` is used with a string operand.

```javascript
let firstName = 'John';
let lastName = 'Doe';
firstName + ' ' + lastName;  // "John Doe"
```

## Character Access

Strings act as a collection of characters. Individual characters can be accessed via (zero based) index with `String.prototype.charAt()` or with bracket notation:

```javascript
'hello'.charAt(1);  // "e"

'hello'[1];         // "e"
```

> In some programming languages, such as Ruby, bracket notation is a method. In JavaScript, it is actually an operator.

## String Length

Strings also have a length property: `'hello'.length; // 5`.

## Working with Long Strings

Use concatenation or escape newlines (but make sure there is no extra whitespace at the start or end of any of the lines):

```javascript
// concatenation
let lipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ' +
             'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut ' +
             'enim ad minim veniam, quis nostrud exercitation ullamco laboris ' +
             'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor ' +
             'in reprehenderit in voluptate velit esse cillum dolore eu fugiat ' +
             'nulla pariatur. Excepteur sint occaecat cupidatat non proident, ' +
             'sunt in culpa qui officia deserunt mollit anim id est laborum.';

// escaping newlines
let lipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do \
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut \
enim ad minim veniam, quis nostrud exercitation ullamco laboris \
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor \
in reprehenderit in voluptate velit esse cillum dolore eu fugiat \
nulla pariatur. Excepteur sint occaecat cupidatat non proident, \
sunt in culpa qui officia deserunt mollit anim id est laborum.';
```

## Built-in String Methods

Reference [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype).
