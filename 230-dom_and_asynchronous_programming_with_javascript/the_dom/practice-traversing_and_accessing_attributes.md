
# Practice Problems: Traversing and Accessing Attributes - 3/2/2021

Use the following HTML to solve these practice problems:

```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>On the River</title>
  </head>
  <body>
    <h1>On the River</h1>
    <p>A poem by Paul Laurence Dunbar</p>

    <p>
      The sun is low,<br>
      The waters flow,<br>
      My boat is dancing to and fro.<br>
      The eve is still,<br>
      Yet from the hill<br>
      The killdeer echoes loud and shrill.
    </p>
    <p>
      The paddles plash,<br>
      The wavelets dash,<br>
      We see the summer lightning flash;<br>
      While now and then,<br>
      In marsh and fen<br>
      Too muddy for the feet of men,
    </p>
    <p>
      Where neither bird<br>
      Nor beast has stirred,<br>
      The spotted bullfrog's croak is heard.<br>
      The wind is high,<br>
      The grasses sigh,<br>
      The sluggish stream goes sobbing by.
    </p>
    <p>
      And far away<br>
      The dying day<br>
      Has cast its last effulgent ray;<br>
      While on the land<br>
      The shadows stand<br>
      Proclaiming that the eve's at hand.
    </p>
  </body>
</html>
```

> You may use the `walk` function we looked at earlier:
> 
> ```javascript
> function walk(node, callback) {
>   callback(node);
>
>   for (let index = 0; index < node.childNodes.length; index += 1) {
>     walk(node.childNodes[index], callback);
>   }
> }
> ```
>
> You may also use any DOM traversal methods we've discussed so far **except** `querySelector` and `querySelectorAll`.

## Problems

1. Starting with the `document` node, use the `lastChild` and `childNodes` properties to change the text color to red on the `On the River` heading and set its font size 48 pixels.

#### Solution

```javascript
let heading = document.lastChild.lastChild.childNodes[1];
heading.style.color = 'red';
heading.style.fontSize = '48px';
```

---

2. Count the paragraphs on the page, and then log the result.

### Solution

```javascript
let pCount = 0;

(function findPs(node) {
  if (node.tagName === 'P') pCount += 1;

  node.childNodes.forEach(findPs);
})();
```

console.log(pCount);   // 5

---

3. Retrieve the first word from each paragraph on the page and log the entire list.

> Hint: You can use the `data` property to retrieve the textual content of a text node. This property belongs to the `CharacterData` DOM interface. It represents the textual data in the node as a `DOMString` object, which is a String-like object you can treat as a string.

### Solution

```javascript
function walk(node, callback) {
  callback(node);

  for (let index = 0; index < node.childNodes.length; index += 1) {
    walk(node.childNodes[index], callback);
  }
}

const firstWordMatcher = /\s*\w+\b/;
let firstWords = [];

walk(document, node => {
  if (node.nodeName === 'P') {
    let content = node.textContent;
    let firstWord = content.match(firstWordMatcher)[0];
    firstWords.push(firstWord.trim());
  }
});

console.log(firstWords);
```

---

4. Add the class `stanza` to each paragraph *except* the first.

### Solution

```javascript
let pIsFirst = true;

walk(document, node => {
  if (node.nodeName === 'P') {
    if (pIsFirst) {
      pIsFirst = false;
      return;
    }

    node.classList.add('stanza');
  }
});
```

---

> For the remaining practice problems, please use the [HTML*](https://d3905n0khyu9wc.cloudfront.net/the_dom/polar_bear_wiki.html) of [this Wikipedia page](https://en.wikipedia.org/wiki/Polar_bear).
>
> *\*The HTML was extracted to get a consistent outcome even if the actual article changes (date extracted: 3/31/18)*

5. Count the images on the page, then count the PNG images. Log both results.

### Solution

```javascript
let images = [];

walk(document, node => {
  if (node.nodeName === 'IMG') images.push(node);
});

let imageCount = images.length;
let pngCount = images.filter(img => {
  return /.png$/.test(img.src.toLowerCase());
}).length;

console.log(imageCount);   // 48
console.log(pngCount);     // 23
```

---

6. Change the link color to red for every link on the page.

### Solution

```javascript
walk(document, node => {
  if (node.nodeName === 'A' && node.hasAttribute('href')) {
    node.style.color = 'red';
  }
});
```
