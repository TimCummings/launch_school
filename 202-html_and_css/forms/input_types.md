
# Input Types - 9/23/2020

`input` is the most versatile and widely used form widget. Most controls are `input` elements. Some look identical in various browsers, e.g. `text`, `email`, and `tel`, but some look radically different e.g. `submit` and `checkbox`.

## Type

When creating an `input` element, start with the `type` attribute. There are LOTS of these in HTML5. Not all are frequently used, but all serve a purpose and provide semantic meaning. Browsers may even provide something extra based on `type`, such as tailoring the on-screen keyboard on a mobile device. The most common are:

### Text

`text` creates a simple text entry field. Always validate the input and also consider setting a max length via the `maxlength` attribute.

```html
<form action="#" method="post">
  <fieldset>
    <label>
      First Name
      <input type="text" name="first_name" value="Tom" />
    </label>
  </fieldset>
</form>
```

### Password

`password` creates a single line text entry field with an obscured value for sensitive information. Validate and set a maxlength.

```html
<form action="#" method="post">
  <fieldset>
    <label for="password">Password</label>
    <input type="password" name="password" id="password"
           value="Not-good-password" size="35" />
  </fieldset>
</form>
```

> The `value` attribute above is illustrative; don't provide default password values.

### Email

`email` provides a text field for the entry of an email address, e.g. `username@domain`. Browsers may provide some minimal validation, but you as the developer should validate this yourself.

```html
<form action="#" method="post">
  <fieldset>
    <label>
      Email
      <input type="email" name="email" placeholder="username@domain" />
    </label>
  </fieldset>
</form>
```

### Telephone

`tel` allows the entry of a telephone number. Browsers don't provide validation due to the wide variance of telephone number formats across the world.

```html
<form action="#" method="post">
  <fieldset>
    <label>
      Phone
      <input type="tel" name="phone" placeholder="(###) ###-####" />
    </label>
  </fieldset>
</form>
```

## Checkbox

`checkbox`es lets the user select one or more items from a list. Use the `name` attribute to name a set of related checkboxes (all checkboxes in the set should have the same `name`.) Use the `value` attribute to provide the value that will be sent to the server on form submission if this checkbox is checked. Use the `checked` boolean attribute to pre-check a checkbox.

```html
<form action="#" method="post">
  <fieldset>
    <label>
      <input type="checkbox" name="choice" value="search" />
      Sort search results
    </label>

    <label>
      <input type="checkbox" name="choice" value="google" checked />
      Search on Google
    </label>

    <label>
      <input type="checkbox" name="choice" value="recent" checked />
      Recent results (within last year)
    </label>
  </fieldset>
</form>
```

Checked elements can easily be styled via the CSS `:checked` pseudoclass.

With the above format, the browser sends a `name=value` pair for each checked checkbox (and nothing for the unchecked ones.) If the above form is submitted as-is, the browser will send `choice=google` and `choice=recent`.

There's an alternative format that uses unique names and omits the `value` attribute (the browser will send the value of `on`):

```html
<form action="#" method="post">
  <fieldset>
    <label>
      <input type="checkbox" name="search" />
      Sort search results
    </label>

    <label>
      <input type="checkbox" name="google" checked />
      Search on Google
    </label>

    <label>
      <input type="checkbox" name="recent" checked />
      Recent results (within last year)
    </label>
  </fieldset>
</form>
```

In this case, the browser sends `google=on` and `recent=on`. Use whichever format your back-end code expects. In most cases, it's easier to use separate `name` values.

### Radio

`radio` lets the user select zero or one items from a list. There are many similarites to checkboxes: Use the `name` attribute to name a set of related radio buttons (from which only a single radio may be selected.) Use the `value` attribute to define the value that will be submitted to the server. Use the boolean `checked` attribute to mark the default option. If there's no default, you can use the `required` attribute on all radios in a group to enforce the selection of one.

```html
<form action="#" method="post">
  <fieldset>
    <label>
      <input type="radio" name="color" value="red" />
      Red
    </label>

    <label>
      <input type="radio" name="color" value="green" checked />
      Green
    </label>

    <label>
      <input type="radio" name="color" value="blue" />
      Blue
    </label>
  </fieldset>
</form>
```

Radio buttons generally become unwiedly at 5-8 items; consider a `select` this at that point.

### Submit

`submit` provides a button the user can click to submit form data to the server. The `formaction` attribute can be used to override the form's `action` attribute (see previous example.

```html
<form action="#" method="post">
  <fieldset>
    <input type="submit" value="Save" />
  </fieldset>
</form>
```

### Reset

`reset` provides a button the user can click to reset all form data to its default values (no request is sent to the server.)

```html
<form action="#" method="post">
  <fieldset>
    <input type="reset" value="Clear Form" />
  </fieldset>
</form>
```

### Others

See the documentation: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input.
