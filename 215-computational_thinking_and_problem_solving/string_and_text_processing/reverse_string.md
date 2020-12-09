
# Reverse a String - 11/19/2020

Implement a function that takes a string as an argument and returns a new string that contains the original string in reverse.

Examples

```javascript
function reverse(string) {
  // ...
}

reverse('hello');                  // returns "olleh"
reverse('The quick brown fox');    // returns "xof nworb kciuq ehT"
```

### Solution

```javascript
let reverse = function reverse(string) {
  return string.split('').reverse().join('');
};
```
