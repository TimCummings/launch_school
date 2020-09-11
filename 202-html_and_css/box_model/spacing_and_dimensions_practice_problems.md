
# Practice Problems: Spacing and Dimensions - 9/8/2020

In these practice problems, we'll work with heights, widths, padding, margins, and a variety of dimensional units.

Some of these problems use [this image](https://d3jtzah944tvom.cloudfront.net/lesson_2/exercises_dimension_and_spacing/H%C3%B4tel_des_Invalides_-_20150801_16h09_%2810630%29.jpg). You may use it in your HTML like this:

```html
<img src="https://d3jtzah944tvom.cloudfront.net/lesson_2/exercises_dimension_and_spacing/H%C3%B4tel_des_Invalides_-_20150801_16h09_%2810630%29.jpg"
    alt="Demonstration of image sizing" />
```

We'll discuss images and the `img` tag in a later lesson.

1. Use CSS to set a fixed width on the image of 800 pixels, and center it in the window horizontally.

### Solution

```css
img {
  display: block;
  width: 800px;
  margin-left: auto;
  margin-right: auto;
}
```

#### Adjustments based on provided solution

Auto margin can be reduced to a single line with `margin: 0 auto;`

---

2. Using the code from the previous problem, change the `width` property for `img` to `100%`, and set the `max-width` property to `800px`. The image should expand to fit any container width up to 800 pixels. Resize your browser width and watch how that affects the photograph.

### Solution

```css
img {
  display: block;
  width: 100%;
  max-width: 800px;
  margin: 0 auto;
}
```

---

3. Using the code from the previous problem, set a fixed height on the image of 533 pixels. Resize the browser window and watch how the image dimensions change.

### Solution

```css
img {
  display: block;
  width: 100%;
  max-width: 800px;
  height: 533px;
  margin: 0 auto;
}
```

---

4. As you can see, having a variable size for one dimension and fixed for the other makes for a container with strange behavior: this one stretches horizontally but remains fixed vertically. Remove the height and update the CSS to ensure the width does not get smaller than 500 pixels.

### Solution

```css
img {
  display: block;
  width: 100%;
  max-width: 800px;
  min-width: 500px;
  margin: 0 auto;
}
```

---

5. Create a new HTML page with two consecutive `div` elements. Make each a fixed width and height of 300 pixels. Set the background color on the first `div` to `"#fcc"` (red) and the second to `"#ccf"` (blue).

### Solution

```html
<div id="first-div">
</div>
<div id="second-div">
</div>
```

```css
div {
  height: 300px;
  width: 300px;
}

#first-div {
  background-color: "#fcc";
}

#second-div {
  background-color: "#ccf";
}
```

#### Adjustments based on provided solution

Use semantic class/id names: `<div class="red">` and `<div class="blue">`.

---

6. Add a 5-pixel solid black border to the blue `div`. Compare the widths of the two boxes. Why is the blue box a different size?

### Solution

```css
.blue {
  background-color: #ccf;
  border: 5px solid black;
}
```

The blue box is a different size because, by default, its `box-sizing` property has a value of `content-box`. Consequently, its border is not included in its specified width, but added to it instead. It now has a width of 300px (for the content area) and 5px * 2 (for the border on both sides.)

---

7. Add 20 pixels padding to all four sides of the red `div`. Notice the different widths again. Add a CSS property to both elements to ensure the total width for each is `300px` rather than `300px` and then some.

### Solution

```css
div {
  box-sizing: border-box;
  height: 300px;
  width: 300px;
}

.red {
  background-color: #fcc;
  padding: 20px;
}
```

---

8. Change both boxes to place them side-by-side instead of stacked vertically. If necessary, increase the width of your browser window.

### Solution

```css
div {
  box-sizing: border-box;
  display: inline-block;
  height: 300px;
  width: 300px;
}
```

---

9. Add 20px of space between the red and blue boxes.

### Solution

```css
div {
  box-sizing: border-box;
  display: inline-block;
  height: 300px;
  margin: 0 10px;
  width: 300px;
}
```

#### Adjustments based on provided solution

Adding horizontal margin on both `div`s is not what was asked; it adds extra margin not just between them but outside them as well (to the left of the red `div` and to the right of the blue `div`. To do what was asked, add `margin-right` to only the red `div`:

```css
.red {
  background-color: #fcc;
  margin-right: 20px;
  padding: 20px;
}
```

---

10. Create a new HTML file with the following CSS and HTML:

```html
<body>
  <ul>
    <li>Item 1</li><!--
    --><li>Item 2</li><!--
    --><li>Item 3</li><!--
    --><li>Item 4</li>
  </ul>
</body>
```

```css
 body {
  margin: 50px;
}

ul {
  background-color: #a7ceff;
  border: 10px solid blue;
  list-style: none;
  padding: 0;
}

li {
  background-color: #ffc;
  border: 10px solid red;
  box-sizing: border-box;
  line-height: 120px;
  min-height: 120px;
  text-align: center;
}
```

Don't overlook the oddly-formatted comments between the list items above! They're a necessary part of this problem.

Add the CSS needed to list all four items side-by-side in one row. Each list item should use the same amount of space as the other elements, and together they should hide the blue background entirely (but not the blue border).

### Solution

Add to `li` CSS `display: inline-block;` and `width: 25%;`.

#### Notes

Recall the previous challenge exercise from the [box model practice problems](box_model_practice_problems.md) where two adjacent `inline-block` `article` elements had to be put on the same line of HTML to make them display on the same line due to HTML line breaks (if on different lines) rendering as a space and exceeding the width of the parent container. Using comments as seen here between the `li` elements is another strategy for eliminating unneeded spaces. Read about more here: https://css-tricks.com/fighting-the-space-between-inline-block-elements/

---

11. Using the code from the previous problem solution, set the left and right margin on each `li` element to 1%, but do not let the inner boxes wrap around - they must all continue to fit on the same line with no change in the outer box's size.

### Solution

Add to `li` CSS: `margin: 0 1%;`. `box-sizing: border-box;` includes `padding` and `border` in the element's dimensions, but not `margin`. If we can't change the size of the container, then we must change the size of the `li` elements. To account for 1% * 2 (each side) `margin`, we can decrease the `width` of each `li` by 2%: `width: 23%;`.
