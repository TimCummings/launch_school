
# Practice Problems: The Box Model - 9/5/2020

This problem set will exercise your understanding of how a browser uses the box model to compute how much horizontal and vertical space it needs for each element. It focuses on the `width`, `height`, `padding`, `border`, and `margin` properties, as well as how the visual display model and the box-sizing mode interact with them.

1. Given the code below, what is the minimum width and height (in pixels) that the `div` needs to entirely contain the `img` element (including its margins)?

```html
<div>
  <img src="#" alt="test" />
</div>
```

```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

img {
  border: 4px solid red;
  box-sizing: content-box;
  display: inline-block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```

### Solution

With `box-sizing: content-box;` (which is also the default) for the image, `padding` and `border` will be added to the content-area; per the problem description, we must also account for the `margin`:

```
width  = width + (X-padding) + (X-border) + (X-margin)
       = 500px + (20px * 2)  + (4px * 2)  + (19px + 11px)
       = 500px + 40px        + 8px        + 30px
       = 578px

height = height + (Y-padding) + (Y-border) + (Y-margin)
       = 300px  + (10px * 2)  + (4px * 2)  + (20px + 10px)
       = 300px  + 20px        + 8px        + 30px
       = 358px
```

-> The image will occupy 578px of width and 358px of height.

Next, the `div` has `box-sizing: border-box;`, so its content area must contain the image and also its own `padding` and `border`:

```
width  = content (image) + div X-padding + div X-border
       = 578px           + 0             + (1px * 2)
       = 578px           + 0             + 2
       = 580px

height = content (image) + div Y-padding + div Y-border
       = 358px           + 0             + (1px * 2)
       = 360px
```
-> The div must be at least 580px wide and 360px high.

---

2. Given the code below, what is the minimum width and height (in pixels) that the `div` needs to entirely contain the `section` element (including its margins)? How does this differ from the result of the previous practice problem?

```html
<div>
  <section>content</section>
</div>
```

```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

section {
  border: 4px solid red;
  box-sizing: content-box;
  display: block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```

### Solution

The section (using`content-box`) will occupy:
```
width  = width + X-padding  + X-border  + X-margin
       = 500px + (20px * 2) + (4px * 2) + (19px + 11px)
       = 500px + 40px       + 8px       + 30px
       = 578px

height = height + Y-padding  + Y-border  + Y-margin
       = 300px  + (10px * 2) + (4px * 2) + (20px + 10px)
       = 300px  + 20px       + 8px       + 30px
       = 358px
```

-> 578px of width and 358px of height

Since the `div` is using `box-sizing: border-box;`, we must also account for its padding and border:

```
width  = content (section) + X-padding + X-border
       = 578px             + 0         + (1px * 2)
       = 580px

height = content (section) + Y-padding + Y-border
       = 358px             + 0         + (px * 2)
       = 360px
```

-> 580px wide and 360px high

This result is the same as the previous problem. The only difference I can spot is that the contained element (`section` in this case) has `display: block;` instead of `display: inline-block;`, but that doesn't effect our calculation if no sibling elements are present.

---

3. Given the code below, what is the minimum width and height (in pixels) that the `div` needs to entirely contain the `em` element (including its margins)?

```html
<div>
  <em>content</em>
</div>
```

```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

em {
  border: 4px solid red;
  box-sizing: content-box;
  display: inline;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```

### Solution

This is harder since `em` is an `inline` element: its `width` and `height` properties are ignored and the browser calculates those attributes based on the content.

`em`:
```
width  = content + X-padding  + X-border  + X-margin
       = content + (20px * 2) + (4px * 2) + (19px + 11px)
       = content + 40px       + 8px       + 30px
       = content + 78px

height = content
```

Since the `div` has `box-sizing: border-box;`, we must also account for its padding and border.

-> (content + 80px) of width and (content)px of height
We can't directly compute content without knowing the font.

#### Adjustments based on the provided solution

Even though an inline element's vertical padding and border may be oddly displayed if it's not fully contained by its parent, the question asks for the `div` to fully contain `em`, so we still have to calculate padding and border; we'll also add the assumed width and height from the solution:

```
width  = content + 80px
       = 50px    + 80px
       = 130px

height = content + Y-padding  + Y-border  + div-Y-border
height = 20px    + (10px * 2) + (4px * 2) + (1px * 2)
       = 20px    + 20px       + 8px       + 2px
       = 50px
```

-> 130px wide by 50px high

---

4. Given the code below, what is the minimum width and height (in pixels) that the `div` needs to be to entirely contain the `article` element (including its margins)?

```html
<div>
  <article>content</article>
</div>
```

```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: border-box;
  display: inline-block;
  margin: 0;
  padding: 0;
}

article {
  border: 4px solid red;
  box-sizing: border-box;
  display: inline-block;
  height: 300px;
  margin: 20px 19px 10px 11px;
  padding: 10px 20px;
  width: 500px;
}
```

### Solution

Since both elements have `box-sizing: border-box;`, we only need to account for the `article`'s `width`, `height`, and `margin` and the `div`'s `padding` and `border`:

```
width  = width + X-margin      + div-X-padding + div-X-border
       = 500px + (19px + 11px) + 0             + (1px * 2)
       = 500px + 30px          + 0             + 2px
       = 532px

height = height + Y-margin      + div-Y-padding + div-Y-border
       = 300px  + (20px + 10px) + 0             + (1px * 2)
       = 300px  + 30px          + 0             + 2px
       = 332px
```

-> 532px wide by 332px high

---

5. Given the code below:

```html
<div>
  <tag1>content</tag1><tag2>content</tag2>
</div>
```

```css
div {
  background-color: lightgray;
  border: 1px solid black;
  box-sizing: content-box;
  display: inline-block;
  margin: 0;
  padding: 0;
  width: 720px;
}

tag1, tag2 {
  box-sizing: border-box;
  height: 240px;
  margin: 0;
  padding: 0;
  width: 360px;
}

tag1 {
  background-color: yellow;
}

tag2 {
  background-color: lime;
}
```

Which of the following element pairs will display side-by-side in the `<div>`? Select all that apply:

1. Both elements are `block` elements.
2. Both elements are `inline` elements.
3. Both elements are `inline-block` elements.
4. One element is a `block` element, and one is an `inline` element.
5. One element is a `block` element, and one is an `inline-block` element.
6. One element is an `inline` element, and one is an `inline-block` element.

You may assume that any `inline` element has a **content width** of no more than 360 pixels. Remember, the `width` property doesn't affect `inline` elements, so this "content width" is the actual width of the content area as determined by your browser.

### Solution

2, 3, 6 (Any `block` element will be on its own line/row.)

---

6. Will the following code display the two article boxes side-by-side? If not, why not? How would you fix it so that it places the boxes side-by-side?

```html
<section>
  <article>content</article><article>more content</article>
</section>
```

```css
section {
  background-color: yellow;
  border: 1px solid red;
  box-sizing: content-box;
  display: inline-block;
  height: 400px;
  margin: 0;
  padding: 20px;
  width: 900px;
}

article {
  background-color: lime;
  border: 1px solid blue;
  height: 100%;
  margin: 0;
  padding: 10px;
  width: 50%;
}
```

### Solution

The articles will not be displayed side-by-side because articles default to `display: block;`. To display the articles side-by-side, two changes need to be made:

* set `display` to `inline-block` so that it's possible for them to be on the same line if there's available space, and...
* set `box-sizing` to `border-box`, otherwise the `10px` padding will be added to the `50%` width, which won't leave enough room for them to be side-by-side.

---

7. **Challenge.** Given our solution to the previous question, what will happen if we put the `article` tags on separate lines?

```html
<section>
  <article>content</article>
  <article>more content</article>
</section>
```

Try to figure out the answer without peeking. Why do you think this is?

### Solution

Putting the `article` tags on separate lines won't make any difference. HTML ignores whitespace.

#### Adjustments based on provided solution

I was incorrect: HTML doesn't ignore whitespace, but it does collapse repeated whitespace (such as a newline and multiple spaces in this example) to a single space character. However, even a single space character will occupy a small number of pixels, which will cause these two articles to once again appear on separate lines, since we have no pixels to spare.

The solution is to put them on the same line:

```html
<section>
  <article>content</article><article>more content</article>
</section>
```
