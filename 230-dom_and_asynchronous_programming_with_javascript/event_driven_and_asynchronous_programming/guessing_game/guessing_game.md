
# Guessing Game - 3/6/2021

The goal of this assignment is to create a guessing game that asks the player to guess an integer between 1 and 100 chosen by the computer. The program first picks a random value using a random number generator. The player then enters her guess and submits it, and the program checks whether the guess is higher, lower, or equal to the computer's chosen number, and reports the result. The player may continue to play until she guesses the number.

Since our focus for this assignment is JavaScript, we'll provide the HTML and CSS necessary to build this program:

```html
<main>
  <h1>Number Guessing Game</h1>
  <p>Loading...</p>
  <form action="" method="get">
    <fieldset>
      <input type="text" id="guess" maxlength="3" />
      <input type="submit" value="Guess" />
    </fieldset>
  </form>
  <a href="#">New game</a>
</main>
```

```css
html, body {
  padding: 25px 0;
  margin: 0;
  font: normal 16px Helvetica, Arial, sans-serif;
  text-align: center;
  color: #16997c;
  background: #5bccb3;
}

main {
  display: block;
  max-width: 450px;
  padding: 20px;
  margin: 0 auto;
  background: #ffffff;
  box-sizing: border-box;
}

h1 {
  color: #CC183E;
}

fieldset {
  padding: 0 0 25px 0;
  margin: 0;
  border: none;
}

input[type="text"] {
  width: 80px;
  height: 50px;
  padding: 5px;
  margin: 0 0 20px 0;
  font: normal 24px Georgia, Palatino, serif;
  text-align: center;
  border: 1px solid #cecece;
  box-sizing: border-box;
}

input[type="submit"] {
  display: block;
  width: 100%;
  padding: 15px 0;
  font: normal 20px Helvetica, Arial, sans-serif;
  color: #ffffff;
  text-shadow: 1px 1px 5px rgba(80, 80, 80, .8);
  border: 1px solid #91112C;
  box-shadow: 0 0 1px 1px #780e24;
  border-radius: 11px;
  background: linear-gradient(to bottom, #CC183E 0%, #780E24 100%);
}

a { color: #cc183e; }
```

Here's a breakdown of the steps to take:

1. Create an event listener that will run when the document's `DOMContentLoaded` event fires. In the subsequent steps, you'll add code to this event listener so that it will run when the page finishes loading.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
});
```

---

2. Create a local variable named `answer` in the `DOMContentLoaded` listener. Its value should be a randomly generated integer between `1` and `100`, inclusive.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  const MIN = 1;
  const MAX = 100;
  let answer = Math.floor(Math.random() * (MAX - MIN + 1) + MIN);
});
```

---

3. Add an event listener that will run when the user submits the form. It should retrieve the value from the `input` text field and convert it to a number with `parseInt`. Store the number in a local variable named `guess`.

The browser shouldn't send the form content to the server; you can prevent it from doing that with `preventDefault`. If you do send the data, the page will refresh after each submission and you'll lose everything!

### Solution

```javascript
document.querySelector('form').addEventListener('submit', event => {
  event.preventDefault();
  let guess = parseInt(document.getElementById('guess').value, 10);
});
```

---

4. Create a local variable named `message`. We will use `message` in subsequent problems to store a message that we will show to the user.

### Solution

```javascript
document.querySelector('form').addEventListener('submit', event => {
  event.preventDefault();
  let guess = parseInt(document.getElementById('guess').value, 10);
  let message;
});
```

---

5. Check whether the guess is higher than the answer. If it is, set the `message` variable to a message that says the answer is lower than the guess.

### Solution

```javascript
document.querySelector('form').addEventListener('submit', event => {
  event.preventDefault();
  let guess = parseInt(document.getElementById('guess').value, 10);
  let message;

  if (guess > answer) message = `My number is lower than ${guess}.`;
});
```

---

6. Update the code so that it sets `message` to an appropriate value when the answer is higher than the guess, and another message when it is correct.

### Solution

```javascript
document.querySelector('form').addEventListener('submit', event => {
  event.preventDefault();
  let guess = parseInt(document.getElementById('guess').value, 10);
  let message;

  if (guess > answer) message = `You guessed it!`;
  if (guess > answer) message = `My number is lower than ${guess}.`;
  if (guess < answer) message = `My number is greater than ${guess}.`;
});
```

---

7. Display the message determined by problems 5 and 6 to the page. Find the message element on the page with `querySelector` and set its `textContent` property to the value of `message`.

### Solution

```javascript
document.querySelector('form').addEventListener('submit', event => {
  event.preventDefault();
  let guess = parseInt(document.getElementById('guess').value, 10);
  let message;

  if (guess === answer) {
    message = `You guessed it!`;
  } else if (guess > answer) {
    message = `My number is lower than ${guess}.`;
  } else {
    message = `My number is greater than ${guess}.`;
  }

  document.querySelector('p').textContent = message;
});
```

---

8. Add an event listener that fires when the user clicks the "New game" link.

### Solution

```javascript
document.querySelector('a').addEventListener('click', event => {
});
```

---

9.In the event listener for a new game, change the answer to a new random number from 1 to 100, and set the message shown to the user to one that asks the player to guess a number.

### Solution

```javascript
document.querySelector('a').addEventListener('click', event => {
  answer = randomNumber();
  message = `Guess a number from ${MIN} to ${MAX}.`;
  document.querySelector('p').textContent = message;
});
```

---

10. In question 9, we assigned the `paragraph` variable's `textContent` property to the message. Will this code work? Why or why not?

### Solution

This will work. The detriment to mutating the `textContent` property is that it rreplaces all child nodes with a single text node containing the specified text. In this case, the only child of the `paragraph` variable's element is a single node.

#### Adjustments based on provided solution

My solutions have diverged slightly from the provided solution: I never assigned the `p` element to a `paragraph` variable but re-invoked `querySelector`, so my version won't suffer from the issue of the `paragraph` variable being out of scope.

---

11. **Bonus Question** If you want an extra challenge, add the following features:

* Check whether the input value is a valid integer; display an appropriate message if it is not.
* Disable the `Guess` button once the user guesses the number. (You may need to use MDN to find out how to do this.) When you disable the box, it should also change to a dimmer color (your choice) and take on a flatter appearance (use the `box-shadow` property).

Here is a completed version of the problem, slightly refactored to add a newGame function and a counter for the number of guesses. You can use this version as the starting point for the bonus question.

```html
<main>
  <h1>Number Guessing Game</h1>
  <p>Loading...</p>
  <form action="" method="get">
    <fieldset>
      <input type="text" id="guess" maxlength="3">
      <input type="submit" value="Guess">
    </fieldset>
  </form>
  <a href="#">New game</a>
</main>
```

```css
html, body {
  padding: 25px 0;
  margin: 0;
  font: normal 16px Helvetica, Arial, sans-serif;
  text-align: center;
  color: #16997c;
  background: #5bccb3;
}

main {
  display: block;
  max-width: 450px;
  padding: 20px;
  margin: 0 auto;
  background: #ffffff;
  box-sizing: border-box;
}

h1 {
  color: #CC183E;
}

fieldset {
  padding: 0 0 25px 0;
  margin: 0;
  border: none;
}

input[type="text"] {
  width: 80px;
  height: 50px;
  padding: 5px;
  margin: 0 0 20px 0;
  font: normal 24px Georgia, Palatino, serif;
  text-align: center;
  border: 1px solid #cecece;
  box-sizing: border-box;
}

input[type="submit"] {
  display: block;
  width: 100%;
  padding: 15px 0;
  font: normal 20px Helvetica, Arial, sans-serif;
  color: #ffffff;
  text-shadow: 1px 1px 5px rgba(80, 80, 80, .8);
  border: 1px solid #91112C;
  box-shadow: 0 0 1px 1px #780e24;
  border-radius: 11px;
  background: linear-gradient(to bottom, #CC183E 0%, #780E24 100%);
}

a { color: #cc183e; }
```

```javascript
document.addEventListener('DOMContentLoaded', function() {
  let form = document.querySelector('form');
  let input = document.querySelector('#guess');
  let paragraph = document.querySelector('p');
  let link = document.querySelector('a');  
  let answer;
  let guesses;

  function newGame() {
    answer = Math.floor(Math.random() * 100) + 1;
    guesses = 0;
    paragraph.textContent = 'Guess a number from 1 to 100';
  }

  form.addEventListener('submit', event => {
    event.preventDefault();

    let guess = parseInt(input.value, 10);
    let message;

    guesses += 1;

    if (guess === answer) {
      message = `You guessed it! It took you ${guesses} guesses.`;
    } else if (guess > answer) {
      message = `My number is lower than ${guess}`;
    } else {
      message = `My number is higher than ${guess}`;
    }

    paragraph.textContent = message;
  });

  link.addEventListener('click', event => {
    event.preventDefault();
    newGame();
  });

  newGame();
});
```

### Solution

```css
input:disabled {
  background: #d39faa;
  box-shadow: none;
}
```

```javascript
document.addEventListener('DOMContentLoaded', function() {
  let form = document.querySelector('form');
  let input = document.querySelector('#guess');
  let button = document.querySelector('input[type="submit"]');
  let paragraph = document.querySelector('p');
  let link = document.querySelector('a');
  let answer;
  let guesses;

  function newGame() {
    answer = Math.floor(Math.random() * 100) + 1;
    guesses = 0;
    paragraph.textContent = 'Guess a number from 1 to 100';
    button.removeAttribute('disabled');
  }

  form.addEventListener('submit', event => {
    event.preventDefault();

    let guessString = input.value;
    let guess = parseInt(guessString, 10);
    let message;

    if (String(guess) !== guessString) {
      message = 'Numbers only, please.';
    } else if (guess < 1 || guess > 100) {
      message = 'Guess must be between 1 and 100.';
    } else {
      guesses += 1;

      if (guess === answer) {
        message = `You guessed it! It took you ${guesses} guesses.`;
        button.setAttribute('disabled', '');
      } else if (guess > answer) {
        message = `My number is lower than ${guess}`;
      } else {
        message = `My number is higher than ${guess}`;
      }
    }

    paragraph.textContent = message;
  });

  link.addEventListener('click', event => {
    event.preventDefault();
    newGame();
  });

  newGame();
});
```
