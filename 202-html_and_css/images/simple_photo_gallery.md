
# A Simple Photo Gallery - 9/12/2020

With what you've learned so far, you should now be able to construct a simple photo gallery. We'll get you started by creating a simple gallery of 5 images of varying sizes. We'll display the images one per line, with each image left-justified, and with a caption beneath each.

For this project, you can use any images you want. For the best results, try to choose a variety of different image widths, including at least one that is too big to fit horizontally in your usual browser window.

If you want, you can use these images instead:

* https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/1.jpg
* https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/2.jpg
* https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/3.jpg
* https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/4.jpg
* https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/5.jpg

Here's the body of our HTML:

```html
<main>
  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/1.jpg"
         alt="Transit Shadows" />
    <figcaption>Transit Shadows</figcaption>
  </figure>

  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/2.jpg"
         alt="Missy Chaplin" />
    <figcaption>Missy Chaplin</figcaption>
  </figure>

  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/3.jpg"
         alt="Thunderbirds in Formation" />
    <figcaption>Thunderbirds in Formation</figcaption>
  </figure>

  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/4.jpg"
         alt="Orange Rose" />
    <figcaption>Orange Rose</figcaption>
  </figure>

  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/5.jpg"
         alt="Kentucky Darleks" />
    <figcaption>Kentucky Darleks</figcaption>
  </figure>
</main>
```

We'll zero out the margins and padding for all these elements to ensure that the appearance remains similar in different browsers:

```css
body, main, figure, figcaption, img {
  margin: 0;
  padding: 0;
}
```

We call this type of margin/padding zeroing a reset; we'll discuss it in more detail later. For now, all you need to know is that it provides some assurance that different browsers won't display different results.

We're using the `main` element as a master "container" element for the entire photo gallery. It provides some semantic meaning for the document as it identifies the primary content area.

Now, let's walk through some additional styling to finish the gallery. Our goal is to end up with the five pictures arranged in a 3 row by 2 column grid, with the final grid element empty. All images should have the same width and should fit horizontally within the browser window. We'll let you do most of the work.

HTML file: [simple_photo_gallery.html](simple_photo_gallery.html)

1. After loading the page, you may notice that the images are vertically too near each other, and they're flush with the top and left edges of the window. Adjust the spacing between the `figure` elements and the distance between the left and right edges of the browser window to `50px` to give the images some breathing room.

### Solution

```css
figure {
  margin: 50px;
}
```

#### Adjustments based on provided solution

> We used the `outline` property to temporarily draw rectangles around each figure to help you see how the elements line up. Outlines are like borders, but they lie outside them. More importantly, they don't interact with the box model, so they don't change the page layout. This feature makes them useful during development and debugging.

---

2. Reduce your browser window's width, if necessary, until at least one image exceeds the window width. Next, adjust the CSS to make them all fit inside the window. Don't forget that there is a margin around each figure, which should be evident when you display the page.

Once you're done, check what happens as you expand and shrink the browser window; no matter what adjustments you make, all images should fit in the window.

### Solution

```css
img {
  width: 100%;
}
```

#### Adjustments based on provided solution

Adjust `max-width`, not `width`:

```css
img {
  max-width: 100%;
}
```

---

3. Every image should use the entire width of the `figure` elements. Modify your CSS to implement this requirement.

### Solution

```css
img {
  width: 100%;
}
```

---

4. Reduce the width of each `figure` to 1/2 the width of the browser window.

### Solution

```css
figure {
  margin: 50px;
  outline: 1px solid red;
  width: 50%;
}
```

---

5. At this point, the figures are narrow enough that we should be able to squeeze 2 of them in every row on the page. However, since `figure`'s are `block` elements, they always take up an entire row. Instead, you must convert the `figure` elements to `inline-block`. Please do so.

### Solution

```css
figure {
  display: inline-block;
  margin: 50px;
  outline: 1px solid red;
  width: 50%;
}
```

---

6. There's a small cosmetic issue unrelated to squeezing two images per row. Let's center the captions beneath each image.

### Solution

```css
figcaption {
  text-align: center;
}
```

---

7. Returning to the problem of squeezing two images per row, the main issue we have is that we have margins to the left and right of each `figure`. Recall that we used margins here to satisfy our rule of thumb about choosing margins or padding. However, those margins take up space in the browser window, so we can't squeeze two 50%-width elements side-by-side. Instead, we need to set the left and right margins on the `figure` elements to `0`, and redistribute that space in some other way. Give this a try now.

### Solution

```css
figure {
  display: inline-block;
  padding: 50px;
  outline: 1px solid red;
  width: 50%;
}
```

#### Adjustments based on provided solution

Use padding horizontally but margin vertically; this requires us to change `box-sizing` to `border-box`:

```css
figure {
  box-sizing: border-box;
  display: inline-block;
  margin: 50px 0;
  padding: 0 50px;
  outline: 1px solid red;
  width: 50%;
}
```

---

8. The other part of the problem of squeezing two images per row is that there is a small amount of whitespace between every pair of `inline-block` elements. It's not much whitespace, but it's enough to prevent two 50% elements from fitting side-by-side. Go ahead and make the necessary adjustments to get rid of the whitespace.

### Solution

Add comments between `figure`s:

```html
<main>
  <figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/1.jpg"
         alt="Transit Shadows" />
    <figcaption>Transit Shadows</figcaption>
  </figure><!--

  --><figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/2.jpg"
         alt="Missy Chaplin" />
    <figcaption>Missy Chaplin</figcaption>
  </figure><!--

  --><figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/3.jpg"
         alt="Thunderbirds in Formation" />
    <figcaption>Thunderbirds in Formation</figcaption>
  </figure><!--

  --><figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/4.jpg"
         alt="Orange Rose" />
    <figcaption>Orange Rose</figcaption>
  </figure><!--

  --><figure>
    <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/5.jpg"
         alt="Kentucky Darleks" />
    <figcaption>Kentucky Darleks</figcaption>
  </figure>
</main>
```

---

9. The images are a bit on the small side. Let's give the user the ability to see them full-sized by clicking on them. When clicked, the browser should load the image directly into a new tab or window. To accomplish this, convert your images into links.

### Solution

```html
<main>
  <figure>
    <a href="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/1.jpg"
       target="_blank">
      <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/1.jpg"
           alt="Transit Shadows" />
    </a>
    <figcaption>Transit Shadows</figcaption>
  </figure><!--

  --><figure>
    <a href="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/2.jpg"
       target="_blank">
      <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/2.jpg"
           alt="Missy Chaplin" />
    </a>
    <figcaption>Missy Chaplin</figcaption>
  </figure><!--

  --><figure>
    <a href="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/3.jpg"
       target="_blank">
      <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/3.jpg"
           alt="Thunderbirds in Formation" />
    </a>
    <figcaption>Thunderbirds in Formation</figcaption>
  </figure><!--

  --><figure>
    <a href="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/4.jpg"
       target="_blank">
      <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/4.jpg"
           alt="Orange Rose" />
    </a>
    <figcaption>Orange Rose</figcaption>
  </figure><!--

  --><figure>
    <a href="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/5.jpg"
       target="_blank">
      <img src="https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/photo-gallery/5.jpg"
           alt="Kentucky Darleks" />
    </a>
    <figcaption>Kentucky Darleks</figcaption>
  </figure>
</main>
```

---

10. You can now get rid of the outline you attached to the `figure` elements, and assign a pleasant background to the gallery. You can use the background image we used earlier in this lesson (`https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/gradient-background.png`) or one of your own.

### Solution

```css
body {
  background-image: url(https://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/gradient-background.png);
}
```

#### Adjustments based on provided solution

`background-size: cover;` makes the image remain consistent (relative to the page content) regardless of the size of the browser window.
