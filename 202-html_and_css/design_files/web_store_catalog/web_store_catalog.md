
# On Your Own: Web Store Catalog - 10/3/2020

In this project, you will build a simple web store page from scratch, using `web_store.jpg` and `product_clicked.jpg` from [this downloadable archive](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/web_store_catalog.zip). The download also includes an `images` directory that contains the images that you need for the page.

> We would typically use psd or png files for design work, but our designer lost them. All he has are these low-quality images. Using them as design files is identical to using pngs, but a bit harder since jpgs have a fuzzy appearance in the details and faded colors. Your boss asks you to do your best.

[Here's the completed project](https://d3jtzah944tvom.cloudfront.net/202/projects/lesson_7/web_store_catalog_final/index.html).

As with the previous project, your goal is to replicate the design as close as possible. Be sure to use semantic markup wherever possible. When you click anywhere on a product, you should display a larger version of the product image horizontally centered on the page. You should also dim the rest of the page, and let the user click anywhere on the page to restore the original display.

> Hint 1: Use floats to list the products four to a row. Make sure you clear the floats to prevent the parent container from collapsing.

> Hint 2: Use the nth-of-type pseudo-class to set the left margin for the first product in each row to zero.

> Hint 3: If you place a checkbox control inside a `<label>` tag, you can click anywhere inside the area enclosed by the `<label>` to toggle its state. Even if you hide the checkbox with CSS, you can still toggle it by clicking.
> 
> Use this technique to add a hidden checkbox to the HTML for each product on the page; when you click the product, you toggle the state of the corresponding checkbox. You can then use the `:checked` pseudo-class and adjacent sibling selectors to display and hide the enlarged image.
> 
> > This technique involves putting block elements inside each `<label>` tag, which is a violation of the standards. Thus, W3C validation will issue error messages like **Element “figure” not allowed as child of element “label” in this context.** You may ignore these for this project.
> >
> > An [alternative approach to the checkbox trick](http://www.outofscope.com/css-only-menu-toggle-no-javascript-required/) uses the `label` element's `for` property and avoids the associated validation errors. The trade-off is that the user loses the ability to click anywhere to close the enlarged image; she must click something within the image, such as an `x` button/link.

> Hint 4: Use absolute positioning to position the enlarged image on the screen.

> Hint 5: To dim the rest of the page when displaying enlarged images, you will need a statically positioned pseudo-element that stretches to all four window edges. You should be able to click on the pseudo-element (that is, anywhere on the page) to restore the original page.
