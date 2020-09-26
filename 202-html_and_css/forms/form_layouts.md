
# Form Layouts - 9/24/2020

Two common layouts:
* horizontal (labels appear to the left or right of their inputs)
* vertical (labels appear above or below their inputs)

## To Start

Focus on the general styling first, then worry about positioning labels and inputs.

```html
<form action="#" class="styled-form">
  <fieldset>
    <label for="text_field">Input Field</label>
    <input type="text" name="text_field" id="text_field"
           placeholder="this is the input area" />

    <br />

    <label for="select_field">Select Field</label>
    <select name="select_field" id="select_field">
      <option>Choice 1</option>
      <option>Choice 2</option>
      <option>Choice 3</option>
    </select>
  </fieldset>
</form>
```

```css
/* Eliminate margins and padding on everything */
.styled-form * {
  margin: 0;
  padding: 0;
}

/* Grey box and default font for fieldsets */
.styled-form fieldset {
  background-color: #ececec;
  border: 2px solid #999;
  box-sizing: border-box;
  color: #4d4d4d;
  font-family:
    myriad-pro, "Helvetica Neue", Helvetica, Roboto,
    Arial, sans-serif;
  padding: 1rem;
}

/* Custom appearance for labels */
.styled-form label {
  font-weight: bold;
  line-height: 1.5rem;
}

/* Custom appearance for input and select fields */
.styled-form input[type="text"],
.styled-form select {
  border: 1px solid #06c;
  border-radius: 4px;
  box-sizing: border-box;
  font: normal 1rem Helvetica, Arial, sans-serif;
  height: 40px;
  padding: 5px 8px;
}

/* More customization for select lists */
.styled-form select {
  -moz-appearance: none;
  -webkit-appearance: none;
  appearance: none;
  background-image:
    url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSIgeD0iMTJweCIgeT0iMHB4IiB3aWR0aD0iMjRweCIgaGVpZ2h0PSIzcHgiIHZpZXdCb3g9IjAgMCA2IDMiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDYgMyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+PHBvbHlnb24gcG9pbnRzPSI1Ljk5MiwwIDIuOTkyLDMgLTAuMDA4LDAgIi8+PC9zdmc+");
  background-position: 100% center;
  background-repeat: no-repeat;
  padding-right: 1.5rem;
}
```

Most of the above HTML and CSS should be familiar, but there are some new pieces:

* The three `background-*` properties combine to provide the custom look for the `select` control.
* The `url("data:rest-of-url")` value on `background-image` loads an "inline image" that shows the tiny drop-down arrow in the select box rather than downloading it separately. You don't need to know how to make these inline images, but you should know how to use them; you will typically receive a `data:` URL that you can plug directly into the `url()` value.
* The `border-radius` property lets you apply rounded corners to any element with a border. You should be aware of this property; you'll need it again.
* The `appearance` property lets you turn off the browser-specific default appearance of a widget (the `select` in this case). You should know how to remove browser-specific styling from input controls; you'll need it again.

## Top and Bottom

Top and bottom orientation is generally easier to work with and more flexible so we'll start there:

```html
<form action="#" class="styled-form top-to-bottom">
  <fieldset>
    <label for="text_field">Input Field</label>
    <input type="text" name="text_field" id="text_field"
           placeholder="this is the input area" />
  <!--
    Delete this code
    <br />
    <label for="select_field">Select Field</label>
    <select name="select_field" id="select_field">
      <option>Choice 1</option>
      <option>Choice 2</option>
      <option>Choice 3</option>
    </select>
  -->
  </fieldset>
</form>
```

```css
/* Add to end of file */
.top-to-bottom label,
.top-to-bottom input[type="text"] {
  display: block;
  width: 100%;
}
```

That was easy; we just had to convert `label` and `input` to `display: block` with `width: 100%`.

## Side by Side

```html
<form action="#" class="styled-form side-by-side">
  <fieldset>
    <label for="text_field">Input Field</label>
    <input type="text" name="text_field" id="text_field"
           placeholder="this is the input area" />
  </fieldset>
</form>
```

```css
/* Add to end of file */
.side-by-side label,
.side-by-side input[type="text"] {
  display: inline-block;
}

.side-by-side label {
  margin-right: 1rem;
  vertical-align: middle;
}

.side-by-side input[type="text"] {
  vertical-align: middle;
  width: 35%;
}
```

Side by side isn't too much harder: convert `label` and `input` to `display: inline-block`, provide widths and heights, and vertically align them. But there's a problem: since `label` and `input` are now `inline-block`, if we have more than one label/input pair, they may end up all the same line or awkwardly separated depending on the viewport size.

One way to correct this is to wrap each label/input pair in a block element like `div`, but this leads to horizontal misalignment; they also don't provide much semantic meaning. To correct both of these issues, we can use description lists!

```html
<form action="#" class="styled-form side-by-side">
  <fieldset>
    <dl>
      <dt><label for="text_field">Input Field</label></dt>
      <dd><input type="text" id="text_field" name="text_field" /></dd>

      <dt><label for="another_field">Another Field</label></dt>
      <dd><input type="text" id="another_field" name="another_field" /></dd>
    </dl>
  </fieldset>
</form>
```

```css
.side-by-side input[type="text"] {
  width: 100%; /* Replaces 35% */
}

/* Add to end of file */
.side-by-side dl {
  font-size: 0;
}

.side-by-side dt,
.side-by-side dd {
  box-sizing: border-box;
  display: inline-block;
  font-size: 1rem;
  vertical-align: middle;
}

.side-by-side dt {
  padding-right: 1rem;
  width: 25%;
}

.side-by-side dd {
  width: 75%;
}
```

For even more flexibility, which is useful if you have lots of inputs, you can wrap each label/input pair in a separate `dl` and apply more classes as needed to get different sizes:

```html
<form action="#" class="styled-form top-to-bottom">
  <fieldset>
    <dl>
      <dt><label for="name">Name</label></dt>
      <dd><input type="text" id="name" /></dd>
    </dl>

    <dl class="address">
      <dt><label for="address1">Address</label></dt>
      <dd>
        <input type="text" id="address1" />
        <input type="text" id="address2" />
      </dd>
    </dl>

    <dl class="city partial">
      <dt><label for="city">City</label></dt>
      <dd><input type="text" id="city" /></dd>
    </dl>

    <dl class="state partial">
      <dt><label for="state">State</label></dt>
      <dd>
        <select id="state">
          <option>AK</option>
          <option>AL</option>
          <!-- You can download the complete list of states at -->
          <!-- https://launchschool.com/gists/2424a869 -->
        </select>
      </dd>
    </dl>

    <dl class="zipcode partial">
      <dt><label for="zipcode">Zip</label></dt>
      <dd><input type="text" id="zipcode" /></dd>
    </dl>

  </fieldset>
</form>
```

```css
/* Add to end of file */
.styled-form label {
  padding-top: 0.3333rem;
}

.top-to-bottom dl.partial {
  box-sizing: border-box;
  display: inline-block;
  padding-right: 1rem;
  vertical-align: top;
}

.top-to-bottom dl.address {
  width: 100%;
}

.top-to-bottom dl.city {
  width: 50%;
}

.top-to-bottom dl.state {
  width: 25%;
}

.top-to-bottom dl.zipcode {
  padding-right: 0;
  width: 25%;
}

.top-to-bottom dl dd {
  width: auto;
}

.top-to-bottom fieldset,
.top-to-bottom dl,
.top-to-bottom dl dd,
.top-to-bottom dl dt {
  font-size: 0;
}

.top-to-bottom dl label,
.top-to-bottom dl input[type="text"] {
  font-size: 1rem;
}

.top-to-bottom select {
  width: 100%;
}
```
