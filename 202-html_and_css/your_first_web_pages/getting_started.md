
# Getting Started - 8/19/2020

## Learn to Code: HTML & CSS by Shay Howe

### [Building Your First Web Page](https://learn.shayhowe.com/html-css/building-your-first-web-page/)

* HTML: HyperText Markup Language - gives content structure and meaning
* CSS: Cascading Style Sheets - style the appearance of content
* tag
  * begins with `<`
  * ends with `>`
  * contains an element name inside the angle brackets
  * 3 types:
    * opening tag, e.g. `<p>`
    * closing tag, e.g. `</p>`
    * self-closing tag, e.g. `<br />` (most tags are **not** self-closing)
* element: designator that defines the structure and content of objects within a page
  * includes either:
    * a self-closing tag, OR
    * an opening tag and its corresponding closing tag, including everything
      between the two (may contain nested elements)

**NB**: the language around tags and elements is often imprecise; be aware of
that and be precise yourself. E.g. we may say the `p` tag (meaning `<p>`) or the
`p` element (meaning `<p>...</p>`.) Know the difference and use the correct term
yourself.

* attributes: properties used to provide additional information about an element
  * common attributes: `id`, `class`, `src`, `href`
  * defined in an opening tag after the element name and before the `>`
  * generally have a name, equals sign, then a quoted value, e.g. `<p id="intro">`

* Structure
  * type declaration: `<!DOCTYPE html>` (latest version if no number specified)
  * `<html>` signifies the beginning of the document
  * `<head>` signifies the top of the document
    * contains metadata
    * is not displayed on the web page
  * `<body>` contains visible content

* CSS
  * selectors: use qualifiers of varying specificity to target HTML elements to apply styles
    * kinds of selectors (from least specific to most):
      * type, e.g. `div { }`
      * class - prefixed with `.`, e.g. `.card`
      * id - prefixed with `#`, e.g. `#5`
      * plus [many more](https://learn.shayhowe.com/advanced-html-css/complex-selectors/)
    * a selector is followed by curly braces `{`, `}`
    * braces contain one or more property/value pairs

* block vs inline elements
  * blocks begin on a new line; inline do not
  * blocks occupy all available width; inline occupy only the width of their content
  * black can wrap inline; inline cannot wrap block
  * both can be nested within themselves

* structurally based elements
  * header
  * nav
  * article
  * section
  * aside
  * footer

* CSS Specificity
  * cascade: generally, styles declared later/lower in the stylesheet take precedence (the styles *cascade* down the sheet); however, different selectors have different weights and a more heavily weighted selector will take precedence regardless of order
  * weights
    * type: 0-0-1
    * class: 0-1-0
    * id: 1-0-0
  * weights of combined selectors are added, e.g.
    * `.hotdog p` = class + type = 0-1-0 + 0-0-1 = 0-1-1
    * `.hotdog p.mustard` = class + type + class = 0-1-0 + 0-0-1 + 0-1-0 = 0-2-1
    * therefore, `.hotdog p.mustard` would take precedence over `hotdog p` regardless of the cascade
  * best practice: generally keep an eye on your specificity weights; the higher they get, the more likely your cascade is to break
    * with this in mind, the recommended way to layer styles is with multiple modular classes, e.g.
```css
.btn { font-size: 16px; }
btn-danger { background: red; }
btn-success { background: green; }
```

* combining CSS selectors
  * read combined selectors from right to left
  * the rightmost selector (immediately before the `{`) is the **key selector**
    * the key selector identifies exactly to which element the styles will be applied
    * any selectors to the left of the key selector are prequalifiers
  * a space between selectors establishes a parent-child relationship,
    * e.g. `.hotdog p` targets (from right to left): paragraph elements residing *within* an element of class `hotdog`
    * or, put another way, `.hotdog p` targets paragraph elements that are children of elements of class `hotdog`
  * multiple selectors without a space are... unioned? ANDed?
    * e.g. `p.mustard` targets paragraph elements with a class of `mustard`
    * it is a best practice NOT to prefix class selectors with type selectors

* Length
  * pixel: 1/96th of an inch (although this isn't necessarily the case any longer as high and low density displays have become common)
  * Em: related to font size (1em = the unit's font-size), e.g.
    * for an element with `font-size: 14px`, `1em` = `14px`; `5em` = `14px * 5` = `70px`
    * when a font size is not explicitly stated, em will be relative to the font size of the closest parent element with an explicit font size
