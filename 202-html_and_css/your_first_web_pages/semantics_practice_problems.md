
# Practice Problems: Semantics - 8/24/2020

This set of practice problems covers the basics of semantic HTML: using HTML to show the structure and purposes of the document, not its presentation.

> While working on these problems and dealing with semantics in HTML, you may want to open this [excellent flowchart](http://html5doctor.com/downloads/h5d-sectioning-flowchart.pdf) to help decide what tags should be used in which situations. We recommend keeping this flowchart handy.

1. Which of these tags are semantic, and which are not?

|             |            |            |             |
|-------------|------------|------------|-------------|
| `<article>` | `<aside>`  | `<b>`      | `<div>`     |
| `<footer>`  | `<h3>`     | `<header>` | `<section>` |
| `<span>`    | `<strong>` |            |             |

#### Solution

| Semantic    | Not       |
|-------------|-----------|
| `<article>` | `<b>`     |
| `<aside>`   | `<div>`   |
| `<footer>`  | `<span>`  |
| `<h3>`      | `<strong>`|
| `<header>`  |           |
| `<section>` |           |

#### Adjustments based on provided solution

In HTML5, all content tags except `<div>` and `<span>` have semantic meaning. http://html5doctor.com/i-b-em-strong-element/

---

2. Given the following HTML, would `<section>`, `<aside>`, `<article>`, or `<div>` be the most appropriate element for the tag shown as `<sometag>`?

```html
<sometag>
  <h1>Lincoln's Gettysburg Address</h1>
  <p>
    Four score and seven years ago our fathers brought forth on this
    continent, a new nation, conceived in Liberty, and dedicated to the
    proposition that all men are created equal.
  </p>
  <p>
    Now we are engaged in a great civil war, testing whether that nation,
    or any nation so conceived and so dedicated, can long endure. We are
    met on a great battle-field of that war. We have come to dedicate a
    portion of that field, as a final resting place for those who here gave
    their lives that that nation might live. It is altogether fitting and
    proper that we should do this.
  </p>
  <p>
    But, in a larger sense, we can not dedicate—we can not consecrate—we
    can not hallow—this ground. The brave men, living and dead, who
    struggled here, have consecrated it, far above our poor power to add or
    detract. The world will little note, nor long remember what we say
    here, but it can never forget what they did here. It is for us the
    living, rather, to be dedicated here to the unfinished work which they
    who fought here have thus far so nobly advanced. It is rather for us
    to be here dedicated to the great task remaining before us—that from
    these honored dead we take increased devotion to that cause for which
    they gave the last full measure of devotion—that we here highly
    resolve that these dead shall not have died in vain—that this nation,
    under God, shall have a new birth of freedom—and that government of
    the people, by the people, for the people, shall not perish from the
    earth.
  </p>
</sometag>
```

#### Solution

`<article>` is the most appropriate tag here. `<div>` has no semantic meaning; there's no other content for this to be either a `<section>` or an `<aside>`. It's a chunk of content that makes sense on its own.

---

3. Given the HTML from question 2, would it be appropriate to replace `<sometag>` with `<address>` or `<blockquote>`? If so, which one?

It could make sense to use `<blockquote>` since this is a famous speech. It would not be appropriate to use `<address>` - that is meant for physical locations: street addresses.

---

4. Given the following HTML, would `<section>`, `<aside>`, `<article>`, or `<div`> be the most appropriate element for the tag shown as `<sometag>`?

```html
<sometag>
  <h3>Text-align Property</h3>
  <p>
    Given the width of the paragraph, the heading looks odd hanging out on
    the left side of the screen. Let's center it instead; we'll do this
    with the text-align property:
  <p>

  <pre>
    <h1 style="color: orange; text-align: center;">Hello, Internet!</h1>
  </pre>
</sometag>
```

#### Solution

`<article>` is most appropriate here. There is no other content for this to be a `<section>` or `<aside>`.


#### Adjustments based on provided solution

Even though other content is not visible in the example, it's clear that this is a part of a larger text, thus `<section>` is most appropriate.

---

5. Given the following HTML, would `<aside>`, `<section>`, `<blockquote>`, or `<div>` be the most appropriate element for the tag shown as `<sometag>`?

```html
<h3>Hex Colors</h3>

<p>
  Most graphics and design applications like Photoshop and Pixelmator
  display colors in hexadecimal format, so it's easy to copy and paste
  color values you need from one program into your editor as a CSS
  property.
</p>

<sometag>
  <p>
    If you're unfamiliar with the hexadecimal numbering system, it uses 16
    different digits instead of the ten the decimal system uses. The hex
    digits are 0 through 9, as in the decimal system, but also include a
    through f (or A through F) as valid digits.
  </p>
```

#### Solution

`<aside>` is most appropriate here. This is a section of the text that is loosely related to the main text, but not necessary for its understanding.
