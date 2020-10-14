
# CSS Resets - 9/30/2020

As we've seen, browsers apply their own default stylings, but these vary (sometimes significantly) between browsers. While browser default styles are great for making un-styled content somewhat palatable, they frequently interfere with styled content. Worse yet, different browsers tend to interfere *differently*, leading to an infuriating game of Whac-A-Mole as you bounce between different browsers, fixing one issue only for others to pop up in another browser. Address these inconsistencies with CSS resets. They don't guarantee you won't experience cross-browser issues, but they help to minimize them.

Some of the most popular CSS resets (with varying degrees of aggressiveness) are:

* [Eric Meyer's reset](http://meyerweb.com/eric/tools/css/reset/)
* [Normalize.css](http://necolas.github.io/normalize.css/)
* [Tantek Celik's whitespace reset](http://cssreset.com/scripts/undohtml-css-tantek-celik/)

It's common for developers to customize their reset over time. Launch School uses a custom, simplified version of Tantek Celik's reset:

```css
/*
----------------------------------------
Tantek Celik's Whitespace Reset
     Author:    Tantek Celik, Shane Riley
    Version:    (CC) 2010 Some Rights Reserved - http://creativecommons.org/licenses/by/2.0
Description:  Resets default styling of browsers to a common base
----------------------------------------
*/

ul, ol { list-style: none; }
h1, h2, h3, h4, h5, h6, pre, code { font-size: 1em; }
ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, body, html, p, blockquote,
fieldset, input, dl, dt, dd, figure, figcaption {
  margin: 0;
  padding: 0;
}
a img, :link img, :visited img, fieldset { border: none; }
address { font-style: normal; }
header, section, article, nav, footer, hgroup, details, summary, figure, main {
  display: block;
}
mark {
  color: inherit;
  background-color: transparent;
}
abbr { border: none; }
summary::-webkit-details-marker { display: none; }
```
