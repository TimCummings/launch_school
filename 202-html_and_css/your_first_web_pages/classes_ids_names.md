
# Classes, IDs, and Names - 8/24/2020

HTML provides three ways to identify certain elements: classes, IDs, and names. Any element can use a `class` or `id` attribute; several elements can also use the `name` attribute.

## Classes

The `class` attribute identifies a set of elements that you want to style consistently, e.g. a list of students, with slightly different styling for TAs:

```html
<table>
  <tbody>
    <tr class="teaching-assistant">
      <td>Elizabeth</td>
      <td>JS230</td>
    </tr>

    <tr>
      <td>Nancy</td>
      <td>RB101</td>
    </tr>
  </tbody>
</table>
```

```css
tr {
  background-color: lime;
  font-size: 200%;
}

.teaching-assistant {
  background-color: yellow;
}
```

`class` notes:
* any number of elements may belong to the same class
* an element may belong to one or more classes (space delimited, e.g. `btn btn-success`)
* use semantic names, e.g. `teaching-assistant`, not `yellow-background`

## IDs

The `id` attribute applies a unique identification string to a single element. No other elements on the page should have the same `id` attribute.

```html
<h1 id="headline">This is my headline</h1>
```

```css
#headline {
  color: red;
  font-size: 48px;
}
```

`id` notes:
* each ID on a page must be unique
  * browsers may not warn you about this, and may even apply `id` styles to multiple elements; it will cause problems with JavaScript though
* each element may have one ID or none
* use semantic names, e.g. `headline`, not `big-font`

## Names

The `name` attribute ties form elements to data on the server. It usually does not play a role in styling. You *can* select via `name` with `[name="field-name"]`, but you shouldn't; use a `class` or `id` selector instead.

When you submit a form, the browser sends form data as name/value pairs with each name coming from the associated `name` attribute, e.g.

```html
<form method="get" action="#">
  <label for="first-name-field">First name:</label>
  <input type="text" name="first-name" id="first-name-field" />

  <label for="last-name-field">Last name:</label>
  <input type="text" name="last-name" id="last-name-field" />

  <input type="submit" value="Search" />
</form>
```

When this form is submitted, the browser constructs a query string that looks like: `first-name=Joe&last-name=Jones`.

**NB**: The browser does **not** send the `id` attribute to the server! Since the `for` attribute references an ID, it's common to give form elements a `name` and `id` of the same value:

```html
<form method="get" action="#">
  <label for="first-name">First name:</label>
  <input type="text" name="first-name" id="first-name" />

  <label for="last-name">Last name:</label>
  <input type="text" name="last-name" id="last-name" />

  <input type="submit" value="Search" />
</form>
```

`name` notes:
* use `name` attribute to assign a name to a form data attribute that the server can use to obtain the value
* not all tags accept a `name` attribute; it's mainlyl used for form input controls
* always use a `name` attribute on form elements that accept it
* each name in a form should be unique to that form except for radios and checks in a single group
* use descriptive names, not semantic e.g. `name="last-name"`, not `name="input-field"`
* don't select elements via `name` for CSS; use `class` or `id` instead
