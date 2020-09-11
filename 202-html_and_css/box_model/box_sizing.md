
# Box Sizing - 9/5/2020

reference article: https://css-tricks.com/box-sizing/

The default value for the `box-sizing` property is `content-box`, in which an element's total width and height is calculated by **adding** `padding` and `border` to `width` and `height`.

A usually-preferable alternative is `border-box`, in which the content area, `padding`, and `border` will all be contained within the specified `width` and `height`. This approach gained traction with the rise of responsive layouts necessitated by the expansive increase in screen size variety.

E.g. consider an element with `width: 50%;`, `padding: 10px;`, and `border: 1px;`.
* With default (`box-sizing: content-box;`), this element will be 50% of parent container's width + 10px left padding + 10px right padding + 1px left border + 1px right border = 50% + 22px. Two such elements would occupy two rows instead of one.
* With `box-sizing: border-box;`, this element will still be 50%; its content-area will be reduced sufficiently to make room for its padding and border while not exceeding 50% width. Two such elements would occupy a single row.

The `box-sizing` property used to also have a `padding-box` value, but it has been deprecated. **Don't use it.**

To use `border-box` everywhere, use the following CSS:

```css
html {
  box-sizing: border-box;
}

*, *::before, *::after {
  box-sizing: inherit;
}
```

See: https://css-tricks.com/inheriting-box-sizing-probably-slightly-better-best-practice/
