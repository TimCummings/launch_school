
# Project: Guess a Word, Part 1: Core Functions - 3/29/2021

In this project, we're going to make a web-based version of guess a word. Guess a word is a game where you are presented with a series of blank spaces to represent the letters to the word that you need to complete. You guess a letter, and if you guessed a letter that appears in the word, the instances of that letter are revealed. If the guess does not appear in the word, an apple falls from the tree. If you guess incorrectly enough times, there are no more apples left on the tree and the game is over.

You can also [play a game of it here](https://d3905n0khyu9wc.cloudfront.net/guess_a_word/index.html).

To start with, you will need the HTML and CSS to display the apples, the word, and the guesses already given. Here's [the archive](https://d3905n0khyu9wc.cloudfront.net/guess_a_word/guess-a-word.zip) containing both. Alternatively, if you want to get some practice with writing HTML and CSS, you can create it from scratch following the description in [this gist](https://launchschool.com/gists/fa3cf899). The gist also includes a walkthrough video that you can reference. Take note that the succeeding walkthrough videos in the project uses the completed HTML and CSS that we provide.

When you have the HTML and CSS, start creating the game functionality. In this part, we'll focus on two pieces of core functionality of the game:

* A function that picks a random word from an array of words. The function has to pick a different word every time it runs, and when it's out of words, it returns `undefined`.
* How to start a new game. We'll need a Game constructor that can be used to create game objects.

## The randomWord() Function

We'll need a function `randomWord` that can pick one word out at a time randomly. A picked word can't be picked again, and when all words are taken, return `undefined`. For example:

```javascript
// the words are: 'apple', 'banana', 'orange' and 'pear'

randomWord();     // banana
randomWord();     // pear
randomWord();     // apple
randomWord();     // orange
randomWord();     // undefined
```

Our function has to have access to the words array defined outside of it. With each call of the function, it mutates the array to remove the element it used.

> Hint: We need to wrap the above code in an IIFE so the function scope protects private variables defined inside. To keep the private variables around, we'll need to return a function (or an object with methods in it) to create a closure. Check out these two articles for a refresher: [article 1](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Closures) and [article 2](https://lostechies.com/derekgreer/2012/02/17/javascript-closures-explained/).
>
## Start a New Game

We need a `Game` constructor that we can use to create a new game object. When we plan out the constructor, we need to examine all the states that a game needs to track.

* The word chosen for the current game.
* Number of incorrect guesses: this controls the number of apples we show.
* All the letters guessed: the letters will show for "Guesses"
* Total allowed wrong guesses: this should be 6, since we only have 6 apples!

A game object, after it's constructed, should be able to do the following:

* It needs to choose a word from the words array as the word of the game. If all words are chosen, show the "Sorry, I've run out of words!" message.
* Number of incorrect guesses should be initialized to 0.
* The letters guessed should be initialized as an empty array.
* Set total allowed wrong guesses to 6.
* Create blanks in the "Word:" container. The number of blanks should be the same as the length of the chosen word.

There is more than one way to implement the above requirements, and you could try to use both the pseudo-classical pattern or the OLOO pattern when it comes to the game object creation.

### Solution

```javascript
const randomWord = function() {
  const words = ['apple', 'apricot', 'banana', 'fig', 'mango', 'orange', 'papya', 'peach', 'pear', 'strawberry'];

  return function() {
    if (words.length === 0) return undefined;

    const randomIndex = Math.floor(Math.random() * words.length);
    return words.splice(randomIndex, 1)[0];
  };
}();

class Game {
  constructor() {
    this.word = randomWord();
    if (!this.word) alert("Sorry, I've run out of words! Please reload the page.");
    console.log('word:', this.word);

    this.incorrectGuesses = 0;
    this.allowedIncorrectGuesses = 6;
    this.guessedLetters = [];
    this.initSpaces();
  }

  initSpaces() {
    const spaces = document.querySelector('#spaces');

    for (let counter = this.word.length; counter > 0; counter -= 1) {
      const content = document.createElement('span');
      content.textContent = ' ';
      spaces.append(content);
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const game = new Game();
});
```
