
# Responsive Design - 9/30/2020

Websites should look good and provide identical functionality across a wide variety of devices and screen sizes, from a small smart phone to a huge display. But one look won't suffice; accomplishing this requires writing CSS that changes with different devices. This is the role of **media queries**.

## Media Queries

**Media queries** define styles that change based on the current size of the browser window. This lets us customize the look of a site for phones, tablets, small laptops, and large desktop displays. Here's a simple example that changes the color of links on small devices (smart phones typically have screens less than 480px wide.)

```css
a {
  color: #f00;
}

@media (max-width: 480px) {
  a {
    color: #06c;
  }
}
```

Any styles inside the media query block will apply when the screen width is 480px or less.

You can also use the words `not` and `and` in media queries, as well as selecting different media types such as `screen`, `print`, or `speech`. The most common combination is `screen` and `min-width` or `max-width`:

```css
@media screen and (max-width: 1600px) {
  /* CSS for 1600px (or smaller) screens (no printers!) */
}
```

Check out the [documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries) to get familiar with the full capabilities.

## Mobile-First and Desktop-First

A key decision when developing a website is whether to consider mobile devices or desktops as the primary device: the device your CSS expects when no media queries are active. Mobile-first is generally considered best practice, and it results in faster downloads on mobile devices.

Development starts in a section with no media queries to provide the CSS needed for the smallest device you intend to support. Any CSS common to all device sizes will also be included here, e.g. colors. Then you add more sections via media queries to handle progressively larger devices.

```css
/* CSS for all cell phones and shared cross-browser CSS */

@media screen and (min-width: 481px) {
  /* CSS for tablets and larger */
}

@media screen and (min-width: 961px) {
  /* CSS for small desktop and laptop screens and larger */
}

@media screen and (min-width: 1501px) {
  /* CSS for large laptop and desktop displays */
}

@media print {
  /* CSS for printers */
}
```

### Using Your Page on Multiple Devices

If your site is responsive or a deidcated mobile site, include the following `meta` tag to tell mobile devices how to handle the page. Otherwise, they'll display a miniaturized version of your primary page instead of using the appropriate media queries.

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

If your site is **not** responsive or dedicated mobile, [**don't** include this meta tag](http://blog.javierusobiaga.com/stop-using-the-viewport-tag-until-you-know-ho)! Search "meta viewport" on MDN for more info.

## Fluid and Liquid Layouts

Fluid, liquid, responsive, elastic, hybrid - what are these and which should you use? In actuality, the differences are minor and you'll often hear people use one term and mean another. Let's take a look so we can be familiar with which techniques achieve a given layout type.

### Shared Basis

```html
<main>
  <article class="content">
    Enim Lorem aliqua anim nulla labore nulla ullamco. Deserunt fugiat duis ex
    dolor. Ex laboris ad officia minim quis.  Incididunt eu reprehenderit
    ullamco eiusmod dolor pariatur mollit qui. Officia aliqua velit deserunt
    adipisicing duis minim minim tempor.
  </article>

  <aside class="sidebar">
    Proident cillum ad cillum minim magna. Duis nulla est est non sunt. Est
    culpa laborum velit dolor.
  </aside>
</main>
```

```css
html {
  font-size: 16px;
}

body, article, p {
  margin: 0;
  padding: 0;
}

body {
  margin: 0;
  padding: 0.5rem;
}

main {
  clear: both;
  overflow: hidden;
  padding-bottom: 1.5rem;
}

.content,
.sidebar {
  box-sizing: border-box;
  float: left;
  padding: 20px 30px;
}

.content {
  background-color: pink;
  width: 70%;
}

.sidebar {
  background-color: cyan;
  width: 30%;
}
```

No matter how we change the browser's width, both columns maintain their width ratios. This synchronized behavior is the foundation of both liquid and fluid layouts.

Liquid layouts usually employ percentage widths to maintain content area width ratios as display size changes.

### Liquid Layouts

If we want to resize the `article` (e.g. 60%), we have to resize the `aside` (40%.) Alternatively, we can use what we learned with overflow on the sidebar:

```css
.content,
.sidebar {
  /* delete: float: left; */
}

.content {
  float: left;
  width: 60%; /* was 70% */
}

.sidebar {
  overflow: hidden;
  /* delete: width: 30%; */
}
```

You can now change the width of the content without having to also adjust the sidebar. The layout is liquid since it expands and contracts with the browser's width.

> Remember, we can set `overflow` on the sidebar to either `hidden` or `auto` to achieve the same effect. However, there are some differences between these two values.
>
> * With `hidden`, the browser crops any content that doesn't fit inside the sidebar's container.
> * With `auto`, the browser doesn't crop content, but it may show unwanted scrollbars on the sidebar.

### Fluid Layouts

Liquid layouts take up the entire width of the browser window, regardless of how big it gets. If you want to restrict this growth or shrinkage, use a fluid layout. Define limits beyond which an element will stop expanding or contracting even if the browser continues to change in the same direction. Fluid layouts expand and contract, like liquid layouts, but only t oa point, after which they will remain fixed.

```css
main {
  max-width: 1000px;
  min-width: 500px;
}

.content,
.sidebar {
  padding: 20px 30px;
}

.content {
  box-sizing: border-box;
  float: left;
  width: 70%;
}

.sidebar {
  overflow: hidden;
}
```
