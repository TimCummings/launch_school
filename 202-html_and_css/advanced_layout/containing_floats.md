
# Containing Floats - 9/26/2020

When using floats for layout, we may encounter the "containing floats" problem:

```html
<div id="columns">
  <div id="primary">
    <h1>Main Content</h1>
  </div>

  <div id="secondary">
    <h3>Sidebar Content</h3>
  </div>
</div>
```

```css
#columns {
  background-color: #e0e0e0;
  box-sizing: border-box;
  margin: 0 auto;
  padding: 20px;
  width: 780px;
}

#primary, #secondary {
  background-color: yellow;
}

#primary {
  float: left;
  width: 500px;
}

#secondary {
  float: right;
  width: 200px;
}
```

![containing-floats-01.png](containing-floats-01.png)

What happened? Why is our content extending vertically past the containing `div`? Since browsers remove floated elements from the normal flow of the HTML document, the rendering engine no longer cares about them the same way. As a result, our container doesn't actually contain the floated elements any longer, so its height will not be calculated correctly. Floated elements can also end up overwriting other content for this same reason. Absolute and fixed position elements (which we'll explore later) experiences these same issues.

We can resolve this by adjusting the container's `overflow` property or by wrapping it in a **clearfix**.

To clear a floated element, its container's `overflow` property can be set to `hidden` or `auto`:

```css
#columns {
  overflow: hidden;
}
```

![containing-floats-02.png](containing-floats-02.png)

> There are two edge cases to be aware of with `overflow`:
> 
> 1. `overflow: hidden` can clip content that exceeds the allocated space if the container has a set height or width
> 2. `overflow: auto` can add unwanted scrollbars, depending on the browser

Why does `overflow` work? According to W3C documentation, it creates a **block formatting context** which contains everything inside the `overflow` element, including floats.

Instead of `overflow`, you can add a **clearfix** to the container to ensure it doesn't lose its floated children. Clearfix adds an invisible block element with the `clear` property as the last child of the container:

```css
#columns {
  /* overflow: hidden; */
}

#columns::after { /* This rule is the clearfix */
  clear: both;
  content: "";
  display: block;
}
```

We use the `::after` pseudo*element* (not pseudo*class* which we've already seen) to create a child as the final element inside the container. Make sure the final child is a `block` element. `content: ""` sets the final child's content to an empty string so it won't be displayed, but the container will stretch past floated elements to envelope the final child. Make sure the final child also has the `clear` property.

> Possible values for `clear` are `left`, `right`, or `both`. This specifies which floats (left and/or right) the clearfix will clear. Use `both` unless you have a good reason for just `left` or `right`.

Consider the following example to better understand `::before` and `::after` pseudoclasses:

```html
<p>Hello</p>
```

```css
html {
  font-size: 48px;
}

p {
  margin: 0;
  padding: 0;
}

p::before {
  content: "+- ";
  color: red;
}

p::after {
  content: " -+";
  color: blue;
}
```

![before-and-after.png](before-and-after.png)

## Another Use of Overflow

From [floats_practice_problems_1.md](floats_practice_problems_1.md) #3, you can use `overflow: hidden` on the last floated element (instead of its container) to make it take up all remaining space in a row; (you also have to remove its `width` and `float` properties.) This is especially useful for variable width layouts when the last element needs to take all remaining space in a row.

```html
<section>
  <article>
    <p>filler text</p>

    <p>filler text</p>
  </article>
  <aside>
    <p>filler text</p>
  </aside>
</section>
```

```css
body {
  background-color: steelblue;
}

section {
  background-color: thistle;
  margin: 0 auto;
  max-width: 1000px;
}

section::after {
  clear: both;
  content: "";
  display: block;
}

article {
  background-color: teal;
  box-sizing: border-box;
  float: left;
  padding: 1rem;
  width: 500px;
}

aside {
  background-color: wheat;
  box-sizing: border-box;
  float: none;
  overflow: hidden;
  padding: 1rem;
}
```
