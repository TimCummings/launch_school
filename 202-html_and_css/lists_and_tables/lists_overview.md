
# Lists Overview - 9/12/2020

## Unordered Lists

By default, list items are displayed vertically with each preceeded by a bullet point.
Composed of `ul` and `li` elements:

```html
<ul>
  <li>Red</li>
  <li>Orange</li>
  <li>Yellow</li>
</ul>
```

## Ordered Lists

By default, list items are displayed vertically with each preceeded by a sequential number.
Composed of `ol` and `li` elements:

```html
<ol>
  <li>Red</li>
  <li>Orange</li>
  <li>Yellow</li>
</ol>
```

## Description Lists

Also called definition lists prior to HTML5.
Contain a lists of terms and definitions.
Each may have one or more terms and one or more definitions.
Composed of `dl`, `dt`, and `dd` elements:

```html
<dl>
  <dt>Unordered</dt>
  <dd>A simple list with bullets.</dd>
  <dd>A plain list with no bullets or sequence numbers.</dd>

  <dt>Ordered</dt>
  <dd>A simple list with sequence numbers or letters.</dd>

  <dt>Description</dt>
  <dt>Definition</dt>
  <dd>A list with terms and definitions.</dd>
</dl>
```

## Nested Lists

Any list may be nested within any other list, regardless of type.

## Navigation Menus

Unordered lists are frequently used for navigation menus (vertical and horizontal.) A common start might look like:

```html
<nav>
  <ul>
    <li><a href="#">Home</a></li>
    <li><a href="#">Projects</a></li>
    <li><a href="#">Team</a></li>
    <li><a href="#">Help</a></li>
  </ul>
</nav>
```

```css
nav ul {
 background-color: powderblue;
 list-style-type: none;
 padding-left: 0;
 width: 200px;
}

nav li {
 color: blue;
 font-size: 1.25rem;
}

nav a {
 box-sizing: border-box;
 color: blue;
 display: inline-block;
 line-height: 2.5;
 padding: 0 10px;
 text-decoration: none;
 width: 100%;
}

nav a:hover,
nav a:focus {
 background-color: blue;
 color: white;
}
```

This removes the bullet points with `list-style-type: none;` and uses the `:hover` and `:focus` [pseudo-classes](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes) to highlight a particular list item when appropriate.

Additional changes can turn this into a horizontal list:

* set the width of the menu (`ul`)
* set the font for the list (`ul`) to 0 then restore it for the list items `li` (so spaces don't push items onto multiple lines)
* change list items to `display: inline-block;`
* set list item width to evenly distribute them across the page (usually with a % width)
* center list items horizontally

```css
nav ul {
  font-size: 0;
  width: 100%;
}

nav li {
  display: inline-block;
  font-size: 1.25rem;
  text-align: center;
  width: 25%;
}
```
