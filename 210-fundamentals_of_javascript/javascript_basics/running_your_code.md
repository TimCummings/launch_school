
# Running your Code - 10/20/2020

With any JavaScript practice problems in this course or the book, you can run your code if you place it in an HTML file and open it in Chrome. There are two ways to do this.

The first method begins with a nearly empty HTML file: all you need is some basic structure like the `<html>` and `<body>` tags. Just before the closing `</body>` tag, add this code:

```html
<script>
</script>
```

Write your JavaScript directly within this element; your browser will execute the JavaScript when you load (or reload) the page. For example:

```html
<body>
  <script>
    console.log('I run automatically!');
  </script>
</body>
```

> You can view the console logs using the developer tools of browsers. For Chrome, you can open the console using `Ctrl + Shift + j` on Windows and Linux, and `Cmd + Option + j` on Mac.

The second method starts the same way: with a minimal HTML file. This time, though, add the following code instead:

```html
<script src="my_javascript.js"></script>
```

This tells your browser to load some JavaScript from a file named `my_javascript.js` (you can use any name you want).

In both cases, refresh your web page in Chrome to see any changes you make to the JavaScript. Make sure you save any changes first!

> You should avoid combining these two methods. If the `src` attribute of a script tag is specified, there should be no script embedded inside it. When both exist, only the JavaScript from the file referenced by the `src` attribute is loaded.
>
> ```javascript
> console.log("I'm Loaded!");
> ```
> 
> ```html
> <body>
>   <script src="my_javascript.js">
>     console.log("I'm NOT Loaded!");
>   </script>
> </body>
> ```
