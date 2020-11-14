
# JavaScript Style Guide - 8/7/2020

Watch these two lectures by the well known JavaScript teacher, Douglas Crockford:

* https://youtu.be/RO1Wnu-xKoY?t=38m47s
* https://www.youtube.com/watch?v=hQVTIJBZook

With a flexible language like JavaScript, following a good style guide and using a code linter can help avoid the major pitfalls. The [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript) has been widely adopted and offers good style suggestions. [ESLint](https://launchschool.com/gists/9ad96eed) is a static code analyzer that you can use to automate most JavaScript style checks.

## Exercises

Identify the code that violates the Airbnb JavaScript style guide, and update the code to fix the issues you identify. There may be more than one issue in each code snippet.

1.

```javascript
let title = "The Three-Body Problem";
```

### Solution

Use single quotes instead of double quotes:

```javascript
let title = 'The Three-Body Problem';
```

---

2.

```javascript
let title = 'The Three-Body Problem',
    author = 'Cixin Liu',
    page_count = 400;
```

### Solution

Use one `let` or `const` per variable assignment:

```javascript
let title = 'The Three-Body Problem';
let author = 'Cixin Liu';
let page_count = 400;
```

#### Adjustments based on provided solution

Also, variable names should use camelCase: `let pageCount = 400;`.

---

3.

```javascript
let completed = lastPageRead == 400;
```

### Solution

Use the strict equality operator:

```javascript
let completed = lastPageRead === 400;
```

---

4.

```javascript
if (finishedBook())
  console.log('You have finished reading this book');
```

### Solution

Use curly braces with multi-line blocks:

```javascript
if (finishedBook()) {
  console.log('You have finished reading this book');
}
```

---

5.

```javascript
function read(pages) {
      console.log('You started reading.');
      for (let page=0; page<pages; page += 1) {
              let message = 'You read page '+page;
              console.log(message);
      }
}

read(400);
```

### Solution

Whitespace:
* Indent two spaces.
* Put spaces around operators.

Use template strings instead of concatenation.

```javascript
function read(pages) {
  console.log('You started reading.');
  for (let page = 0; page < pages; page += 1) {
    let message = `You read page ${page}`;
    console.log(message);
  }
}

read(400);
```

#### Adjustments based on provided solution

The style guide also recommends named function expressions over function declarations:

```javascript
let read = function read(pages) {
  console.log('You started reading.');
  for (let page = 0; page < pages; page += 1) {
    let message = `You read page ${page}`;
    console.log(message);
  }
};

read(400);
```
