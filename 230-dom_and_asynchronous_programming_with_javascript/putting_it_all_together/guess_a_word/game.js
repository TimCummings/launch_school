const randomWord = function() {
  const words = ['apple', 'apricot', 'banana', 'fig', 'mango', 'orange', 'papaya', 'peach', 'pear', 'strawberry'];

  return function() {
    if (words.length === 0) return undefined;

    const randomIndex = Math.floor(Math.random() * words.length);
    return words.splice(randomIndex, 1)[0];
  };
}();

class Game {
  constructor() {
    this.reset(true);
  }

  reset(firstGame = false) {
    this.word = randomWord();
    if (!this.word) {
      this.displayMessage("Sorry, I've run out of words! Please reload the page.");
      return;
    }

    this.correctSpaces = 0;
    this.incorrectGuesses = 0;
    this.allowedIncorrectGuesses = 6;
    this.guessedLetters = [];
    document.querySelector('#replay').style.display = 'none';
    this.initSpaces();

    if (!firstGame) {
      document.body.classList.remove('win', 'lose');
      document.querySelector('#apples').className = '';
      this.unbindEvents();
    }

    this.bindEvents();
  }

  displayMessage(text) {
    const message = document.querySelector('#message');
    message.textContent = text;
  }

  initSpaces() {
    const spaces = document.querySelector('#spaces');
    const guesses = document.querySelector('#guesses');

    Array.from(spaces.querySelectorAll('span')).forEach(span => span.remove());
    Array.from(guesses.querySelectorAll('span')).forEach(span => span.remove());

    for (let counter = this.word.length; counter > 0; counter -= 1) {
      const content = document.createElement('span');
      content.textContent = ' ';
      spaces.append(content);
    }
  }

  bindEvents() {
    document.addEventListener('keyup', this.handleKeyPress);
    document.querySelector('#replay').addEventListener('click', this.replay);
  }

  unbindEvents() {
    document.removeEventListener('keyup', this.handleKeyPress);
    document.querySelector('#replay').removeEventListener('click', this.replay);
  }

  handleKeyPress = (event) => {
    if (!(/^[a-z]$/.test(event.key))) return;
    this.processGuess(event.key);
  }

  processGuess(letter) {
    if (this.guessedLetters.includes(letter)) return;

    this.guessedLetters.push(letter.toUpperCase());
    const guess = document.createElement('span');
    guess.textContent = letter.toUpperCase();
    document.querySelector('#guesses').append(guess);

    if (this.word.includes(letter)) {
      this.processCorrectGuess(letter);
    } else {
      this.processIncorrectGuess();
    }
  }

  processCorrectGuess(letter) {
    let prevIndex = 0;
    let index = this.word.indexOf(letter);

    while (index !== -1) {
      document.querySelectorAll('#spaces span')[index].textContent = letter.toUpperCase();
      this.correctSpaces += 1;
      prevIndex = index + 1;
      index = this.word.indexOf(letter, prevIndex);
    }

    if (this.correctSpaces >= this.word.length) this.gameOver('win');
  }

  processIncorrectGuess() {
    this.incorrectGuesses += 1;
    const newClass = `guess_${this.incorrectGuesses}`;
    const apples = document.querySelector('#apples');

    if (this.incorrectGuesses === 1) {
      apples.classList.add(newClass);
    } else {
      const oldClass = `guess_${this.incorrectGuesses - 1}`;
      apples.classList.replace(oldClass, newClass);
    }

    if (this.incorrectGuesses >= this.allowedIncorrectGuesses) this.gameOver('lose');
  }

  gameOver(result) {
    document.body.classList.add(result);
    document.removeEventListener('keyup', this.handleKeyPress);
    document.querySelector('#replay').style.display = 'inline';

    if (result === 'win') {
      this.displayMessage('You win!');
    } else {
      this.displayMessage("Sorry! You're out of guesses.");
    }
  }

  replay = (event) => {
    event.preventDefault();
    this.reset(false);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const game = new Game();
});
