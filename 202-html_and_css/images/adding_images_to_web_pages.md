
# Adding Images to Web Pages - 9/11/2020

## The Img Element

`<img>` is a self-closing tag that tells the browser to load and display a foreground image from another source. Notable attributes:

* `src` is required; it specifies where to find the image and uses the same URL format as `<a>`'s `href`. The URL can be relative, root-relative, or absolute.
* `alt` is optional but you should almost always use it. It's a textual description of the image for users who can't see it or have images disabled; most browsers will display the `alt` text if an image can't be loaded.
  * screen readers use `alt` to describe images to users with vision problems; images with no `alt` can't be described and may be skipped entirely.
  * Search engines use `alt` to index images.
* `width` and `height` (pixels) are optional and will be overriden by CSS `width` and `height` properties. If these are provided, browsers can reserve appropriate room for an image before it's loaded, but this situation is becoming more rare as image sizes are increasingly responsive based on display sizes. If you know specific image sizes in advance, go ahead and specify HTML `width` and `height`; but if image sizes are dynamic, rely on CSS alone.

Example:

```html
<img src="lucrezia.jpg" alt="Da Vinci's Smarter Sister, Lucrezia"
     width="800" height="600" />
```

## Figure and Figcaption

The `figure` element designates an item as a representation of the information discussed in the included content. It usually encloses some kind of media (video, image, or audio file) that illustrates the surrounding content. It can optionally be captioned with a `figcaption` element:

```html
<figure>
  <img src="masthead.jpg" alt="Sunset over the forest" />
  <figcaption>The sun sets over the dense forest</figcaption>
</figure>
```

## Images as Links

Any non-interactive HTML element can be used as a link (non-interactive excludes form controls and other links.) Example with an image:

```html
<a href="url-of-link">
  <img src="url-of-image" alt="alt-text" />
</a>
```

## Background Images

You can add background images to a page or element via the CSS `background` or `background-image` properties.

```html
<section>
  Sint duis dolor consectetur ad nostrud sint. Occaecat reprehenderit officia ex
  duis velit veniam magna labore.
</section>

<nav>
  <ul>
    <li><a href="#">Home</a></li>
    <li><a href="#">Work</a></li>
    <li><a href="#">Play</a></li>
  </ul>
</nav>
```

```css
html {
  font-size: 32px;
}

body {
  background-image:
    url("http://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/gradient-background.png");
}

section {
  display: inline-block;
  width: 500px;
}

nav {
  background-image:
    url("http://d3jtzah944tvom.cloudfront.net/202/images/lesson_3/blurry.png");
  display: inline-block;
  height: 200px;
  width: 250px;
}
```

There are several other background properties that you can supply with a background image, such as the size of the image, positioning, and repeat count:

```css
body {
  background-size: 25%;
}
```
