
# Stepping through Object Properties - 11/2/2020

Objects are a collection type. You can iterate through an object's values with a `for_in` loop:

```javascript
let nicknames = {
  joseph: 'Joey',
  margaret: 'Maggie',
};

for (let nick in nicknames) {
  console.log(nick);
  console.log(nicknames[nick]);
}

// logs:
// joseph
// Joey
// margaret
// Maggie
```

You can also retrieve the names of all of an object's properties in an array with `Object.keys()`:

```javascript
Object.keys(nicknames);   // [ 'joseph', 'margaret' ]
```

## Further Reading

See [this article](https://medium.com/launch-school/javascript-weekly-an-introduction-to-iteration-and-enumerability-70bb1054064a) by one of our students.
