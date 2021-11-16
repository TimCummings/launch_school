
# Practice Problems: Using JQuery Selectors - 3/22/2021

To work these practice problems, open [this HTML file](https://d3jtzah944tvom.cloudfront.net/jquery_selectors/index.html) in Google Chrome or your favorite browser, view its source, and then use the console pane of the browser Developer Tools to enter the requested code. Once you have selected the elements, you can add a "highlight" class to them with `.addClass('highlight')` to visually change the page so you can verify your results. Refresh the page to clear the highlights.

If you need to check the class or id of a particular element, you can right click on that element in the browser window and select `Inspect Element` from the menu.

Some of the jQuery methods that you need to use will have been covered in previous assignment. For others, you may need to research the documentation. If you get stuck, feel free to check the hints.

1. Use an element selector to find all `h1` elements.

### Solution

```javascript
$.find('h1');
```

#### Adjustments based on provided solution

My solution works, but `find` is unnecessary: `$('h1');` works.

---

2. Use an ID selector to find the first `h1` element.

### Solution

```javascript
$('#site_title');
```

---

3. Use a descendant selector to find all the list items in the `article` element.

### Solution

```javascript
$('article').find('li');
```

#### Adjustments based on provided solution

While my solution works, I'm still over-complicating this. There's no need to chain a method; this works: `$('article li');`.

---

4. Find the third list item from the `article` element.

> Hint: Check the documentation for the `eq()` method.

### Solution

```javascript
$('article li').eq(2);
```

---

5. Find the table element, then find all the odd-numbered table rows in that element.

> Hint:
> * Check the documentation for the `filter()` method.
> * The jQuery `:odd` selector is `0` based.

### Solution

```javascript
$('table tr').filter(':odd');
```

#### Adjustments based on provided solution

This time I got it backwards - this problem *is* asking to chain methods. My solution works, but the problem is asking for something like this: `$('table').find('tr:odd');`.

---

6. Find the list item that contains the text *ac ante*, then locate the parent `li` element.

> Hint: Check the documentation for the `:contains()` pseudo-selector.

### Solution

```javascript
$("li:contains('ac ante')").eq(1).parents('li');
```

#### Adjustments based on provided solution

Instead of `eq`, you can use a child selector: `$("li li:contains('ac ante')").parents('li');`.

---

7. Find the list item that contains the text *ac ante*, then find and return the next element.

### Solution

```javascript
$("li li:contains('ac ante')").next();
```

---

8. Find all the table cells in the table, then find the last cell from the collection.

> Hint: Check the documentation for the `last()` method.

### Solution

```javascript
$('td').eq(-1);
```

#### Adjustments based on provided solution

My solution is fine. Based on the hint, another solution is: `$('td').last();`.

---

9. Find all the table cells that do not have a class of `"protected"`.

> Hint: Check the documentation for the :not() pseudo-selector or the not() method.

### Solution

```javascript
$('td').not('.protected');
```

---

10. Find all the anchor elements that have an `href` value that begins with #.

> Hint: Check the documentation for Attribute Selectors.

### Solution

```javascript
$('a[href^="#"]');
```

#### Adjustments based on provided solution

My solution works fine, but it's worth noting that the internal `""` around `#` are unecessary.

---

11. Find all elements that have a class name that contains `"block"`.

> Hint: Check the documentation for Attribute Selectors.


### Solution

```javascript
$('class*=block`);
```
