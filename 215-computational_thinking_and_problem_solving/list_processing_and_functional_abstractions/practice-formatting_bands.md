
# Practice Problem: Formatting Bands - 11/16/2020

We have the following Array of information for some popular bands:

```javascript
let bands = [
  { name: 'sunset rubdown', country: 'UK', active: false },
  { name: 'women', country: 'Germany', active: false },
  { name: 'a silver mt. zion', country: 'Spain', active: true },
];
```

There are problems with this data, though, so we first have to clean it up before we can use it:

* The band countries are wrong: all the bands should have 'Canada' as the country.
* The band name should have all words capitalized.
* Remove all dots from the band names.

Write a function that can process the input band Array and return an Array that contains the fixed information:

```javascript
let bands = [
  { name: 'sunset rubdown', country: 'UK', active: false },
  { name: 'women', country: 'Germany', active: false },
  { name: 'a silver mt. zion', country: 'Spain', active: true },
];

function processBands(data) {
  // ...
}

processBands(bands);

// should return:
[
  { name: 'Sunset Rubdown', country: 'Canada', active: false },
  { name: 'Women', country: 'Canada', active: false },
  { name: 'A Silver Mt Zion', country: 'Canada', active: true },
]
```

### Solution

Overall, this looks like a transformation (map): each array element can be passed into a format function, which calls other functions for each clean up step.

```javascript
let capitalizeWords = function capitalizeWords(phrase) {
  let words = phrase.split(' ').map(word => {
    return word[0].toUpperCase() + word.slice(1);
  });

  return words.join(' ');
};

let processBand = function processBand(band) {
  let bandCopy = {...band};
  bandCopy.country = 'Canada';
  bandCopy.name = capitalizeWords(bandCopy.name);
  bandCopy.name = bandCopy.name.replace(/\./g, '');
  return bandCopy;
};

let processBands = function processBands(data) {
  return data.map(processBand);
};
```

#### Adjustments based on provided solution

The `processBand`function is an unnecessary layer of abstraction; just put its contents inside `map`'s callback function:

```javascript
let capitalizeWords = function capitalizeWords(phrase) {
  let words = phrase.split(' ').map(word => {
    return word[0].toUpperCase() + word.slice(1);
  });

  return words.join(' ');
};

let processBands = function processBands(data) {
  return data.map(band => {
    let bandCopy = {...band};
    bandCopy.country = 'Canada';
    bandCopy.name = capitalizeWords(bandCopy.name);
    bandCopy.name = bandCopy.name.replace(/\./g, '');
    return bandCopy;
  });
};
```
