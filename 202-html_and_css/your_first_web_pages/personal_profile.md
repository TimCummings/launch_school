
# Guided Project: A Personal Profile

You should now understand how to construct a web page and should be able to build a simple one without much trouble. Let's use that knowledge to create a page with some basic information about somebody special: you. Think of it as a profile page that you might see on a social networking site. It will show your name, title (future front-end developer!), GitHub link, and a list of your five favorite links.

[profile.html](profile.html)

## HTML

1. Start a new HTML file with your HTML skeleton, and change the page title to "My Profile."
2. Add your content to the document's `body`. Use plain text for now; we'll add the HTML below. The content should include your:

* name
* job title
* GitHub link
* list of five web page links identified as `My Top 5 Links`

The content won't be pretty at this point, but that's okay.

3. Convert the name to an `h1` heading.
4. Convert the job title to an `h2` heading.
5. Convert the GitHub profile to a link (an anchor).
6. Use a `strong` element to give the GitHub link a label, `GitHub Profile:`, that has some visual importance.
7. Wrap the label and link for your GitHub profile in a paragraph.
8. Enclose the "My Top 5 Links" title in an `h3` heading.
9. Convert the descriptions for each of your top 5 links to an anchor.
10. Enclose your list of top links (not including the heading) in an ordered list (`ol` element). Feel free to look up ordered lists in the MDN documentation or elsewhere on the Web.
11. Validate your HTML at W3C!

#### Solution

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>My Profile</title>
</head>

<body>
  <h1>Tim Cummings</h1>

  <h2>Web Developer</h2>

  <p>
    <strong>GitHub Profile:</strong>
    <a href="https://github.com/TimCummings">Tim Cummings</a>
  </p>

  <h3>My Top 5 Links</h3>
  <ol>
    <li><a href="https://launchschool.com">Launch School</a></li>
    <li><a href="https://developer.mozilla.org">MDN</a></li>
    <li><a href="https://keeb.io">Keebio</a></li>
    <li><a href="https://system76.com">System76</a></li>
    <li><a href="https://stackoverflow.com">Stack Overflow</a></li>
  </ol>
</body>
</html>
```

#### Adjustments from provided solution:

* We generally use `target="_blank"` in anchors if they link to a different sight. Some devs argue you should not do this and let the user decide. Either option is ok.

## CSS

It's recommended to follow a simple plan when styling pages:

* Start by adding some simple properties, primarily color and font, to the `body` selector to give the page an overall look and feel that focuses on your content.
* Set the position and size of the organizational components of the page: header, footer, sidebars, etc. to match your desired page structure.
* Apply your background and font colors to those parts of the page that need non-default styling.
* By now, your page should look a lot like your final product. Finish by concentrating on each component individually and make any adjustments you need to make to achieve the desired look.

Given this approach, complete the following steps:

1. Set the background color for the page to a dark blue color (`#01304b`).

> **Most** elements use a transparent background color by default, so the background color for the body applies to most page elements. Here, everything uses the same background.

2. The page is now close to unreadable. Set the foreground color (the text color) for the page to a light gray (`#eee`).
3. The links are still hard to read. Change them to a golden color (`#c3b802`).

> The `color` property is inheritable, which means that applying `color` to an element also applies it to every descendant of that element. There are exceptions, though. For instance, your links didn't inherit the text color. This seeming failure occurs since the browser sets separate colors for links, which prevents them from inheriting the primary text color.
>
> CSS inheritance isn't like class inheritance in an OOP language like Ruby, and, for the most part, is beyond the scope of this course. Don't let the vocabulary confuse you, though. Make a note to read about CSS inheritance when you're ready to learn more.

4. Let's try using a sans-serif font for this page. Set the default font for this page to be one of `Arial`, `Helvetica`, or the generic `sans-serif` font.

> Browsers use a serif typeface by default. Serif fonts have flared end-points on most characters; sans-serif do not.
>
> The font you choose is mainly a matter of preference, or rather, the preferences of your designer. Mainstream use today seems to favor serif fonts for headlines and other attention-grabbing items and sans-serif for paragraph-based text.
>
> [This short but helpful guide](http://web.mit.edu/jmorzins/www/fonts.html) includes information on Web-safe fonts and displays examples of each. You don't have to read it right now, but bookmark it for reference.

5. The list items for the top 5 links seem cramped; add 10 pixels of line spacing between elements.

#### Solution

```css
body {
  color: #eee;
  background-color: #01304b;
  font-family: arial, helvetica, sans-serif;
}

a {
  color: #c3b802;
}

li {
  margin-bottom: 10px;
}
```
