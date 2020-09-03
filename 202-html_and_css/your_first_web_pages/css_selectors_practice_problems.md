
# Practice Problems: CSS Selectors - 9/2/2020

Use the following prepared HTML file to complete this problem set: [css_practice.html](css_practice.html)

Add the required CSS to the `style` element at the top of the document. **Don't change the HTML**.

Use [this section of the Shay Howe tutorial](https://learn.shayhowe.com/html-css/getting-to-know-css/) and [this MDN page](https://developer.mozilla.org/en-US/docs/Learn/CSS/Introduction_to_CSS/Combinators_and_multiple_selectors) as you work this problem set. You should know how to use the basic selectors (tag, class, and id), but you're not expected to memorize the more complicated selectors. However, you should know how to find them.

1. Set the width of the page body to `600px`.

### Solution

```css
body {
  width: 600px;
}
```

---

2. Set the font size on all paragraphs to `18px`.

### Solution

```css
p {
  font-size: 18px;
}
```

---

3. Change the font for all list items (the `li` tags) to a `monospace` font, and give them a color of `purple`.

### Solution

```css
li {
  font-family: monospace;
  color: purple;
}
```

---

4. Remove the underlines from all links on the page.

### Solution

```css
a {
  text-decoration: none;
}
```

---

5. Change the `li` selector from problem 3 so that it no longer styles the lists inside the `header` section. Don't add any new CSS, but you can modify the selector for an existing rule. Afterward, the list items in the header should be blue with a proportional (non-monospace) font, and the numbers should be black. All remaining list items should be purple and monospace.

### Solution

```css
header li {
  color: blue;
}

main li {
  font-family: monospace;
  color: purple;
}
```

---

6. Set the color on all paragraphs that are inside an `article` element to `brown`.

### Solution

```css
article p {
  color: brown;
}
```

---

7. Add the background color `#e0e0e0` to the "First Article" heading.

### Solution

```css
.subheading {
  background-color: #e0e0e0;
}
```

---

8. Set the font size for the element with ID `intro` to `24px`.

### Solution

```css
#intro {
  font-size: 24px;
}
```

---

9. **Challenge**: Change the color for all list items directly within an unordered list in the `main` section to `green`. Be careful not to change any of the list items that don't belong to an unordered list, nor any of the list items in the `header` element.

### Solution

```css
main ul > li {
  color: green;
}
```
