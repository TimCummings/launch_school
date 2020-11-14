
# Practice Problems: Working with Object Properties

1. Write a function named `objectHasProperty` that takes two arguments: an Object and a String. The function should return true if the Object contains a property with the name given by the String, false otherwise.

```javascript
let pets = {
  cat: 'Simon',
  dog: 'Dwarf',
  mice: null,
};

objectHasProperty(pets, 'dog');       // true
objectHasProperty(pets, 'lizard');    // false
objectHasProperty(pets, 'mice');      // true
```

### Solution

```javascript
function objectHasProperty(object, string) {
  return Object.keys(object).includes(string);
}
```

---

2. Write a function named `incrementProperty` that takes two arguments: an Object and a String. If the Object contains a property with the specified name, the function should increment the value of that property. If the property does not exist, the function should add a new property with a value of `1`. The function should return the new value of the property.

```javascript
let wins = {
  steve: 3,
  susie: 4,
};

incrementProperty(wins, 'susie');   // 5
wins;                               // { steve: 3, susie: 5 }
incrementProperty(wins, 'lucy');    // 1
wins;                               // { steve: 3, susie: 5, lucy: 1 }
```

### Solution

```javascript
function objectHasProperty(object, string) {
  return Object.keys(object).includes(string);
}

function incrementProperty(object, string) {
  if !objectHasProperty(object, string) object[string] = 0;
  return object[string] += 1;
}
```

---

3. Write a function named `copyProperties` that takes two Objects as arguments. The function should copy all properties from the first object to the second. The function should return the number of properties copied.

```javascript
let hal = {
  model: 9000,
  enabled: true,
};

let sal = {};
copyProperties(hal, sal);  // 2
sal;                       // { model: 9000, enabled: true }
```

### Solution

```javascript
function copyProperties(object1, object2) {
  let keys = Object.keys(object1);
  keys.forEach(key => object2[key] = object1[key]);
  return keys.length;
}
```

---

4. Write a function named `wordCount` that takes a single String as an argument. The function should return an Object that contains the counts of each word that appears in the provided String. In the returned Object, you should use the words as keys, and the counts as values.

```javascript
wordCount('box car cat bag box');  // { box: 2, car: 1, cat: 1, bag: 1 }
```

### Solution

```javascript
function wordCount(string) {
  let words = string.split(' ');
  let counts = {};

  words.forEach(word => {
    if (counts[word]) {
      counts[word] += 1;
    } else {
      counts[word] = 1;
    }
  });

  return counts;
}
```
