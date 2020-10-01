
# Guided Project: Flex - 9/29/2020

In this project, you'll use Flex to layout a partially completed web page. It will give you a general idea of how to use Flex.

To get started, download the [initial project files](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/flex.zip) and unzip them. You can view the completed project [here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/flex/final/flex.html).

> Make all your modifications to the CSS file; don't make any changes to the HTML. Do not use any `float`, `position`, or `grid` properties, and don't convert any elements to `inline-block`. Use Flex features instead.

> Flex and Grid naturally work in concert. This contrived project intentionally restricts the use of Grid to force you to use Flex.

This project may be hard if you have no prior exposure to Flex. Don't waste a lot of time struggling with it; check the solutions if you get stuck. We don't expect you to learn Flex in this course, merely see it in action.

This project probably has a variety of solutions. Don't worry if your CSS looks different, as long as it meets the requirements.

[Project files](flex/)

1. Load the completed project and your in-progress project from the downloaded file in your browser. Study the differences, and try to decide what general actions you must take to convert your project to one that matches the completed project. Think about the tasks you need to accomplish, not the CSS you need to code.

### Solution

* header
  * flush with top of page
  * stretch to fill entire page width
* nav
  * links need to be laid out horizontally to evenly fill all available space (no space between items, items should shrink/grow to take all available space)
* article and asides need to be laid out horizontally to specified proportions (article at 50%, each aside at 25%)
* footer
  * logo and image need to be laid out horizontally
  * logo and image need to be the same height (shrink image)
* all margin between elements needs to be removed

---

2. Start by providing any global settings you think you will need. You can update this later.

### Solution

```css
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
```

#### Adjustments based on provided solution

Also set background-color and color:

```css
html {
  background-color: white;
  color: black;
  /* ... */
}
```

---

3. Give the header a blue background; the `h1` heading has a blue background, but not the `header`.

### Solution

```css
header {
  background-color: blue;
  padding: 1rem;
  text-align: center;
}
```

---

4. Convert the navigation links into a horizontal navigation bar:

### Solution

```css
ul {
  display: flex;
  justify-content: space-around;
  /* ... */
}
```

---

5. Create three columns of text - an `article` and two `aside`s - as the main body of the page. The `article` should consume half the page width, while the `aside`s should each consume one-quarter (that is, the `article` is twice the width of each `aside`). Each column should be the same height, no matter how much text it contains.

### Solution

```css
main {
  display: flex;
}

article {
  flex: 2;
}

aside {
  /* ... */
  flex: 1;
}
```

---

6. Create a two-column `footer` with the copyright notice on the left, and the 200px high image on the right.

### Solution

```css
footer {
  /* .. */
  display: flex;
}

#copyright {
  flex: auto;
  /* ... */
}

#logo {
  /* ... */
  flex: 0 0 auto;
}

#logo img {
  display: block;
  height: 200px;
}
```

#### Adjustments based on provided solution

`justify-content` on the flex container is a cleaner way of getting the copyright and image sizes correct:

```css
footer {
  background-color: yellow;
  display: flex;
  /* ADD: */
  justify-content: space-between;
}

#copyright {
  /* DELETE flex: auto; */
  margin: 0 1rem;
}

#logo {
  background-color: orange;
  /* DELETE flex: 0 0 auto; */
}
```

---

7. Swap the positions of the copyright notice and image to place the image on the left and the copyright notice on the right.

### Solution

```css
footer {
  /* ... */
  flex-direction: row-reverse;
}
```

---

8. Center the copyright notice vertically.

### Solution

```css
footer {
  align-items: center;
  /* ... */
}
```

---

You can view the completed CSS file [here](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/flex/final/flex.css).
