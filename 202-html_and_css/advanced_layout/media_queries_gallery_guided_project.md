
# Guided Project: Photo Gallery with Media Queries - 9/30/2020

In this project, you will add some media queries to the photo gallery project from the previous assignment to adjust the design for both smaller and larger screens. In the original project, we used a fluid layout with a minimum width of 500 pixels and a maximum width of 1000. In this project, we'll do away with the minimum width; instead, we'll reduce the number of thumbnails shown at the bottom as the screen width shrinks.

The final project displays four thumbnails per line when the window is at least 900 pixels wide. It displays three per line when the window is between 600 and 899 pixels, and two per line when the window is narrower than 600 pixels. As a challenge, we'll add an extra layout that kicks in when the window width is 1280px or more.

You can start this project with the [completed example from the previous project](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/photo_gallery_with_fluid_layout/example.html), or your own completed version.

[Project files](media_queries_gallery/)

1. Add a meta tag that tells the browser that this page is a responsive design.

### Solution

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

---

2. Remove the minimum width from the project.

### Solution

```css
body {
  align-items: center;
  background-color: #333;
  display: flex;
  flex-direction: column;
  margin: 0 auto;
  max-width: 1000px;
  /* DELETE: min-width: 500px; */
  padding: 1rem 0;
}
```

---

3. Add several additional thumbnail images to the HTML to help make your changes stand out as the number of thumbnails per line shrinks. Add some margin between each row of thumbnails.

### Solution

```html
<ul class="thumbnails">
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 1" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 2" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 3" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 4" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 5" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 6" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 7" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 8" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 9" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 10" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 11" /></li>
  <li><img class="thumbnail" src="1200x900.png" alt="sub placeholder 12" /></li>
</ul>
```

```css
ul.thumbnails {
  /* ... */
  flex-wrap: wrap;
  /* ... */
}

li {
  margin-bottom: 1rem;
}
```

---

4. Add a media query with the CSS you need to limit the number of thumbnails per line to three when the window width is less than 900px.

### Solution

```css
@media screen and (max-width: 899px) {
  ul.thumbnails li {
    width: 30%;
  }
}
```

---

5. Add a media query with the CSS you need to limit the number of thumbnails per line to two when the window width is less than 600px.

### Solution

```css
@media screen and (max-width: 599px) {
  ul.thumbnails li {
    width: 48%;
  }
}
```

---

6. **Challenge** Add a media query and the necessary CSS to move the thumbnails to the right side of the primary photo when the browser's width is 1280 pixels or more. Arrange the thumbnails as a single column. Allow the thumbnails to continue expanding as you increase the window width, but limit the central photo to 950px. If your display can't handle 1280 pixels, choose a smaller value, and make any necessary adjustments. See the [completed project](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_6/photo_gallery_with_fluid_layout/example2.html) for the expected appearance.

> Hint: When the browser window is at least 1280 pixels wide, expand the `main` element to allow it to fill the window's entire width.

### Solution

```html
<main>
  <figure>
    <!-- ... -->
  </ul>
</main>
```

```css
@media screen and (min-width: 1280px) {
  body {
    max-width: none;
  }

  figure img {
    width: 950px;
  }

  main {
    display: flex;
  }

  ul.thumbnails {
    align-items: stretch;
    flex-direction: column;
    flex-wrap: nowrap;
  }

  ul.thumbnails li {
    width: auto;
  }
}
```
