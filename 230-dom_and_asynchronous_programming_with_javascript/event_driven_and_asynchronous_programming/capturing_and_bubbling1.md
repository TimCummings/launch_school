
# Capturing and Bubbling (1) - 5/6/2021

1. Reverse the behavior of scenario 3. Have the alert box of the `div#elem1` element show up first.

```html
<div id="elem1">1
  <div id="elem2">2
    <div id="elem3">3
      <div id="elem4">4
      </div>
    </div>
  </div>
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
let elem4 = document.querySelector('#elem4');

elem1.addEventListener('click', event => alert(event.currentTarget.id));
elem4.addEventListener('click', event => alert(event.currentTarget.id));
```

### Solution

```javascript
let elem1 = document.querySelector('#elem1');
let elem4 = document.querySelector('#elem4');

elem1.addEventListener('click', event => alert(event.currentTarget.id), true);
elem4.addEventListener('click', event => alert(event.currentTarget.id));
```

---

2. Study the example below.

```html
<body>
  <div class="d1 pick">1
    <main class="d2 pick">2
      <div class="d3">3
        <section class="d4 pick">4
        </section>
      </div>  
    </main>
  </div>
</body>
```

```css
.d1 {
  background-color: green;
  position: relative;
  width: 200px;
  height: 200px;
  text-align: center;
  cursor: pointer;
}

.d2 {
  background-color: blue;
  position: absolute;
  top: 25px;
  left: 25px;
  width: 150px;
  height: 150px;
}

.d3 {
  background-color: red;
  position: absolute;
  top: 25px;
  left: 25px;
  width: 100px;
  height: 100px;
  line-height: 25px;
}

.d4 {
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
let divs = document.querySelectorAll('.pick');

for(let index = 0; index < divs.length; index += 1) {
  divs[index].addEventListener('click', highlightThis, true);
}
    
function highlightThis(e) {
  alert(`${this.className} ${e.currentTarget.tagName}`);
}
```
* Can you predict what happens when you click on "4"?
* If we add the following line of code, what will happen?

```javascript
document.querySelector('.d3').addEventListener('click', highlightThis, false);
```

### Solution

Clicking on "4" will result in the following alerts:

* d1 pick div
* d2 pick main
* d4 pick section

Adding the specified line of code will result in the following alerts:

* d1 pick div
* d2 pick main
* d4 pick section
* d3 div

---

3. Check out the HTML structure and the JavaScript code. How many alert boxes do you think will fire when the yellow box is clicked? Why?

```html
<div id="elem0">0</div>
<div id="elem1">1
  <div id="elem2">2
    <div id="elem3">3
      <div id="elem4">4
      </div>
    </div>
  </div>
</div>
```

```css
#elem0 {
  width: 250px;
  height: 250px;
  position: absolute;
  background-color: orange;
  text-align: center;
  cursor: pointer;
}

#elem1 {
  background-color: green;
  position: relative;
  top: 25px;
  left: 25px;
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
Result Skip Results Iframe
EDIT ON
let elem0 = document.querySelector('#elem0');
let elem1 = document.querySelector('#elem1');
let elem4 = document.querySelector('#elem4');

elem0.addEventListener('click', event => alert(event.currentTarget.id));
elem1.addEventListener('click', event => alert(event.currentTarget.id), true);
elem4.addEventListener('click', event => alert(event.currentTarget.id));
```

### Solution

Clicking the yellow box will yield two alerts: the green, blue, red, and yellow boxes are not nexted inside the orange box in the HTML - they only appear to be.
