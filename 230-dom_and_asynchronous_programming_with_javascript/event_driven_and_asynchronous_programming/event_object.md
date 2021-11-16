
# The Event Object - 3/5/2021

## Problems

1. Starting with the template below, write some JavaScript code to move the red X to the last position in the document that the user clicked. Click the "EDIT ON CODEPEN" button on the upper-right to edit the template.

```html
<div class="x">
  <div class="horizontal"></div>
  <div class="vertical"></div>
</div>
```

```css
.x {
  position: absolute;
  transform: rotate(45deg);
  top: 20px;
  left: 20px;
}

.x .horizontal {
  width: 45px;
  height: 5px;
  position: absolute;
  left: -20px;
  background: red;
}

.x .vertical {
  height: 45px;
  width: 5px;
  background: red;
  position: absolute;
  left: 0px;
  top: -20px;
}
```

### Solution

```javascript
document.addEventListener('click', event => {
  let xDiv = document.querySelector('div.x');
  xDiv.style.left = `${event.clientX}px`;
  xDiv.style.top = `${event.clientY}px`;
});
```

---

2. Update your solution to the previous problem to make the red X move as you move the mouse around the document instead of depending on clicks.

### Solution

```javascript
document.addEventListener('mousemove', event => {
  let xDiv = document.querySelector('div.x');
  xDiv.style.left = `${event.clientX}px`;
  xDiv.style.top = `${event.clientY}px`;
});
```

---

3. Update your solution to the previous problem to change the color of the red X to blue when the user presses the `b` key, green in response to the `g` key, and red in response to `r`. The X should continue to follow the mouse around.

> You have to click on the result box (the white area) before you type any keys. Otherwise, the keystrokes go to whatever window or subwindow has the keyboard focus.
>
> If the result box isn't showing, click on the result tab first.

### Solution

```javascript
document.addEventListener('mousemove', event => {
  let divX = document.querySelector('div.x');
  divX.style.left = `${event.clientX}px`;
  divX.style.top = `${event.clientY}px`;
});

document.addEventListener('keydown', event => {
  let color;

  if (event.key === 'b') color = 'blue';
  if (event.key === 'g') color = 'green';
  if (event.key === 'r') color = 'red';

  document.querySelector('div.horizontal').style.background = color;
  document.querySelector('div.vertical').style.background = color;
});
```

#### Adjustments based on provided solution

Add a guard clause (`if (color)`) before changing color so it's not assigned to null when the key is not `b`, `g`, or `r`.

---

4. Using the following code, write some JavaScript to add a character counter that updates as the user types.

```html
<div class="composer">
  <textarea placeholder="Enter your message"></textarea>
  <p class="counter"></p>
  <button type="submit">Post Message</button>
</div>
```

```css
.composer {
  background: #f5f5f5;
  padding:  1em;
  width:  30em;
}

.composer textarea {
  width: 100%;
  height: 4em;
}

.composer textarea.invalid {
  color: red;
}
```

Note how the text turns red when you have more than 140 characters in the text box.

### Solution

```javascript
const CHAR_LIMIT = 140;
const textarea = document.querySelector('div.composer textarea');
const counter = document.querySelector('p.counter');

textarea.addEventListener('input', event => {
  let count = event.currentTarget.value.length;
  counter.textContent = String(CHAR_LIMIT - count);
  counter.textContent = `${CHAR_LIMIT - count} characters remaining`;

  if (CHAR_LIMIT - count < 0) {
    event.currentTarget.classList.add('invalid');
  } else {
    event.currentTarget.classList.remove('invalid');
  }
});
```

#### Adjustments based on provided solution

I forgot the `characters remaining` portion of the counter.
I also missed that the `Post Message` button is disabled when the character count is over the limit.

```javascript
const CHAR_LIMIT = 140;
const textarea = document.querySelector('div.composer textarea');
const counter = document.querySelector('p.counter');
const button = document.querySelector('div.composer button');

textarea.addEventListener('input', event => {
  let count = textarea.value.length;
  counter.textContent = `${CHAR_LIMIT - count} characters remaining`;

  if (CHAR_LIMIT - count < 0) {
    textarea.classList.add('invalid');
    button.setAttribute('disabled', '');
  } else {
    textarea.classList.remove('invalid');
    button.removeAttribute('disabled');
  }
});
```
