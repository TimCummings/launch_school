
# Practice Problems: Finding Nodes and Traversing Elements - 3/3/2021

For the following practice problems, please use the [HTML](https://d3905n0khyu9wc.cloudfront.net/the_dom/polar_bear_wiki.html)* of [this Wikipedia page](https://en.wikipedia.org/wiki/Polar_bear).

> *The HTML was extracted to get a consistent outcome even if the actual article changes (date extracted: 3/31/18)

1. Write some JavaScript code to retrieve a word count for each `h2` heading on the page.

### Solution

```javascript
let h2s = Array.from(document.getElementsByTagName('h2'));
let separator = new RegExp(/\s+/, 'g');
let wordCounts = h2s.map(h2 => h2.textContent.split(separator).length);

console.log(wordCounts);
// 1
// 3
// 3
// 3
// 1
// 2
// 4
// 1
// 5
// 2
// 2
// 1
// 1
// 2
// 2
// 2
```

---

2. The page has a table of contents with the title "Contents" and links to the different content sections on "Naming and etymology," "Taxonomy and evolution," etc.

Use three different DOM methods to retrieve a reference to the `div` element that contains the table of contents.

### Solution

```javascript
document.getElementById('toc');
document.querySelector('#toc');
document.getElementsByClassName('toc')[0];
```

---

3. Write some JavaScript code to change the color for every odd indexed link in the table of contents to green.

### Solution

```javascript
// let toc = document.getElementById('toc');
// let tocLinks = toc.getElementsByTagName('a');
let tocLinks = document.querySelectorAll('#toc a');

for (let index = 1; index < tocLinks.length; index += 2) {
  tocLinks[index].style.color = 'green';
}
```

#### Adjustments based on provided solution

A query selector is cleaner here:

`let tocLinks = document.querySelectorAll('#toc a');`

---

4. Write some JavaScript code to retrieve the text of every thumbnail caption on the page.

### Solution

```javascript
let captions = Array.from(document.querySelectorAll('.thumbcaption'));

console.log(captions.map(caption => caption.textContent.trim()));
```

---

5. You can think of the scientific classification of an animal as a series of key-value pairs. Here, the keys are taxonomic ranks (*Domain*, *Kingdom*, *Phylum,* etc.). The values are the specific groups to which the animal belongs.

Write JavaScript code that extracts the classification of animals from the web page and logs an Object that uses the ranks as keys and the groups as values. You may assume the taxonomic ranks to use as keys is provided for you as an array.

### Solution

```javascript
const TAXONOMIC_RANKS = ['Kingdom', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species'];

let tableRows = Array.from(document.querySelectorAll('table.infobox.biota tbody tr'));

let matchingRows = tableRows.filter(row => {
  let firstColText = row.firstElementChild.textContent.trim();
  return TAXONOMIC_RANKS.some(rank => `${rank}:` === firstColText);
});

let classification = {};

matchingRows.forEach(row => {
  let rank = row.children[0].textContent.trim().replace(':', '');
  let group = row.children[1].textContent.trim();

  classification[rank] = group;
});

console.log(classification);
```
