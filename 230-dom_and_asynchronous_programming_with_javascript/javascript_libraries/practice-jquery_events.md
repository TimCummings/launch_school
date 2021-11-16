
# Practice Problems: JQuery Events - 3/23/2021

In this assignment, we're going to become more familiar with jQuery events by using a form that will allow you to assign a key that, when pressed, toggles an accordion. When the form is submitted, you'll unbind the current key press event and bind a new event that listens for the new key that is entered into the form. There will also be an anchor that will trigger the key press when it is clicked on.

## Creating the HTML

To start with, create a form with a submit button that has a text input that only allows one character to be entered. Create an anchor below that to toggle the accordion, then create a `div` with an ID of `accordion` and add a paragraph of text to it. Once your markup is done, you can move on to the jQuery needed to add the functionality.

>If you wish to jump right into the jQuery portion of the assignment, you may download [this archive](https://d3jtzah944tvom.cloudfront.net/jquery_events/jquery-events.zip). It contains the completed HTML and CSS.

## The Events

Start by adding a `submit` event to the form. Within the callback, read in the character that was entered in to the text input. Once you have the character stored in a variable, you can bind the `keypress` event to the document. We bind it to the document to make sure that we obtain the `keypress` event no matter where the user's focus is within the page. The `document` object is not actually an HTML element, so we don't use a selector like "body" or "form" to locate it. Instead, we use the `document` variable that is already present in JavaScript. Here is an example of how we would bind our `keypress` event.

```javascript
$(document).on('keypress', function() {
  // code
});
```

### Unbinding

Before we bind the event, though, we will need to first unbind any previous `keypress` event that was bound. jQuery has a complimentary method called "off" that allows you to unbind an event by its type.

> If we don't unbind, there will eventually be multiple keys that can toggle the accordion. By unbinding any previous `keypress` event, we are making it so that only the key that is currently set can toggle.

```javascript
$(document).off('keypress');
```

Since one of the biggest benefits to using jQuery is to be able to chain methods together, we can chain our event binding onto our unbinding.

```javascript
$(document).off('keypress').on('keypress', function() {
  // code
});
```

Now there will only be one keypress event at a time on the document.

### The Keypress Event Callback

Within the event callback, to check whether or not the correct key was pressed, we would check a property on the event object that is passed in. The `key` property will tell you which key was pressed. This is where your previously stored character comes in. Check to see if the `key` property is different than the saved character, and if so stop the event from processing further by using a `return` statement like this:

```javascript
if (e.key !== character) {
  return;
}
```

The `return` statement will stop the event handler from doing any more of its processing, since the key that was pressed was not the one we were looking for.

After our `if` statement, we know that the correct key was pressed. We can now toggle the accordion element. Use jQuery to find the accordion element by its ID, then call a built-in animation method called `slideToggle`. This will figure out whether or not the accordion is visible for you and animate its visibility by sliding the bottom edge of the element up or down.

### Preventing Form Submission

Now that we have bound the `keypress` event within our form's `submit` event, we need to remember to prevent the form from submitting. Change the callback function to accept the event object as an argument. At the top of the `submit` event callback, call ~preventDefault~(); on that event object to stop the form from submitting.

```javascript
$('form').on('submit', function(e) {
  e.preventDefault();
  // ...
});
```

### Triggering a Different Event

Our final event needs to be bound to the anchor element. Bind a click event to the anchor, and use the same method as the `submit` event to prevent the default behavior of the anchor. In our callback, we could duplicate the `slideToggle` that happens in our keypress event, but instead we should consider having the toggle only in one pace. Then if something changes later on, like the ID we are using, we only have one place we need to make an update to. What we can do instead is to move the `slideToggle` from the `keypress` event to this one, then our `keypress` event can trigger the click event on this anchor. Take your accordion `slideToggle` line from the `keypress` event and move it to this click event callback. Now go back to the spot in the `keypress` event callback that you removed the `slideToggle` from and instead write a jQuery selector to find the anchor. When you've found it, you can then call `trigger("click")` on the anchor. This will trigger the event that you give to it, meaning that the anchor's click event callback will run and the `slideToggle` will occur.

```javascript
$('a').trigger('click');
```

The `trigger` method can be called with any of the events, and if the event exists it will call the callback. As a result, we have eliminated the need for repeating our code.

Now you should have an understanding of how to remove an event callback using `off` and how to trigger a different event using `trigger`. Both will become very useful as you work on more involved projects that use jQuery events.l

### Solution

[jquery_events.html](jquery_events.html)
