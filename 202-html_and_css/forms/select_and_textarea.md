
# Select and Textarea - 9/24/2020

## Textarea

`textarea` lets a user input multiple lines of text. Unlike `input type="text"`, `textarea` preserves carriage returns, newlines, and other whitespace. Also unlike text input, `textarea` does NOT use the `value` attribute for submitting its data; instead, its value must be included between its tags:

```html
<form action="#" method="post">
  <fieldset>
    <label>
      Comment
      <textarea name="tweet">I got 20% off my first purchase at joesburgers.com! You can too!</textarea>
    </label>
  </fieldset>
</form>
```

You can control the width and height of `textarea` with the `rows` and `cols` attributes; as with `input`'s `size`, these values are approximations and are overridden by CSS `width` and `height`.

Most browsers allow users to manually re-size `textarea`s; this can be disabled via the [CSS resize property](https://developer.mozilla.org/en-US/docs/Web/CSS/resize).

## Select

`select` provides a lists of options via a dropdown from which a user can select zero or more options. There are two possible types of child elements: `option` and `optgroup`. `select` uses the `name` attribute like other form elements, but the values shown to the user and submitted to the server are determined by contained `option` elements.

### The `option` Element

`option` defines one possible choice within a `select` tag. Like a form without inputs, a `select` without `option`s is useless. `option` uses the `value` attribute to determine the value associated with the `select` element's name that is submitted with the form to the server; if a selected `option` does not have a `value`, the browser will use the text contained within the `option` element.

`select` elements frequently have a default placeholder `option` with text like `Choose one` and the following attributes: `value=""`, `disabled`, and `selected`. The user sees it in the `select` before opening the dropdown (because of `selected`) but cannot interact with it (because of `disabled`) and it won't have any side affects (because of its empty string `value`.)

By default, `select` allows a user to choose only a single option. The `multiple` attribute allows multiple options to be selected (with `ctrl` click on Windows or `cmd` click on Mac.)

```html
<form action="#" method="post">
  <fieldset>
    <label>
      Choose Your Favorite Movies
      <select name="favorites" multiple size="4">
        <option value="" disabled selected>Select One or More</option>
        <option>2001: A Space Odyssey</option>
        <option>Arrival</option>
        <option>Close Encounters of the Third Kind</option>
        <option>District 9</option>
        <option>Guardians of the Galaxy</option>
        <option>Interstellar</option>
        <option>Serenity</option>
        <option>Silent Running</option>
      </select>
    </label>
  </fieldset>
</form>
```
