
# Practice Problem: Repeated Characters - 11/4/2020

Implement a function that takes a `String` as an argument and returns an object that contains a count of the **repeated** characters.

```javascript
repeatedCharacters('Programming');    // { r: 2, g: 2, m: 2 }
repeatedCharacters('Combination');    // { o: 2, i: 2, n: 2 }
repeatedCharacters('Pet');            // {}
repeatedCharacters('Paper');          // { p: 2 }
repeatedCharacters('Baseless');       // { s: 3, e: 2 }
```

Note that `repeatedCharacters` does a bit more than simply count the frequency of each character: it determines the counts, but only returns counts for characters that have a count of 2 or more. It also ignores the case.

### Solution

```javascript
function repeatedCharacters(string) {
  let charCounts = {};

  for (let index = 0; index < string.length; index += 1) {
    let char = string[index].toLowerCase();
    if (charCounts[char] === undefined) charCounts[char] = 0;
    charCounts[char] += 1;
  }

  for (char in charCounts) {
    if (charCounts[char] < 2) delete charCounts[char];
  }

  return charCounts;
}
```
