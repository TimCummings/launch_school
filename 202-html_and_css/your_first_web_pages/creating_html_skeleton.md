
# Creating an HTML Skeleton - 8/24/2020

Make a snippet out of the basic HTML structure:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>your page title goes here</title>
    <meta charset="utf-8" />
  </head>
  <body>
  </body>
</html>
```

I found multiple snippet plugins for vim, but they all seemed like overkill with inconsistent support. Since my snippet needs are extremely basic for now, I'm going to use a leader command to read `skeleton.html`.

## HTML Document Structure

### Document Type Definition (DTD) / DOCTYPE

`DOCTYPE` isn't an official part of HTML; it's just a message telling the browser which specific markup language to expect. It *MUST* be the first line of an HTML document, even before any whitespace.

* For HTML5, `DOCTYPE` can be lowercase or uppercase.
* For HTML versions prior to 5 or for non-HTML languages like XML, `DOCTYPE` must be uppercase.
* HTML5 does not technically have a DTD (it's not in the standards documentation) like 3 and 4 do. But the term `DTD` is still used interchangeably with `DOCTYPE`.

### HTML

The <HTML> element encloses the entire HTML document. All content and metadata must be within this element.

### Head

Provides additional meta-information to the browser. The browser does not display this in the page content area.

### Body

The content area of the page.
