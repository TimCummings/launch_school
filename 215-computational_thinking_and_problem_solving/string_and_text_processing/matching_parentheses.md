
# Matching Parentheses - 11/19/2020

Write a function that takes a string as an argument and returns `true` if the string contains properly balanced parentheses, `false` otherwise. Parentheses are properly balanced only when `'('` and `')'` occur in matching pairs, with each pair starting with `'('`.

Examples

```javascript
isBalanced('What (is) this?');        // true
isBalanced('What is) this?');         // false
isBalanced('What (is this?');         // false
isBalanced('((What) (is this))?');    // true
isBalanced('((What)) (is this))?');   // false
isBalanced('Hey!');                   // true
isBalanced(')Hey!(');                 // false
isBalanced('What ((is))) up(');       // false
```

### Solution

```javascript
let isBalanced = function isBalanced(string) {
  let counter = 0;

  for (let index = 0; index < string.length; index += 1) {
    if (string[index] === '(') counter += 1;
    if (string[index] === ')') counter -= 1;

    if (counter < 0) return false;
  }

  return counter === 0;
};
```
