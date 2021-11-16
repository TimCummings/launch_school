
# Practice Problems: the DOM - 3/3/2021

In these practice problems, we'll manipulate the DOM from Chrome's JavaScript console. To begin, open [this page](https://d186loudes4jlv.cloudfront.net/fe2/exercises_objects_and_dom/dom_assignment.html) and the Web Developer tools. At the top of the Tools window, click the Console tab; we'll write all our JavaScript in the console.

1. Use JavaScript to set a class of `'heading'` to the heading (the `h1` element).

> Hint: Use `getElementById` to access the `h1` Node. You can use the Elements panel to inspect the document and find the ID of the element.
>
> Use `setAttribute` to set the class name.

### Solution

```javascript
document.querySelector('h1').classList.add('heading');
```

I first answered this before looking at the hint. Based on the hint:

```javascript
document.getElementById('primary_heading').setAttribute('class', 'heading');
```

---

2. Use JavaScript to set the class of the `ul` element to `'bulleted'`.

### Solution

```javascript
document.getElementById('list').setAttribute('class', 'bulleted');
```

---

3. In this problem and the next, we'll use the `onclick` Element property. You don't need to know much about `onclick` right now, but take a minute to read [this link](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onclick). We'll learn more about `onclick` later when we talk about event listeners. For now, the `onclick` property lets you detect when the user clicks an element.

Our page has an element that you can't see initially; it's hidden. When the user clicks the link, the browser should display the hidden item; the next click on that link should hide the revealed item. Each click should toggle the hidden element between the visible and hidden states.

Use the Inspector to find the hidden element and determine its ID. Following this, set the `onclick` property on the link with an ID of `toggle` to a function that makes the element visible when it's hidden and hides it when it's visible. You can use `getAttribute` to access the class, and `setAttribute` to set it; the class names of interest are `'visible'` and `'hidden'`.

> You will have to write a multi-line expression in the console. To do this, hold the Shift key down when you press Enter. Otherwise, the browser will try to execute your partial code and raise an error.

Your function should take a single argument, `e`. The first line of your function should invoke `e.preventDefault`. We'll discuss this later when we talk more about events, but, for now, just be aware that `preventDefault` tells your browser that it shouldn't try to follow the link.

### Solution

```javascript
document.getElementById('toggle').onclick = function toggleVisibility(e) {
  e.preventDefault();

  let target = document.getElementById('notice');

  if (target.getAttribute('class') === 'hidden') {
    target.setAttribute('class', 'visible');
  } else {
    target.setAttribute('class', 'hidden');
  }
}
```

---

4. Add an `onclick` event to the element we show and hide above. This time, the function should set the class of the element to `'hidden'`. This event will let you hide the visible element by clicking on it. As with the previous function, the first thing the function should do is invoke `e.preventDefault`.

### Solution

```javascript
let notice = document.getElementById('notice');
notice.onclick = e => {
  e.preventDefault();
  notice.setAttribute('class', 'hidden');
};

```

---

5. Locate the `multiplication` paragraph and change the text to the result of the arithmetic problem.

### Solution

```javascript
document.getElementById('multiplication').textContent = `${13 * 9}`;
```

---

6. Set the ID of the `body` element to `'styled'` to apply the rest of the styles from the original file. The body tag in this file doesn't have an ID, so you must locate it by some other means.

### Solution

```javascript
document.body.id = 'styled';
```
