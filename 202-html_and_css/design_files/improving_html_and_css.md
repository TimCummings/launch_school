
# Improving Your HTML and CSS - 10/2/2020

Determining the best HTML and CSS to use for a given scenario is hard because there is never just one right answer - almost every can be achieved multiple ways. It's usually best to try and keep your CSS as concise as possible.

In this video, we will review a typical web page and identify several areas where we can improve it. In the end, we should have a web page that is more semantic and easier to extend.

[Link to jsbin](http://jsbin.com/muvonubube/1/edit?html,css,output)

## Notes

* Use semantic elements where possible; pay special attention to the over-use of classes or IDs with generic elements instead of simply using semantic elements to begin with.
* Consider using the `role` attribute:

> Why use the role attribute?
>
> As a CSS selector, the role attribute loosens the coupling between your CSS and HTML. When you use something like `#header` or `body > header`, you have a case of tight coupling between your HTML and code; if you change the HTML, you probably need to change the CSS, and vice versa. When you use roles, you can use it to select any HTML node type. That means you can change the HTML or the CSS without changing the other, provided you don't change the role.
>
> Here is a [useful Stack Overflow post](https://stackoverflow.com/questions/10403138/what-is-the-purpose-of-the-role-attribute-in-html/18664038#18664038) that talks about the purpose of the `role` attribute.
