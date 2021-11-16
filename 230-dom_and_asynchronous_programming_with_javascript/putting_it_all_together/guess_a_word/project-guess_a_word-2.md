
# Project: Guess a Word, Part 2: Event Handling and Game Play - 3/29/2021

Now let's look at how we handle the game play and interact with the user after a new game is started.

These are the general requirements for the gameplay:

* Bind a keypress event to the document that will check the guessed letter against the word.
  * Only process key presses that are letters. IN other words, from `a` to `z`. You can potentially use the equivalent keycodes for these letters, which run from `97` (`a`) through `122` (`z`).
  * Add the letter to the array of guessed letters.
  * If the guess matches at least one letter in the word, output each instance of the guessed letter in the respective blank spaces.
  * If the guess is not a match, increment the incorrect guess count and change the class name on the apples container to change the count of apples.
  * If the letter has already been guessed, ignore it.
* When a letter is guessed, write it to the guesses container.
* If the number of incorrect guesses matches the number of guesses available for a game (6 in this case), the game is over. Display a message and a link to start a new game. Unbind the keypress event.
* If all of the letters of the word have been revealed, display a win message and a link to start a new game. Unbind the keypress event.
* When the "Play another" button is clicked, a new game is constructed. The class on the apples container gets reset to show 6 apples again.

> Hint: Bind Keypress Events
>
> Note that the [keypress](https://developer.mozilla.org/en-US/docs/Web/API/Document/keypress_event) event has been deprecated. You can use the [keyup](https://developer.mozilla.org/en-US/docs/Web/API/Document/keyup_event) event to the same effect for this project.
>
> The `which` property of the Event object will provide you with a character code, which you can convert to the string for the key pressed, using [String.fromCharCode()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/fromCharCode). Alternatively the `key` property of the Event object will provide you with the character itself.
>
> If implementing your solution with jQuery, it provides a [keyup method](https://api.jquery.com/keyup/) to bind an event handler for keyup events.

> Hint: Unbind Keypress Events
>
> If implementing your solution with jQuery, you can use its [unbind](https://api.jquery.com/unbind/) method.
>
> For a vanilla JS solutions, the Event API provides a [removeEventListener](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/removeEventListener) method. When using this method, be aware that the second argument to the method must be a **name function** rather than an anonymous callback, and that the arguments to the method **must match** the arguments passed to the `addEventListener()` call that bound the event.

### Solution

[game.js](game.js)
