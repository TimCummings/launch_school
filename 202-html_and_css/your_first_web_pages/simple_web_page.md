
# Walkthrough Project: A Simple Web Page 8/24/2020

[hello.html](hello.html)

* browser compresses whitespace to a single space character
* you can pre-format text using the `<pre>` tag but this is generally a poor choice
* replace special characters with **character entities**:
  * `&lt;` for `<`
  * `&gt;` for `>`
  * `&amp;` for `&`
  * `&quot;` for `"` (within a double-quoted attribute value)

| Element | Description |
|---------|-------------|
| strong  | The text has greater importance than the surrounding text; most browsers use boldface. Example: You **must** remember to turn the light off. |
| em      | Adds emphasis to the text; most browsers use italics. Example: We do them because they are *hard*! |
| b       | Stylistically offset text, such as keywords. Example: ES6 adds the keywords **const** and **let**. |
| i       | Alternate voice text. Example: I said "Hello." She said "*Goodbye*." |

> Before HTML5, the `b` and `i` elements were non-semantic elements that provided boldface and italic text, respectively. As of HTML5, `b` and `i` are semantic elements, and the meaning has changed. If you intend to use boldface for important text, use `<strong>` instead of `<b>`; if you wish to use italics for emphasis, use `<em>` instead of `<i>`.

## Adding Style

3 ways to apply CSS in page: inline, internal, external
* inline: use the `style` *attribute* on individual tags, e.g. `<strong style="color: blue; text-decoration: underline;">HTML</strong>`
* internal: use the `style` *element* in the `<head>` to keep CSS in one place but still in the same file
* external: separate file

Inline CSS is usually a bad idea: it's tedious and difficult to maintain.
