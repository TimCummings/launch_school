
# Assignment: Grocery List - 3/25/2021

Let's get some more practice working with the DOM and event listeners. We'll throw in some work with arrays and functions and create a single-page application for creating a grocery list.

When we load the page, we'll be presented with a form that asks us for an item's name and quantity as two text fields. Once the form is completed and submitted, a new item will be added to our grocery list.

Since this project isn't too concerned about the HTML and CSS components, you can use the starter code from [this archive](https://d3905n0khyu9wc.cloudfront.net/grocery_list/grocery_list_20200829.zip). You will need to edit the HTML to load your JavaScript code.

If you prefer, you can write your own HTML and CSS. Feel free to spend time making it look professional or just slap something together. The focus of this project is JavaScript, so everything else is optional.

Here's a breakdown of the HTML and CSS involved.

* Create an HTML file with inputs for the item name, the quantity, and a submit button. You will also need an unordered list for your grocery items; it should be empty to start with.
* Create some basic CSS for the page. If you don't want to create the CSS yourself, you can use the starter code from above.
* **Optional** Create a separate print-only stylesheet that hides the form, leaving just the grocery list.

Your JavaScript code should:

* Add an event handler for the submit event on the form.
* Retrieve the item name and value from the form elements.
* Use a quantity of `1` if the quantity field is left empty.
* Create a new list item object using the name and quantity as strings.
* Add the list item to the grocery list portion of the HTML.
* Clear the form's contents.

You may use jQuery or any other library you want. However, you can easily build this project with vanilla JavaScript and the DOM API. Our version doesn't use any libraries.

Here's what our content looks like. If you're struggling with colors, check out [Adobe Color](https://color.adobe.com/) to browse other color combinations. You can also use our HTML and CSS by downloading the starter code.

If you decide to create the optional print stylesheet, use a `link` element with a `media="print"` attribute to load the appropriate stylesheet.

```html
<link rel="stylesheet" media="print" href="stylesheets/print.css" />
```

To reset the form, you can call `HTMLFormElement.prototype.reset`. You can read about it [here](https://developer.mozilla.org/en-US/docs/Web/API/HTMLFormElement/reset).

### Solution

[groceries.js](groceries.js)
[print.css](print.css)

#### Adjustments based on provided solution

The provided solution manages the list internally in addition to displaying it on the page. While that wasn't necessary to achieve the described functionality, it serves as a solid foundation on which to build more features.
