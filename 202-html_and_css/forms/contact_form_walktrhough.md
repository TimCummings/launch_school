
# Walkthrough Project: Contact Form - 9/25/2020

In this project, you'll create a contact form with a variety of controls. Our intent here is for you to follow along with the accompanying videos, but after you've tried to complete as much as you can using the steps outlined below. Whether you do the project entirely on your own or need lots of help doesn't matter; what matters is that you try. If you do manage to finish on your own, watch the videos anyway, and compare your solution with ours.

Persistent file: ![contact_form.html](contact_form.html)

1. Create a web page that contains a contact form. Using your newly acquired knowledge, create the label and input fields for a first name, last name, email address, city, state, and zip code. Each input field can appear on a separate line.

### Solution

```html
<form action="#" method="post">
  <fieldset>
    <dl>
      <dt><label for="first_name">First Name</label></dt>
      <dd><input type="text" name="first_name" id="first_name" /></dd>

      <dt><label for="last_name">Last Name</label></dt>
      <dd><input type="text" name="last_name" id="last_name" /></dd>

      <dt><label for="email">Email Address</label></dt>
      <dd><input type="email" name="email" id="email" /></dd>

      <dt><label for="city">City</label></dt>
      <dd><input type="text" name="city" id="city" /></dd>

      <dt><label for="state">State</label></dt>
      <dd><input type="text" name="state" id="state" maxlength="2" /></dd>

      <dt><label for="zip_code">Zip Code</label></dt>
      <dd><input type="text" name="zip_code" id="zip_code" /></dd>
    </dl>

    <input type="submit" />
  </fieldset>
</form>
```

```css
html, body {
  font-size: 16px;
}

form dl {
  font-size: 0;
}

form dt,
form dd {
  box-sizing: border-box;
  display: inline-block;
  font-size: 1rem;
  line-height: 1.75rem;
  margin: 0.25rem 0;
  vertical-align: middle;
}

form dt {
  padding-right: 3rem;
  width: 25%;
}

form dd {
  width: 75%;
}

input[type="text"],
input[type="email"] {
  width: 100%;
}
```

---

2. Assume that users are from the United States. The `state` select element should contain each state's two-letter abbreviation as `option` options. You don't need to add `value` attributes to the `option` elements; the `form` can submit the two-letter abbreviations to the server. You saved a copy of the list of states earlier, right?

### Solution

```html
<dt><label for="state">State</label></dt>
<dd><select name="state" id="state">
  <option>AK</option>
  <option>AL</option>
  <!-- ... -->
  <option>WY</option>
</select></dd>
```

---

3. Use the most appropriate input type for the email and zip code inputs, along with a `placeholder` attribute that shows an example of a properly formatted email address and Zip Code. (There is no "zipcode" input type; use another input type.) Since Zip Codes always have five digits (we'll ignore Zip+4), you should also set a maximum length for this input. See if you can figure out how to require exactly 5 digits.

### Solution

```html
<dt><label for="email">Email Address</label></dt>
<dd>
  <input type="email" name="email" id="email"
         placeholder="user@domain.com" />
</dd>

<!-- ... -->

<dt><label for="zip_code">Zip Code</label></dt>
<dd>
  <input type="text" name="zip_code" id="zip_code"
         minlength="5" maxlength="5" placeholder="12345" />
</dd>
</dl>
```

---

4.  Add some inputs that will help you get to know your users better. Begin with a question that asks "Which of these colors do you like best?" and add a list of inputs to represent colors. Make sure you use an input type that allows for precisely one color choice. Ensure that the browser pre-selects the first color in the list when the page loads.

### Solution

```html
  <dt>Which of these colors do you like best?</dt>
  <dd>
    <label>
      <input type="radio" name="color" value="red" checked />
      Red
    </label>
    <label>
      <input type="radio" name="color" value="green" />
      Green
    </label>
    <label>
      <input type="radio" name="color" value="blue" />
    Blue
  </label>
</dd>
```

```css
form dt,
form dd {
/* ... */
line-height: 1.75rem; /* delete this line */
/* ... */
}
```

---

5. Add another question that asks "Which web technologies do you want to learn?" and add a list of inputs that allow the user to pick any number of answers. Add some technologies (HTML, CSS, Javascript, Ruby, Rails, etc.) to the list.

```html
<dt>Which web technologies do you want to learn?</dt>
<dd>
  <label>
    <input type="checkbox" name="web_technology" value="html" />
    HTML
  </label>
  <label>
    <input type="checkbox" name="web_technology" value="css" />
    CSS
  </label>
  <label>
    <input type="checkbox" name="web_technology" value="javascript" />
    Javascript
  </label>
  <label>
    <input type="checkbox" name="web_technology" value="ruby" />
    Ruby
  </label>
  <label>
    <input type="checkbox" name="web_technology" value="rails" />
    Rails
  </label>
</dd>
```

---

6. Add the most important part of a contact form: a comment box that lets the user enter several lines or paragraphs of text. Be sure the comment box displays up to around 6 rows and 80 columns of text but also scrolls as needed if the user enters more than that.

### Solution

```html
<dt><label>Comments</label></dt>
<dd><textarea name="comments" rows="6" cols="80"></textarea></dd>
```

```css
textarea {
  resize: both;
}
```

---

7. When the user clicks the submit button, the browser should send a timestamp to the server along with the other form data. Since we don't have a way to determine the date with HTML and CSS alone, you can use a constant value like today's date, e.g., `2018-02-17` (year-month-day). The form should have an `input` tag for the timestamp, but the browser should not display it to the user; you can use `type="hidden"` for this control.

### Solution

```html
<input type="hidden" name="timestamp" id="timestamp"
       value="2020-09-26" />
```

---

8. Add a `submit` input to create a button with the name `Send`. You should also include a `reset` button so the user can clear the form and start over.

### Solution

```html
<input type="submit" value="Send" />
<button type="reset">Reset</button>
```

---

9. Since we don't have an actual server that we can use, you can use the action URL # in your form.

### Solution

```html
<form action="#" method="post">
```

### Adjustments based on walkthrough

3. My initial solution limits zip code input to exactly 5 *characters*, but does not limit those characters to only digits. This can be done via the [pattern attribute](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input#htmlattrdefpattern):

```html
<dt><label for="zip_code">Zip Code (digits only)</label></dt>
<dd>
<input type="text" name="zip_code" id="zip_code"
       minlength="5" maxlength="5" placeholder="12345"
       pattern="[0-9]{5}" />
</dd>
```

---

Change the default page title!

---

4/5. Unordered lists make more semantic sense than dumping checkboxes and radios into a single `<dd>`.

For valid HTML, this must be placed **outside** of the existing `dl`, which must be terminated and then re-opened after this to still contain the comment `textarea`.

```html
<p>Which of these colors do you like best?</p>
<ul>
  <li>
    <label>
      <input type="radio" name="color" value="red" checked />
      Red
    </label>
  </li>
  <li>
    <label>
      <input type="radio" name="color" value="green" />
      Green
    </label>
  </li>
  <li>
    <label>
      <input type="radio" name="color" value="blue" />
      Blue
    </label>
  </li>
</ul>

<dt>Which web technologies do you want to learn?</dt>
<ul>
  <li>
    <label>
      <input type="checkbox" name="web_technology" value="html" />
      HTML
    </label>
  </li>
  <li>
    <label>
      <input type="checkbox" name="web_technology" value="css" />
      CSS
    </label>
  </li>
  <li>
    <label>
      <input type="checkbox" name="web_technology" value="javascript" />
      Javascript
    </label>
  </li>
  <li>
    <label>
      <input type="checkbox" name="web_technology" value="ruby" />
      Ruby
    </label>
  </li>
  <li>
    <label>
      <input type="checkbox" name="web_technology" value="rails" />
      Rails
    </label>
  </li>
</ul>
```

```css
li {
  font-size: 1rem;
}
```

## CSS

In the next video, we'll create some CSS to make our form more presentable. If you want to attempt styling it yourself, feel free to give it a try. See the [completed form here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_5/contact_form/index_v1.html) to determine the expected appearance.

### Solution

Set `fieldset` width, center it, and remove the border:

```css
fieldset {
  border: none;
  box-sizing: border-box;
  margin: 0 auto;
  width: 600px;
}
```

Adjust font:

```css
html, body {
  font-family: Helvetica, Arial, sans-serif;
  /* ... */
```

Adjust labels and fields to top-and-bottom style and add some spacing between groups:

```css
form dt,
form dd {
  /* ... */
  display: block;
  /* ... */
  margin: 0;

  /* DELETE vertical-align: middle; */
}

/* DELETE
form dt {
  padding-right: 3rem;
  width: 25%;
} */

/* DELETE
form dd {
  width: 75%;
} */

form dt {
  margin-bottom: 0.4rem;
}

form dd {
  margin-bottom: 1.5rem;
}
```

Adjust <input> height and border:

```css
input[type="text"],
input[type="email"] {
  border: 1px solid #cecece;
  box-sizing: border-box;
  font-size: 14px;
  height: 1.5rem;
  padding: 0 0.5rem;
  width: 100%;
}
```

Adjust dropdown styling:

```css
select {
  font-size: 14px;
  padding: 3px;
}
```

Adjust checkbox and radio lists:

```css
form p {
  font-size: 1rem;
  margin-bottom: 0.25rem;
}

/* ... */

form ul {
  list-style: none;
  font-size: 14px;
  margin-top: 0;
  padding: 0;
}

/* DELETE
li {
  font-size: 1rem;
} */
```

Adjust `textarea` border and size:

```css
textarea {
  border: 1px solid #cecece;
  box-sizing: border-box;
  resize: both;
  width: 100%;
}
```

Adjust space between final `input` and buttons:

```css
form dd:last-of-type {
  margin-bottom: 0.5rem;
}
```
