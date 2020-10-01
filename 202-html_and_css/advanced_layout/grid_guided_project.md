
# Guided Project: Grid 9/30/2020

n this project, you'll use Grid to build a layout similar to the one we created in the previous assignment. The videos you watched earlier should give you an idea on how to proceed.

To get started, download the [initial project files](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/grid.zip) and unzip them. You can view the completed project [here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/grid/final/grid.html).

> Make all your modifications to the CSS file; don't make any changes to the HTML. Do not use any `float`, `position`, or `flex` properties, and don't convert any elements to `inline-block`. Use Grid features instead.
>
> Flex and Grid naturally work in concert. This contrived project intentionally restricts the use of Flex to force you to use Grid.

> This project may be hard if you have no prior exposure to Grid. Don't waste a lot of time struggling with it; check the solutions if you get stuck. We don't expect you to learn Grid in this course, merely see it in action.

As usual, there are different ways to complete this project. Don't worry if your CSS looks different, as long as it meets the requirements.

[Project files](grid/)

1. Load the completed project and your in-progress project from the downloaded file in your browser. Study the differences, and try to decide what general actions you must take to convert your project to one that matches the completed project. Think about the tasks you need to accomplish, not the CSS you need to code.

### Solution

* remove all margin
* reduce size of header (remove or reduce padding?)
* layout nav links horizontally
* make a three column layout with aside-1 (25%), article-1 (50%), and aside-2 (25%)
* make a two column layout with aside-3 (25%) and article-2 (75%)
* make the footer two columns with logo (25%) and copyright (75%)

#### Adjustments based on provided solution

Don't forget font, background-color, and color!

Remove padding along with margins.

---

2. Start by providing any global settings you think you will need. You can update this later.

### Solution

```css
html {
  background-color: white;
  color: black;
  /* ... */
}

* {
  margin: 0;
  padding: 0;
}
```

---

3. Convert the navigation links into a horizontal navigation bar:

### Solution

```css
ul {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  /* ... */
}
```

---

4. Organize the entire page as a grid of three columns and five lines, with named grid areas. The first and last column should each take up 1/4 of the page width, while the central column should take up 1/2 the page width. Use fractions, not percentages, to designate these measurements. The `header` should be on the top line, followed by the navigation bar. The content area consists of two lines. The first has two `aside` elements and an `article`, with the `article` in the larger center column. The next line consists of an `article` and an `aside`. Lastly, the `footer` should appear at the bottom of the grid.

```css
body {
  display: grid;
  grid-template-columns: 1fr 2fr 1fr;
  grid-template-rows: repeat(5, fr);
  grid-template-areas:
    "header header header"
    "nav nav nav"
    "aside-1 article-1 aside-2"
    "aside-3 article-2 article-2"
    "footer footer footer"
}

header {
  grid-area: header;
  /* ... */
}

nav {
  /* ... */
  grid-area: nav;
}

#article-1 {
  grid-area: article-1;
}

#article-2 {
  /* ... */
  grid-area: article-2;
}

#aside-1 {
  grid-area: aside-1;
}

#aside-2 {
  grid-area: aside-2;
}

#aside-3 {
  /* ... */
  grid-area: aside-3;
}
```

#### Adjustments based on provided solution

Rows don't need to be explicitly specified. Instead on the container (`body`) do `grid-auto-rows: min-content;`.

---

5. Divide the footer area into a sub-grid that will show the logo on the left and the copyright notice on the right.

### Solution

```css
footer {
  /* ... */
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-template-areas: "logo copyright";
}

#copyright {
  grid-area: copyright;
  /* ... */
}

#logo {
  /* ... */
  grid-area: logo;
}
```

#### Adjustments based on provided solution

There's no need to specify `grid-template-columns`.

---

6. Reduce the size of the image to the same size as the first column of the content area.

### Solution

```css
footer {
  /* ... */
  grid-template-columns: 1fr 3fr;
}

#logo img {
  display: block;
  width: 100%;
}
```

#### Adjustments based on provided solution

Use `object-fit: cover;` on the image to maintain its aspect ratio while resizing.

---

7. Right-align and vertically center the copyright message in the yellow box.

### Solution

```css
#copyright {
  /* ... */
  place-self: center end;
}
```

---

You can view the completed CSS file [here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/grid/final/grid.css).
