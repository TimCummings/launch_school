
# Events and Asynchronous Programming - 3/7/2021

## 1. Randomizer

Write a `randomizer` function that accepts `n` callbacks and calls each callback at some random point in time between now and `2 * n` seconds from now. For instance, if the caller provides 5 callbacks, the function should run them all sometime within 10 seconds.

While running, `randomizer` should log the elapsed time every second: `1`, `2`, `3`, ..., `2 * n`.

```javascript
function callback1() {
  console.log('callback1');
}

function callback2() {
  console.log('callback2');
}

function callback3() {
  console.log('callback3');
}

function randomizer(callbacks) {
  // Your code here.
}

randomizer(callback1, callback2, callback3);

// Output:
// 1
// 2
// "callback2"
// 3
// "callback3"
// 4
// 5
// "callback1"
// 6
```

Expect the output to change with each run due to the random execution times.

### Solution

```javascript
function randomizer(...callbacks) {
  const min = 0;
  const max = callbacks.length * 2;

  callbacks.forEach(callback => {
    let randomDelay = Math.floor(Math.random() * (max - min + 1) + min);
    setTimeout(callback, randomDelay * 1000);
  });

  let seconds = 0;
  let intervalId = setInterval(() => {
    seconds += 1;
    console.log(seconds);
  }, 1000);

  setTimeout(() => clearInterval(intervalId), (max + 1) * 1000);
}
```

#### Adjustments based on provided solution

Rather than creating another timeout to clear the interval, use a condition inside the interval to clear itself when it has run to or past the maximum allowed time:

```javascript
let intervalId = setInterval(() => {
  seconds += 1;
  console.log(seconds);

  if (seconds >= max) clearInterval(intervalId);
}, 1000);
```

---

## 2. Reverse Engineer

Without changing the behavior of the following code, remove the call to `event.stopPropagation` and refactor the result.

```javascript
document.querySelector('html').addEventListener('click', () => {
  document.querySelector('#container').style = 'display: none';
});

document.querySelector('#container').addEventListener('click', event => {
  event.stopPropagation();
});
```

### Solution

The effect of `event.stopPropagation` in this code is that clicks inside the element with the ID of `container` don't hide it, while clicks outside of it do. To replicate this behavior with `stopPropagation`, we can check inside the `html` `click` event handler if the target of the click was the element with the ID of `container` and do nothing if so. But this is only a partial solution and won't work if the `#container` element has elements inside it and they are clicked - it will be hidden in this case when it would not be with the initial code.

```javascript
document.querySelector('html').addEventListener('click', event => {
  let container = document.querySelector('#container');
  if (event.target === container) return;
  container.style = 'display: none';
});

document.querySelector('#container').addEventListener('click', event => {
});
```

#### Adjustments based on provided solution

The incompleteness of my initial solution can be fixed by checking not that `#container` is the target of the click, but by checking whether `#container` *contains* the target of the click (**NB:** `contains` also returns true for the element itself, i.e. `#container` in this example!)

```javascript
document.querySelector('html').addEventListener('click', event => {
  let container = document.querySelector('#container');
  if (container.contains(event.target)) return;
  container.style = 'display: none';
});
```

---

## 3. Bold Element + Custom

Implement a function that makes an element bold and allows the user of the function to optionally do something else with it.

```html
<!doctype html>
<html lang="en-US">
  <head>
    <meta charset="utf-8">
    <title>Bold Element + Custom</title>
  </head>
  <body>
    <section>Hello World</section>
    <p>Greetings!</p>
  </body>
</html>
```

```
> let sectionElement = document.querySelector('section');
> makeBold(sectionElement, function(elem) {
    elem.classList.add('highlight');
  });

> sectionElement.classList.contains('highlight');
= true
> sectionElement.style.fontWeight;
= "bold"
```

### Solution

```javascript
function makeBold(target, customFunction) {
  target.style.fontWeight = 'bold';

  if (customFunction) customFunction(target);
}
```

#### Adjustments based on provided solution

In addition to verifying that `customFunction` is provided, we should also ensure that it's a function before trying to invoke it:

```javascript
function makeBold(target, customFunction) {
  target.style.fontWeight = 'bold';

  if (customFunction && typeof customFunction === 'function') {
    customFunction(target);
  }
}
```

#### Further Exploration

You can get the same behavior as the above solution by creating your own custom event. For this further exploration exercise, create your own [CustomEvent](https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent) called `bolded` that allows the user to add it as the type of event to listen to.

> Hint: You will still need a `makeBold` function. However, rather than having it accept a `callback` as an argument, it instead dispatches the `bolded` event.

##### FE Solution

```javascript
let event = new CustomEvent('bolded');

let sectionElement = document.querySelector('section');

sectionElement.addEventListener('bolded', event => {
  event.currentTarget.classList.add('highlight');
});

function makeBold(target) {
  target.style.fontWeight = 'bold';
  sectionElement.dispatchEvent(event);
}

makeBold(sectionElement);
```

---

## 4. Buggy Code

The code below is buggy. The person who created the code expects that nothing will happen when the user clicks on the image. This, however, isn't the case; clicking the image still brings the user to another web page.

Study the code and explain the bug.

```html
<a href="https://www.launchschool.com">
  Home
  <img src="https://d24f1whwu8r3u4.cloudfront.net/assets/launch-logo-b6d01bd15ee9da31457ee3c315845718823aa8a741858be598ab35042a312348.svg" />
</a>
```

```css
img {
  display: block;
  width: 15%;
  margin-top: 10px;
  cursor: auto;
}
```

```javascript
document.querySelector('img').addEventListener('click', event => {
  event.stopPropagation();
}, false);
```

### Solution

The default behavior of the browser to follow a clicked link must be prevented with `preventDefault`:

```javascript
document.querySelector('img').addEventListener('click', event => {
  event.preventDefault();
  event.stopPropagation();
}, false);
```

---

## 5. Context Menus

Given the following markup, implement distinct [context menus](https://developer.mozilla.org/en-US/docs/Web/Events/contextmenu) for the `main` and the `sub` areas of the web page. You can represent a context menu as an alert box that displays the name of the respective area (i.e., `alert("sub")`). Only one context menu should appear when the event occurs.

```html
<main>
  Main Area
  <section id="sub">
    Sub Area
  </section>
</main>
```

```css
main, #sub {
  padding: 15px;
}
main {
  width: 100%;
  height: 200px;
  background: blue;
  color: white;
}

#sub {
  position: relative;
  top: 100px;
  left: 15px;
  background: red;
  height: 50px;
  width: 50%;
}
```

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const main = document.querySelector('main');
  const sub = document.getElementById('sub');

  main.addEventListener('contextmenu', event => {
    event.preventDefault();
    alert('main');
  });

  sub.addEventListener('contextmenu', event => {
    event.preventDefault();
    event.stopPropagation();
    alert('sub');
  });
});
```

---

## 6. Selection Filters

Given the HTML below, write some JavaScript code that updates the options on one dropdown when the selection in the other dropdown changes. For instance, when the user chooses an option under Classifications, the items in the Animals dropdown should change accordingly. Use the lookup tables below to see which animals and classifications go together.

```html
<form id="selection-filters" method="post" action="#">
  <select id="animal-classifications">
    <option value="Classifications" selected>Classifications</option>
    <option value="Vertebrate">Vertebrate</option>
    <option value="Warm-blooded">Warm-blooded</option>
    <option value="Cold-blooded">Cold-blooded</option>
    <option value="Mammal">Mammal</option>
    <option value="Bird">Bird</option>
  </select>
  <select id="animals">
    <option value="Animals" selected>Animals</option>
    <option value="Bear">Bear</option>
    <option value="Turtle">Turtle</option>
    <option value="Whale">Whale</option>
    <option value="Salmon">Salmon</option>
    <option value="Ostrich">Ostrich</option>
  </select>
  <button id="clear">Clear</button>
</form>
```

#### Selection Change with Filter1: Animal Classifications

| Selection    | Animals Options                      |
|--------------|--------------------------------------|
| Vertebrate   | Bear, Turtle, Whale, Salmon, Ostrich |
| Warm-blooded | Bear, Whale, Ostrich                 |
| Cold-blooded | Salmon, Turtle                       |
| Mammal       | Bear, Whale                          |
| Bird         | Ostrich                              |

#### Selection Change with Filter2: Animals

| Selection | Animal Classifications Options   |
|-----------|----------------------------------|
| Bear      | Vertebrate, Warm-blooded, Mammal |
| Turtle    | Vertebrate, Cold-blooded         |
| Whale     | Vertebrate, Warm-blooded, Mammal |
| Salmon    | Vertebrate, Cold-blooded         |
| Ostrich   | Vertebrate, Warm-blooded, Bird   |

When the user clicks the "Clear" button, the program should reset both dropdowns to their default values.

### Solution

```javascript
const LOOKUP_BY_CLASSIFICATION = {
  'Vertebrate': ['Bear', 'Turtle', 'Whale', 'Salmon', 'Ostrich'],
  'Warm-blooded': ['Bear', 'Whale', 'Ostrich'],
  'Cold-blooded': ['Salmon', 'Turtle'],
  'Mammal': ['Bear', 'Whale'],
  'Bird': ['Ostrich'],
};

const LOOKUP_BY_ANIMAL = {
  Bear: ['Vertebrate', 'Warm-blooded', 'Mammal'],
  Turtle: ['Vertebrate', 'Cold-blooded'],
  Whale: ['Vertebrate', 'Warm-blooded', 'Mammal'],
  Salmon: ['Vertebrate', 'Cold-blooded'],
  Ostrich: ['Vertebrate', 'Warm-blooded', 'Bird'],
};

function clearOptions(selection) {
  while (selection.length > 0) {
    selection.remove(0);
  }
}

function addOption(text, target) {
  let element = document.createElement('option');
  element.text = text;
  target.add(element);
}

function addMatchingOptions(lookup, key, target) {
  lookup[key].forEach(value => addOption(value, target));
}

function addDefaultOptions(lookup, target) {
  Object.keys(lookup).forEach(key => addOption(key, target));
}

document.addEventListener('DOMContentLoaded', () => {
  const classificationDropdown = document.getElementById('animal-classifications');
  const animalDropdown = document.getElementById('animals');
  const clearBtn = document.getElementById('clear');

  classificationDropdown.addEventListener('change', event => {
    let classification = classificationDropdown.value;
    clearOptions(animalDropdown);
    addMatchingOptions(LOOKUP_BY_CLASSIFICATION, classification, animalDropdown);
  });

  animalDropdown.addEventListener('change', event => {
    let animal = animalDropdown.value;
    clearOptions(classificationDropdown);
    addMatchingOptions(LOOKUP_BY_ANIMAL, animal, classificationDropdown);
  });

  clearBtn.addEventListener('click', event => {
    event.preventDefault();

    clearOptions(classificationDropdown);
    addDefaultOptions(LOOKUP_BY_CLASSIFICATION, classificationDropdown);

    clearOptions(animalDropdown);
    addDefaultOptions(LOOKUP_BY_ANIMAL, animalDropdown);
  });
});
```

---

## 7. Article Highlighter

Given the HTML and CSS from the codepen, implement JS code that does the following:

```html
<header>
  <h1>Nav</h1>
  <ul>
    <li><a href="#article-1">Article 1</a></li>
    <li><a href="#article-2">Article 2</a></li>
    <li><a href="#article-3">Article 3</a></li>
    <li><a href="#article-4">Article 4</a></li>
  </ul>
</header>
<main>
  <h1>Articles</h1>
  <article id="article-1">
    <h2>Article 1</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras varius pulvinar aliquam. Suspendisse sed metus vel diam pulvinar lacinia. Mauris odio ante, volutpat vitae arcu sit amet, sodales iaculis nibh. Morbi tincidunt, est non pharetra finibus, risus eros rhoncus velit, et eleifend ligula erat quis odio. Pellentesque sit amet nulla lacus. Fusce mollis aliquet ex vitae pellentesque. Suspendisse ex velit, eleifend in porta vel, porttitor a felis. Vivamus vestibulum, nulla ut iaculis dapibus, eros nisl molestie elit, at viverra neque arcu vel tellus. Vestibulum sed eros purus.

Donec rhoncus commodo lorem. Ut id porta massa. Etiam accumsan risus eget nunc convallis convallis. Etiam eleifend metus vel libero aliquet, non convallis velit pellentesque. Maecenas vitae posuere libero. Nullam maximus sagittis metus vitae condimentum. Praesent rutrum scelerisque vulputate. Suspendisse egestas dui magna, a tempus turpis placerat vel. Integer venenatis varius feugiat. Quisque a diam eget ex lacinia porttitor. Aliquam congue sapien in tempor accumsan. Morbi sollicitudin est eget ipsum eleifend, et vestibulum risus fringilla. Vestibulum fringilla nibh est, lacinia commodo justo mollis ac. Cras vestibulum odio in varius vehicula. Praesent at sodales nisl.

Phasellus elit enim, fermentum et finibus ut, commodo non lorem. Aliquam bibendum sapien at arcu semper, eget ultrices elit lacinia. In sed nulla quis massa sagittis cursus eu tempor odio. Nulla at imperdiet ex. Maecenas hendrerit ornare dui, nec porta dolor aliquam quis. Curabitur sollicitudin enim vel vulputate suscipit. Quisque vitae lobortis velit. Maecenas a dui pretium, suscipit elit non, gravida odio. Etiam feugiat a turpis vitae sagittis. Etiam ac nulla id metus semper aliquam eget vitae justo. Vivamus sed odio ornare, commodo tortor eget, pretium metus. Sed a aliquam ligula. Nullam a quam dui. Cras hendrerit viverra nisi, et faucibus orci elementum at.</p>
  </article>
  <article id="article-2">
    <h2>Article 2</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras varius pulvinar aliquam. Suspendisse sed metus vel diam pulvinar lacinia. Mauris odio ante, volutpat vitae arcu sit amet, sodales iaculis nibh. Morbi tincidunt, est non pharetra finibus, risus eros rhoncus velit, et eleifend ligula erat quis odio. Pellentesque sit amet nulla lacus. Fusce mollis aliquet ex vitae pellentesque. Suspendisse ex velit, eleifend in porta vel, porttitor a felis. Vivamus vestibulum, nulla ut iaculis dapibus, eros nisl molestie elit, at viverra neque arcu vel tellus. Vestibulum sed eros purus.

Donec rhoncus commodo lorem. Ut id porta massa. Etiam accumsan risus eget nunc convallis convallis. Etiam eleifend metus vel libero aliquet, non convallis velit pellentesque. Maecenas vitae posuere libero. Nullam maximus sagittis metus vitae condimentum. Praesent rutrum scelerisque vulputate. Suspendisse egestas dui magna, a tempus turpis placerat vel. Integer venenatis varius feugiat. Quisque a diam eget ex lacinia porttitor. Aliquam congue sapien in tempor accumsan. Morbi sollicitudin est eget ipsum eleifend, et vestibulum risus fringilla. Vestibulum fringilla nibh est, lacinia commodo justo mollis ac. Cras vestibulum odio in varius vehicula. Praesent at sodales nisl.

Phasellus elit enim, fermentum et finibus ut, commodo non lorem. Aliquam bibendum sapien at arcu semper, eget ultrices elit lacinia. In sed nulla quis massa sagittis cursus eu tempor odio. Nulla at imperdiet ex. Maecenas hendrerit ornare dui, nec porta dolor aliquam quis. Curabitur sollicitudin enim vel vulputate suscipit. Quisque vitae lobortis velit. Maecenas a dui pretium, suscipit elit non, gravida odio. Etiam feugiat a turpis vitae sagittis. Etiam ac nulla id metus semper aliquam eget vitae justo. Vivamus sed odio ornare, commodo tortor eget, pretium metus. Sed a aliquam ligula. Nullam a quam dui. Cras hendrerit viverra nisi, et faucibus orci elementum at.</p>
  </article>
  <article id="article-3">
    <h2>Article 3</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras varius pulvinar aliquam. Suspendisse sed metus vel diam pulvinar lacinia. Mauris odio ante, volutpat vitae arcu sit amet, sodales iaculis nibh. Morbi tincidunt, est non pharetra finibus, risus eros rhoncus velit, et eleifend ligula erat quis odio. Pellentesque sit amet nulla lacus. Fusce mollis aliquet ex vitae pellentesque. Suspendisse ex velit, eleifend in porta vel, porttitor a felis. Vivamus vestibulum, nulla ut iaculis dapibus, eros nisl molestie elit, at viverra neque arcu vel tellus. Vestibulum sed eros purus.

Donec rhoncus commodo lorem. Ut id porta massa. Etiam accumsan risus eget nunc convallis convallis. Etiam eleifend metus vel libero aliquet, non convallis velit pellentesque. Maecenas vitae posuere libero. Nullam maximus sagittis metus vitae condimentum. Praesent rutrum scelerisque vulputate. Suspendisse egestas dui magna, a tempus turpis placerat vel. Integer venenatis varius feugiat. Quisque a diam eget ex lacinia porttitor. Aliquam congue sapien in tempor accumsan. Morbi sollicitudin est eget ipsum eleifend, et vestibulum risus fringilla. Vestibulum fringilla nibh est, lacinia commodo justo mollis ac. Cras vestibulum odio in varius vehicula. Praesent at sodales nisl.

Phasellus elit enim, fermentum et finibus ut, commodo non lorem. Aliquam bibendum sapien at arcu semper, eget ultrices elit lacinia. In sed nulla quis massa sagittis cursus eu tempor odio. Nulla at imperdiet ex. Maecenas hendrerit ornare dui, nec porta dolor aliquam quis. Curabitur sollicitudin enim vel vulputate suscipit. Quisque vitae lobortis velit. Maecenas a dui pretium, suscipit elit non, gravida odio. Etiam feugiat a turpis vitae sagittis. Etiam ac nulla id metus semper aliquam eget vitae justo. Vivamus sed odio ornare, commodo tortor eget, pretium metus. Sed a aliquam ligula. Nullam a quam dui. Cras hendrerit viverra nisi, et faucibus orci elementum at.</p>
  </article>
  <article id="article-4">
    <h2>Article 4</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras varius pulvinar aliquam. Suspendisse sed metus vel diam pulvinar lacinia. Mauris odio ante, volutpat vitae arcu sit amet, sodales iaculis nibh. Morbi tincidunt, est non pharetra finibus, risus eros rhoncus velit, et eleifend ligula erat quis odio. Pellentesque sit amet nulla lacus. Fusce mollis aliquet ex vitae pellentesque. Suspendisse ex velit, eleifend in porta vel, porttitor a felis. Vivamus vestibulum, nulla ut iaculis dapibus, eros nisl molestie elit, at viverra neque arcu vel tellus. Vestibulum sed eros purus.

Donec rhoncus commodo lorem. Ut id porta massa. Etiam accumsan risus eget nunc convallis convallis. Etiam eleifend metus vel libero aliquet, non convallis velit pellentesque. Maecenas vitae posuere libero. Nullam maximus sagittis metus vitae condimentum. Praesent rutrum scelerisque vulputate. Suspendisse egestas dui magna, a tempus turpis placerat vel. Integer venenatis varius feugiat. Quisque a diam eget ex lacinia porttitor. Aliquam congue sapien in tempor accumsan. Morbi sollicitudin est eget ipsum eleifend, et vestibulum risus fringilla. Vestibulum fringilla nibh est, lacinia commodo justo mollis ac. Cras vestibulum odio in varius vehicula. Praesent at sodales nisl.

Phasellus elit enim, fermentum et finibus ut, commodo non lorem. Aliquam bibendum sapien at arcu semper, eget ultrices elit lacinia. In sed nulla quis massa sagittis cursus eu tempor odio. Nulla at imperdiet ex. Maecenas hendrerit ornare dui, nec porta dolor aliquam quis. Curabitur sollicitudin enim vel vulputate suscipit. Quisque vitae lobortis velit. Maecenas a dui pretium, suscipit elit non, gravida odio. Etiam feugiat a turpis vitae sagittis. Etiam ac nulla id metus semper aliquam eget vitae justo. Vivamus sed odio ornare, commodo tortor eget, pretium metus. Sed a aliquam ligula. Nullam a quam dui. Cras hendrerit viverra nisi, et faucibus orci elementum at.</p>
  </article>
</main>
```

```css
.highlight {
  border: 1px dotted black;
}

header li {
  display: inline-block;
}

header ul {
  padding: 0;
}
```

* When the user clicks on a navigation link (Articles 1-4), the browser scrolls to that article in the `<main>` element and adds the `highlight` class to it. If another element already has the `highlight` class, the browser removes the class from that element.
* When the user clicks on an `article` element or any of its child elements, the browser adds the `highlight` class to it. If another element already has the `highlight` class, the browser removes the class from that element.
* When the user clicks anywhere else on the page, the browser adds the `highlight` class to the `main` element. If another element already has the `highlight` class, the browser removes the class from that element.

### Solution

Event delegation is a good solution for link click events; it also initially seemed like a good idea for article click events, but the logic for checking for clicks on descendants of an article was much more complex compared to individual event listeners on each article. I don't really prefer one set of events handled by delegation and another set handled by individual listeners, but that is what led to the simplest code here.

```javascript
function highlightOnly(target) {
  Array.from(document.getElementsByClassName('highlight')).forEach(element => {
    if (element !== target) {
      element.classList.remove('highlight');
    }
  });

  target.classList.add('highlight');
}

document.addEventListener('DOMContentLoaded', () => {
  document.querySelector('header ul').addEventListener('click', event => {
    if (event.target.tagName === 'A') {
      event.stopPropagation();
      let article = document.querySelector(event.target.hash);
      highlightOnly(article);
    }
  });

  Array.from(document.getElementsByTagName('ARTICLE')).forEach(article => {
    article.addEventListener('click', event => {
      if (article.contains(event.target)) {
        event.stopPropagation();
        highlightOnly(article);
      }
    });
  });

  document.body.addEventListener('click', event => {
    highlightOnly(document.querySelector('main'));
  });
});
```

---

## 8. Delegate Event Function

Implement a function named `delegateEvent` that delegates events to the descendant (inner) elements of a parent element that match a given selector. The function takes four arguments: `parentElement`, `selector`, `eventType`, and `callback`. It returns `true` if it was able to add an event listener and `undefined` if it wasn't. For example, if the `parentElement` is `section` and `selector` is `p`, the function should delegate events of `eventType` on the `p` element within `section` to the function `callback`; consequently, the function returns `true`.

Assume that all event handlers listen during the bubbling phase.

Use this markup and the following scenarios to test your implementation:

```html
<!doctype html>
<html lang="en-US">
  <head>
    <meta charset="utf-8">
    <title>Event Delegation Function</title>
  </head>
  <body>
    <main>
      <section>
        <h1>Header</h1>
        <p>Content</p>
      </section>
      <aside>
        <h2>Sub Side Notes</h2>
        <p>Note 1</p>
        <p>Note 2</p>
      </aside>
    </main>
    <nav>
      <p>Side Note</p>
    </nav>
  </body>
</html>
```

##### Scenarios

Notes on the scenarios:

* Each scenario is independent of the others.
* Assume that `delegateEvent` runs before the described scenario occurs.

```javascript
// Possible elements for use with the scenarios
const element1 = document.querySelector('table');
const element2 = document.querySelector('main h1');
const element3 = document.querySelector('main');
```

```javascript
// Possible callback for use with the scenarios
const callback = ({target, currentTarget}) => {
  alert(`Target: ${target.tagName}\nCurrent Target: ${currentTarget.tagName}`);
};
```

**Scenario 1:** `delegateEvent(element1, 'p', 'click', callback);`

* The function executes and returns `undefined`.
* It doesn't add an event listener to any elements.

**Scenario 2:** `delegateEvent(element2, 'p', 'click', callback);`

* The function executes and returns `true`.
* It adds a `click` event listener to `element2`.
* If you click anywhere on the page, the `callback` function does not trigger.

**Scenario 3:** `delegateEvent(element2, 'h1', 'click', callback);`

* The function executes and returns `true`.
* It adds a `click` event listener to `element2`.
* If you click anywhere on the page, the `callback` function does not trigger.

**Scenario 4:** `delegateEvent(element3, 'h1', 'click', callback);`

* The function executes and returns `true`.
* It adds a `click` event listener to `element3`.
* If you click the `h1` element that contains the text "Header," the `callback` function should trigger and display an alert message, e.g., `'Target: H1\nCurrent Target: MAIN'`.
* If you click anywhere else, the `callback` function does not trigger.

**Scenario 5:** `delegateEvent(element3, 'aside p', 'click', callback);`

* The function executes and returns `true`.
* It adds a `click` event listener to `element3`.
* If you click a `p` element that is a descendant of `aside` element inside `main`, the `callback` function should trigger and display an alert message, e.g., `'Target: P\nCurrent Target: MAIN'`.
* If you click anywhere else, the `callback` function does not trigger.

**Scenario 6:** `delegateEvent(element2, 'p', 'click', callback);`

* The function executes and returns `true`.
* It adds a `click` event listener to `element2`.
* If you click anywhere on the page, the `callback` function does not trigger.
* Run this code:

```javascript
const newP = document.createElement('P');
const newContent = document.createTextNode('New Paragraph');
newP.appendChild(newContent);

element2.appendChild(newP);
```

* If you click the `p` element that contains the text "New Paragraph", the `callback` function should trigger and display an alert message, e.g., `'Target: P\nCurrent Target: H1'`.
* If you click anywhere else, the `callback` function does not trigger.

### Solution

```javascript
function delegateEvent(parentElement, selector, eventType, callback) {
  if (!parentElement) return undefined;

  let descendants = Array.from(parentElement.querySelectorAll(selector));
  parentElement.addEventListener(eventType, event => {
    let target = event.target;

    if (descendants.includes(target)) {
      let currentTarget = event.currentTarget;
      callback({ target, currentTarget });
    }
  });

  return true;
}
```

#### Adjustments based on provided solution

You can pass the event directly to the callback and its properties will be destructured: `callback(event)`.

---

## 9. Events Tracker

Implement a function that tracks events on a web page by wrapping a callback function in a function that adds each event to a `tracker` object before invoking the callback. In other words, your function should take a callback function as an argument and return a new function that:

* Records the event.
* Executes the original callback function.

Use the following markup and sample scenario to ascertain the expected behavior of the `tracker` object.

```html
<html>
  <head>
    <title>Tests</title>
    <meta charset="utf-8">
    <style>
      #red, #blue, #green, #orange {
        cursor: pointer;
        color: white;
        padding: 10px;
        margin: 10px;
      }

      #red {
        width: 400px;
        height: 400px;
        background: red;
      }

      #blue {
        width: 200px;
        height: 200px;
        background: blue;
      }

      #orange {
        width: 100px;
        height: 100px;
        background: orange;
      }

      #green {
        width: 50px;
        height: 50px;
        background: green;
      }
    </style>
  </head>
  <body>
    <div id="red">Red
      <div id="blue">Blue</div>
      <div id="orange">Orange
        <div id="green">Green</div>
      </div>
    </div>
    <script src="test.js"></script>
  </body>
</html>
```

##### Assumptions

* Assume that the user clicks the elements in the following order: `div#blue`, `div#red`, `div#orange`, and `div#green`.
* Use the "click" event listeners for the four elements:

```javascript
divRed.addEventListener('click', track(event => {
  document.body.style.background = 'red';
}));

divBlue.addEventListener('click', track(event => {
  event.stopPropagation();
  document.body.style.background = 'blue';
}));

divOrange.addEventListener('click', track(event => {
  document.body.style.background = 'orange';
}));

divGreen.addEventListener('click', track(event => {
  document.body.style.background = 'green';
}));
```

```
> tracker.list().length
= 4
> tracker.elements()
= [div#blue, div#red, div#orange, div#green]
> tracker.elements()[0] === document.querySelector('#blue')
= true
> tracker.elements()[3] === document.querySelector('#green')
= true
> tracker.clear()
= 0
> tracker.list()
= []
> tracker.list()[0] = 'abc'
> tracker.list().length
= 0
```

### Solution

```javascript
const tracker = (function() {
  function describe(element) {
    return `${element.tagName.toLowerCase()}#${element.id}`;
  }

  const events = [];

  return {
    list() {
      return events.slice();
    },

    elements() {
      return events.map(event => event.target);
    },

    clear() {
      events.length = 0;
      return events.length;
    },

    track(callback) {
      return function(event) {
        let lastEvent = events[events.length - 1];

        if (!lastEvent || lastEvent.target !== event.target) {
          events.push(event);
          callback(event);
        }
      };
    },
  };
})();

let track = tracker.track;
```

#### Adjustments based on provided solution

I was too specific in my interpretation of the results: events should not be added if they are already tracked, not if they were the most recently added event:

```javascript
    track(callback) {
      return function(event) {
        let lastEvent = events[events.length - 1];

        if (!events.includes(event)) {
          events.push(event);
          callback(event);
        }
      };
    },
```
