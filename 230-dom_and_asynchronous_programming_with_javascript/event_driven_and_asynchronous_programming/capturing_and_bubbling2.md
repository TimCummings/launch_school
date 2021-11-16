
# Capturing and Bubbling (2) - 5/6/2021

Now that we have seen how the concept of capturing and bubbling goes with event listeners and event objects, we'll work on practice problems to help cement our understanding of it. Each practice problem has a code snippet and short clip. Your objective is to list the sequence of event listeners that fire based on the alert boxes you see in the clip (i.e., `click` event listener of the `main` element listening on the capture phase).

## Practice Problem 1

```html
<div id="elem1">1
  <section id="elem2">2
    <article id="elem3">3
      <main id="elem4">4
      </main>
    </article>
  </section>
</div>
```

```css
#elem1 {
  background-color: green;
  position: relative;
  width: 200px;
  height: 200px;
  text-align: center;
  cursor: pointer;
}

#elem2 {
  background-color: blue;
  position: absolute;
  top: 25px;
  left: 25px;
  width: 150px;
  height: 150px;
}

#elem3 {
  background-color: red;
  position: absolute;
  top: 25px;
  left: 25px;
  width: 100px;
  height: 100px;
  line-height: 25px;
}

#elem4 {
  background-color: yellow;
  position: absolute;
  top: 25px;
  left: 25px;
  width: 50px;
  height: 50px;
  line-height: 50px;
}
```

```javascript
let elem1 = document.querySelector('#elem1');

elem1.addEventListener('click', event => alert(event.target.tagName));
elem1.addEventListener('click', event => alert(event.currentTarget.tagName));
```

Alerts in video after clicking yellow 4:

* MAIN
* DIV

### Solution

* first listener (`click` on `div#elem1` that alerts `event.target.tagName`)
* second listener (`click` on `div#elem1` that alerts `event.currentTarget.tagName`)

---

## Practice Problem 2

HTML and CSS are the same as Practice Problem 1. JavaScript:

```javascript
let elem1 = document.querySelector('#elem1');

elem1.addEventListener('click', event => alert("bubbling"));
elem1.addEventListener('click', event => alert("capturing"), true);
```

Alerts in video after clicking yellow 4:

* capturing
* bubbling

### Solution

* second listener (`click` on `div#elem1` listening on capture phase that alerts `"capturing"`)
* first listener (`click` on `div#elem1` listening on bubble phase that alerts `"bubbling"`)

---

## Practice Problem 3

```html
<div id="elem1">1
  <section id="elem2">2
    <article id="elem3">3
      <main id="elem4">4
      </main>
    </article>
  </section>
</div>
<input type=text>
```

CSS is the same as the previous two problems.

```javascript
let elem1 = document.querySelector('#elem1');

document.addEventListener('keypress', event => {
  setTimeout(() => alert(event.code), 7000);
});

elem1.addEventListener('click', event => {
  setTimeout(() => alert(event.target.tagName), 7000);
});
```

After the following actions in the video:

* clicking green 1
* typing `qw` into input field
* clicking yellow 4

The following alerts are displayed after a delay:

* DIV
* keyQ
* keyW
* MAIN

### Solution

* `click` event on `div#elem1` that alerts `event.target.tagName`
* `keypress` event on `document` that alerts `event.code`
* `keypress` event on `document` that alerts `event.code`
* `click` event on `div#elem1` that alerts `event.target.tagName`
