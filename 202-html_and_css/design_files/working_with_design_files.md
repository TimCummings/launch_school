
# Working with Design Files - 9/30/2020

## Photoshop

When working on real-world projects, a designer will probably give you a **design file**: a mockup of the finished project pages. This file is almost always a Photoshop document, a PSD file, which is a multi-layered image that contains layers for each part of the design: images, shapes, text, etc. You're expected to use the design file to create your image and background assets as well as obtain information regarding padding, margins, font-size, and color.

We'll go into this some, but not at depth: 1) we're training engineers here, not front-end developers; 2) Adobe reuduced the Photoshop free trial from 30 days to 7 days, which is not enough time to learn what you need.

If you do have Photoshop, you need to know how to:

* Use the layers palette to view the different layers in an image. You can turn layers on and off using the eyeball icon.
* Use the toolbar (the thin vertical or horizontal palette) that provides access to most of Photoshop's tools.
* Extract assets from their layers.
* Use the Move tool to move layers around.
* Use the Marquee tool to extract and measure images and shapes.
* Export images.
* Use the Text tool to determine font characteristics.
* Use the Eyedropper tool to measure colors.

> There are some alternatives to Photoshop but we've not tested them extensively yet. You're welcome to try them but you may run into limited capabalities:
> * [Photopea](https://www.photopea.com/)
> * [Affinity Photo](https://affinity.serif.com/en-us/photo/)
> * [Photoshop Elements](https://www.adobe.com/)
> * [GIMP](https://www.gimp.org/)
> * [Adobe Creative Assets](https://assets.adobe.com/)

## PNG Design Files

In the absence of Photoshop, we'll provide a design file that's been collapsed down to a PNG. They're not ideal, but they work well enough for Launch School projects. Some problems:

* There is no way to examine and measure fonts.
* It is hard to measure colors when the color patch is less than 5-10 pixels thick, such as line drawings and text.
* Extracting images is tedious. If it has curved, jagged, or fuzzy edges, obtaining a clean result may be almost impossible. We'll avoid this by providing you with the images that you need.

To use PNG design files, you'll need tools that:

* open and view PNG files at the intended screen size
* measure sizes, padding, and margins
* measure colors

### Blink Comparisons

1. Create an HTML file that does nothing more than load the PNG design file:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Design File</title>
    <style>
      body, img {
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>
    <img src="design-file.png" alt="design file" />
  </body>
</html>
```

2. Load the HTML in your browser.
3. Set the width and height of your browser as precisely as possible to match the width and height of the PNG file.
4. Create your HTML file and load it in a separate tab.
5. Toggle your browser tabs back and forth between the files (Ctrl-Tab and Shift-Ctrl-Tab work with most browsers).
6. Observe the differences between the design file and your file. Make corrections in your file.
7. Return to step 5 until your files match as well as possible. 

## HTML Design Files

Sometimes we'll ask you to duplicate an existing web page. In these cases, viewing the page source and inspector is cheating and you won't learn much (you may even get more confused.) Instead, rely on blink comparisons.

## Pixel Perfection

Strive for "pixel perfection", but be aware that it won't always be possible. There will frequently be tiny discrepancies in spacing, sizing, and font variations (especially with [kerning](https://en.wikipedia.org/wiki/Kerning).)
