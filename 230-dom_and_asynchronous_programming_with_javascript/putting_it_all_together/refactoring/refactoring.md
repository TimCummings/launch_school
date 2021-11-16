
# Assignment: Refactoring - 3/29/2021

As we've already mentioned, although jQuery is a lot less prominent than it used to be, you'll still encounter it in a lot of legacy codebases. It's also not uncommon, however, for legacy code to be refactored in order to remove the jQuery and replace it with vanilla JavaScript and standard browser APIs. In fact, GitHub did exactly this to their entire front-end codebase in 2018. You can read about how they approached the task in [this blog post](https://github.blog/2018-09-06-removing-jquery-from-github-frontend/).

In this assignment, we're going to ask you to do something similar, though on a much smaller scale. You'll start off with some code that uses jQuery, and replace the jQuery methods by using vanilla JavaScript and built in browser APIs.

The main functionality of the program is the ability to dynamically add order lines to an Inventory Order Form using an 'Add Item' button, and to also delete a specific line item using a 'Delete' link on that item.

The current implementation creates each order line by using jQuery to perform a string replacement using some pre-defined HTML located in a `<script>` element with an id of `inventory_item`. This kind of string replacement was a common approach for dynamically creating elements in the days before templating libraries. The major problem with this kind of approach is that it's not very scalable, and can quickly lead to overly complex and difficult to maintain code.

These sorts of problems led to the emergence of templating libraries like Handlebars. As part of this refactoring project, you're going to replace this string replacement approach with a Handlebars template. So while removing one dependency in the form of jQuery, we're going to add a different one in the form of Handlebars.

You can download the code for the current implementation [from this archive](https://d3905n0khyu9wc.cloudfront.net/managing_collections/inventory_order_form_start_code.zip).

## How to Approach this Project

* Work incrementally. Remember that at its core, jQuery is just JavaScript. You can combine jQuery with vanilla JS.
  * In some cases you will be able to update one method at a time, and then test the functionality for that method.
  * In other cases, where there is a dependency between methods, updating one method may break something elsewhere in the code. Here, you may need to refactor more than one method in order to update a particular piece of functionality
* Understand what the program is doing at a high-level
* Understand what the jQuery is doing. This will involve using the jQuery documentation to research a particular method or some jQuery syntax.
* Find the vanilla JS/ browser API equivalent. Remember that jQuery is an abstraction of existing browser functionality.

You might find the following resources useful:

* [Cheat sheet for moving from jQuery to vanilla JavaScript](https://tobiasahlin.com/blog/move-from-jquery-to-vanilla-javascript/)
* [You might not need jQuery](http://youmightnotneedjquery.com/)

### Solution

[refactoring.html](refactoring.html)
[refactoring.js](refactoring.js)

#### Adjustments based on provided solution

It's not necessary to pass the entire item to your Handlebars template; you only need the ID:

```javascript
// replace this:
// let itemElement = this.template(item);
// with this:
let itemElement = this.template({ id: item.id });
```
