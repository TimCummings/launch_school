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
