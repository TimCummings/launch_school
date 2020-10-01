
# Practice Problems: Floats (1) 9/27/2020

For these problems, you'll work with two columns of different sizes. You can grab some content for both over at [lipsum.com](http://www.lipsum.com/); generate several paragraphs of copy for both columns. For the best results, the two columns should have differing amounts of text.

After most problem descriptions, you'll see a screenshot of how your page should look. The background colors help show where each element begins and ends; choose any colors you want.

1. Create a `section` element with a fixed width of 750px, and horizontally center it on the page using CSS margins. Create two columns inside it, a 500px-wide `article` and a 250px-wide `aside`, positioned side-by-side with CSS floats. The left column should contain the `article`. Each column should have 1rem of whitespace between the text and edges of the container. Add some background colors to the `body`, `section`, `article`, and `aside` body so you can see the boundaries of each element.

### Solution

```html
<body>
  <section>
    <article>
      <p><!-- lipsum text --></p>
    </article>
    <aside>
      <p><!-- lipsum text --></p>
    </aside>
  </section>
</body>
```

```css
body {
  background-color: steelblue;
}

section {
  background-color: thistle;
  margin: 0 auto;
  width: 750px;
}

article {
  background-color: teal;
  box-sizing: border-box;
  float: left;
  padding: 1rem;
  width: 500px;
}

aside {
  background-color: wheat;
  box-sizing: border-box;
  float: right;
  padding: 1rem;
  width: 250px;
}
```

---

2. If necessary, add some more text to the `article` to ensure it is noticeably taller than the `aside`. Can you see the background color you set on the section element? Why not? What can you add to your CSS to fix it?

### Solution

The `section`'s background is not visible because we haven't cleared our floats. We can make the `section` visible by setting `overflow` or by adding a clearfix.

Overflow:

```css
/* add to existing selector: */
section {
  overflow: hidden;
}
```

Clearfix:

```css
section::after {
  clear: both;
  content: "";
  display: block;
}
```

---

3. Remove the fixed width of 750px from the `section` and set a maximum width of 1000px instead. Modify the right column to take up the remainder of the space without floating the column or giving it a specific width.

### Solution

```css
section {
  background-color: thistle;
  margin: 0 auto;
  max-width: 1000px;
  /* DELETE width: 750px; */
}

aside {
  background-color: wheat;
  box-sizing: border-box;
  padding: 1rem;
  /* DELETE float: right; */
  /* DELETE width: 250px; */
}
```

This is close but not quite right. I've lost the left padding in the `aside` element. It appears, via the inspector, that the `aside` is taking the full width of the container, but its contained `p` text is rendering beside the left floated `article`.

#### Provided solution

Removing the `float` and `width` properties from the last floated element in a row and adding `overflow: hidden` to it (rather than its container) will cause it to take up the remaining space in the row. This is useful for variable width layouts when the last element should take all remaining room.

```css
section {
  background-color: thistle;
  margin: 0 auto;
  max-width: 1000px;
}

/* ... */

aside {
  background-color: wheat;
  box-sizing: border-box;
  float: none;
  overflow: hidden;
  padding: 1rem;
}
```

---

4. Change the left column from a fixed width to a variable width of 70% of the parent's width.

### Solution

```css
article {
  /* ... */
  width: 70%;
}
```

---

5. Add a `footer` below the two columns.

### Solution

The simplest solution seems to be placing the `footer` outside of the `section`, but it's not clear if that's a valid option or not.

```html
  <!-- ... -->
  </section>
  <footer>
    <p>filler text</p>
  </footer>
```

```css
footer {
  background-color: saddlebrown;
  margin: 0;
  padding: 1rem;
}
```

#### Adjustments based on provided solution

From the provided solution, it looks like it was intended for the `footer` to be inside the `section` instead of outside. This can be accomplished by removing the clearfix and applying `clear: both` to the footer:

```html
  <!-- ... -->
  <footer>
    <p>filler text</p>
  </footer>
</section>
```

```css
/* DELETE
section::after {
  clear: both;
  content: "";
  display: block;
} */

footer {
  background-color: saddlebrown;
  clear: both;
  margin: 0;
  padding: 1rem;
}
```
