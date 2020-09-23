
# Practice Problems: Images and Figures - 9/12/2020

These practice problems use [this image](https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg) which you can download to your system or use directly from its current location, `https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg`.

1. Write HTML to display the image. Don't use a `<figure>` or `<figcaption>` right now.

### Solution

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>your page title goes here</title>
</head>

<body>
  <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg"
       alt="a pair of cats" />
</body>
</html>
```

---

2. Use CSS to set the width of the image to 250 pixels.

### Solution

```css
img {
  width: 250px;
}
```

---

3. Update the CSS width from the previous problem with a height of 350 pixels.

### Solution

```css
img {
  height: 350px;
  width: 250px;
}
```

#### Adjustments based on provided solution

Don't just add a `height`, but replace `width` with it:

```css
img {
  height: 350px;
}
```

---

4. Set the width of the image to 400 pixels, but keep the height at 350px.

### Solution

```css
img {
  height: 350px;
  width: 400px;
}
```
---

5. Remove the CSS for the `img` element, and wrap the `<img>` in a `<figure>` tag with a yellow background.

### Solution

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>your page title goes here</title>

  <style>
    figure {
      background-color: yellow;
    }
  </style>
</head>

<body>
  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg"
         alt="a pair of cats" />
  </figure>
</body>
</html>
```

---

6. Add a caption below the image.

### Solution

```html
<figure>
  <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg"
       alt="a pair of cats" />
  <figcaption>A pair of cats.</figcaption>
</figure>
```

---

7. Move the caption above the image.

### Solution

```html
<figure>
  <figcaption>A pair of cats.</figcaption>
  <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/cats.jpg"
       alt="a pair of cats" />
</figure>
```
