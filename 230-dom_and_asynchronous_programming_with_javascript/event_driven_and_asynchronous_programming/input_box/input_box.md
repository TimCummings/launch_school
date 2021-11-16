
# Assignment: Build an Input Box - 5/6/2021

In this assignment, we'll use HTML, CSS, and JavaScript to build an approximation of an `input` element. You'll never do this in a real project, but doing so here gives us an opportunity to create an interface that must handle more than one event type.

We'll use the following HTML and CSS for this problem:

```html
<div class="text-field">
  <div class="content"></div>
</div>
```

```css
.text-field {
  border: solid 1px #ccc;
  padding: 1em;
  cursor: pointer;
  font-family: sans-serif;
  font-size: 18px;
  overflow: hidden;
  width: 300px; 
}

.text-field .content {
  display: inline-block;
  height: 21px;
  float: left;
  white-space: pre;
}

.text-field.focused {
  border-color: black;
}

.text-field.cursor .content {
  border-right: solid 2px black;
}
```

We'll build the functionality in increments. When we refer to the *text-field element*, we mean the element that has a class of `text-field`. Likewise, the *content element* has a class of `content`.

1. Write JavaScript to add the `focused` class to the text-field element when the user clicks the element.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.currentTarget.classList.add('focused');
  });
});
```

---

2. Write JavaScript that removes the `focused` class from the text-field element when the user clicks the *document*.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    textField.classList.add('focused');
  });

  document.addEventListener('click', event => {
    if (event.target !== textField) textField.classList.remove('focused');
  });
});
```

#### Adjustments based on provided solution

The `click` event listener on `document` should be separate from `document`'s `DOMContentLoaded` event listener, not nested inside it. Also, if you stop propagation in `textfield`'s event handler, you don't need to verify the target of `document`'s click event:

```javascript
document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');
  });
});

document.addEventListener('click', event => {
  let textField = document.querySelector('div.text-field');
  textField.classList.remove('focused');
});
```

---

3. Write JavaScript to create an interval that adds or removes the class `cursor` from the text-field element every 500 milliseconds after the user clicks the text-field element. The code should toggle the `cursor` class every 500ms: on with one cycle, off with the next.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');

    setInterval(() => textField.classList.toggle('cursor'), 500);
  });
});
```

---

4. When the user clicks anywhere in the document, clear the interval that adds and removes the `cursor` class.

### Solution

```javascript
let intervalId;

document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');

    intervalId = setInterval(() => textField.classList.toggle('cursor'), 500);
  });
});

document.addEventListener('click', event => {
  let textField = document.querySelector('div.text-field');
  clearInterval(intervalId);
  textField.classList.remove('focused', 'cursor');
});
```

---

5. When the user presses a keyboard key while the text-field element has the `focused` class, append the String value of the key to the content element. Ignore keyboard entries when the text-field element does not have the `focused` class.

### Solution

```javascript
let intervalId;

document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');

    intervalId = setInterval(() => textField.classList.toggle('cursor'), 500);
  });
});

document.addEventListener('click', event => {
  let textField = document.querySelector('div.text-field');
  clearInterval(intervalId);
  textField.classList.remove('focused', 'cursor');
});

document.addEventListener('keydown', event => {
  let textField = document.querySelector('div.text-field');
  if (textField.classList.contains('focused')) {
    textField.textContent += event.key;
  }
});
```

#### Adjustments based on provided solution

There is already an inner `div` for the text content that I missed and end up overwriting when I reassign its container `div`'s `textContent` property.

```javascript
document.addEventListener('keydown', event => {
  let textField = document.querySelector('div.text-field');
  let contentDiv = document.querySelector('div.content');
  if (textField.classList.contains('focused')) {
    contentDiv.textContent += event.key;
  }
});
```

---

6. When the user presses the Backspace key while the text-field element has the `focused` class, delete the last character from the text within the content element.

### Solution

```javascript
document.addEventListener('keydown', event => {
  let textField = document.querySelector('div.text-field');
  let contentDiv = document.querySelector('div.content');

  if (textField.classList.contains('focused')) {
    if (event.key === 'Backspace') {
      contentDiv.textContent = contentDiv.textContent.slice(0, -1);
    } else {
      contentDiv.textContent += event.key;
    }
  }
});
```

---

7. The current solution has a subtle bug. If you click consecutively on the text-field element the cursor will blink chaotically. This happens because there are as many "intervals" added as there are clicks. Write JavaScript that only sets the interval if it hasn't been set yet.

### Solution

```javascript
let intervalId;

document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');

    if (!intervalId) {
      intervalId = setInterval(() => {
        textField.classList.toggle('cursor');
      }, 500);
    }
  });
});

document.addEventListener('click', event => {
  let textField = document.querySelector('div.text-field');
  clearInterval(intervalId);
  intervalId = null;
  textField.classList.remove('focused', 'cursor');
});

document.addEventListener('keydown', event => {
  let textField = document.querySelector('div.text-field');
  let contentDiv = document.querySelector('div.content');

  if (textField.classList.contains('focused')) {
    if (event.key === 'Backspace') {
      contentDiv.textContent = contentDiv.textContent.slice(0, -1);
    } else {
      contentDiv.textContent += event.key;
    }
  }
});
```
