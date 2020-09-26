
# Guided Project: Tweaking the Contact Form - 9/26/2020

In this project, we'll modify the completed code from the previous assignment to make the form more attractive. We will put the first and last names on a single line, and the three address fields on another.

1. Since we want to treat each input in the form differently, we should use separate description lists for each field. Adjust the HTML to use a description list to pair the `label` and `input` elements.

### Solution

```html
<form action="#" method="post">
  <fieldset>
    <dl>
      <dt><label for="first_name">First Name</label></dt>
      <dd><input type="text" name="first_name" id="first_name" /></dd>
    </dl>

    <dl>
      <dt><label for="last_name">Last Name</label></dt>
      <dd><input type="text" name="last_name" id="last_name" /></dd>
    </dl>

    <dl>
      <dt><label for="email">Email Address</label></dt>
      <dd>
        <input type="email" name="email" id="email"
               placeholder="user@domain.com" />
      </dd>
    </dl>

    <dl>
      <dt><label for="city">City</label></dt>
      <dd><input type="text" name="city" id="city" /></dd>
    </dl>

    <dl>
      <dt><label for="state">State</label></dt>
      <dd><select name="state" id="state">
        <option>AK</option>
        <option>AL</option>
        <option>AR</option>
        <option>AZ</option>
        <option>CA</option>
        <option>CO</option>
        <option>CT</option>
        <option>DC</option>
        <option>DE</option>
        <option>FL</option>
        <option>GA</option>
        <option>HI</option>
        <option>IA</option>
        <option>ID</option>
        <option>IL</option>
        <option>IN</option>
        <option>KS</option>
        <option>KY</option>
        <option>LA</option>
        <option>MA</option>
        <option>MD</option>
        <option>ME</option>
        <option>MI</option>
        <option>MN</option>
        <option>MO</option>
        <option>MS</option>
        <option>MT</option>
        <option>NC</option>
        <option>ND</option>
        <option>NE</option>
        <option>NH</option>
        <option>NJ</option>
        <option>NM</option>
        <option>NV</option>
        <option>NY</option>
        <option>OH</option>
        <option>OK</option>
        <option>OR</option>
        <option>PA</option>
        <option>RI</option>
        <option>SC</option>
        <option>SD</option>
        <option>TN</option>
        <option>TX</option>
        <option>UT</option>
        <option>VA</option>
        <option>VT</option>
        <option>WA</option>
        <option>WI</option>
        <option>WV</option>
        <option>WY</option>
      </select></dd>
    </dl>

    <dl>
      <dt><label for="zip_code">Zip Code (digits only)</label></dt>
      <dd>
        <input type="text" name="zip_code" id="zip_code"
               minlength="5" maxlength="5" placeholder="12345"
               pattern="[0-9]{5}" />
      </dd>
    </dl>

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

    <p>Which web technologies do you want to learn?</p>
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

    <dl>
      <dt><label>Comments</label></dt>
      <dd><textarea name="comments" rows="6" cols="80"></textarea></dd>
    </dl>

    <input type="hidden" name="timestamp" id="timestamp"
           value="2020-09-26" />

    <input type="submit" value="Send" />
    <button type="reset">Reset</button>
  </fieldset>
</form>
```

---

2. Put the first and last name fields on the same line. Each of the inputs should take up 50% of the form's width, counting any padding or margins.

### Solution

```html
<dl class="two-columns">
  <dt><label for="first_name">First Name</label></dt>
  <dd><input type="text" name="first_name" id="first_name" /></dd>
</dl>

<dl class="two-columns">
  <dt><label for="last_name">Last Name</label></dt>
  <dd><input type="text" name="last_name" id="last_name" /></dd>
</dl>
```

```css
.two-columns {
  box-sizing: border-box;
  display: inline-block;
  width: 50%;
}

dl:first-of-type {
  padding-right: 0.5rem;
}

dl.two-columns + dl.two-columns {
  padding-left: 0.5rem;
}
```

#### Adjustments based on provided solution

Splitting up the CSS between multiple classes should be easier to extend and maintain. The provided naming also makes more semantic sense.

```html
<dl class="one-half left">
  <dt><label for="first_name">First Name</label></dt>
  <dd><input type="text" name="first_name" id="first_name" /></dd>
</dl>

<dl class="one-half right">
  <dt><label for="last_name">Last Name</label></dt>
  <dd><input type="text" name="last_name" id="last_name" /></dd>
</dl>
```

```css
.one-half {
  box-sizing: border-box;
  display: inline-block;
  width: 50%;
}

.left {
  padding-right: 0.5rem;
}

.right {
  padding-left: 0.5rem;
}
```

---

3. Put the final three address fields on the same line. The city should consume 50% of the available width, the state 10%, and the zip code 40%.

### Solution

```html
<dl class="one-half left">
  <dt><label for="city">City</label></dt>
  <dd><input type="text" name="city" id="city" /></dd>
</dl>

<dl class="one-tenth">
  <dt><label for="state">State</label></dt>
  <dd><select name="state" id="state">
    <option>AK</option>
    <!-- ... -->
    <option>WY</option>
  </select></dd>
</dl>

<dl class="forty-percent right">
  <dt><label for="zip_code">Zip Code (digits only)</label></dt>
  <dd>
    <input type="text" name="zip_code" id="zip_code"
           minlength="5" maxlength="5" placeholder="12345"
           pattern="[0-9]{5}" />
  </dd>
</dl>
```

```css
select {
  font-size: 14px;
  padding: 3px;
  width: 100%;
}

/* ... */

.forty-percent {
  box-sizing: border-box;
  display: inline-block;
  width: 40%;
}

.one-tenth {
  box-sizing: border-box;
  display: inline-block;
  width: 10%;
}
```

### Adjustments based on provided solution

Better names again: change `forty-percent` class to `four-tenths`.

---

Further adjustments:

Fix spacing between groups of labels/inputs:

```css
/* DELETE
form dd {
  margin-bottom: 1.5rem;
}

form dd:last-of-type {
  margin-bottom: 0.5rem;
} */

/* add to existing selectors: */
form dl {
  margin-bottom: 1.5rem;
}

form p {
  margin-top: 1.5rem;
}

form ul {
  margin-bottom: 1.5rem;
}
```
