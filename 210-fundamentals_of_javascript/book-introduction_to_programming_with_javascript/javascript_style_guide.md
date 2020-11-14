
# JavaScript Style Guide - 10/14/2020

* Set your text editor to use space characters—not tabs—for indentation. The editor should also insert spaces if you press the "tab" key on your keyboard.
* Set your text editor to use 2 spaces for indentation and when converting tab characters to spaces.
* Try to limit lines to 80 characters. This limit isn't a universal preference, but it helps readability. Not all developers have massive screens or good eyesight.
* JavaScript uses the character sequence `//` to mark the beginning of a comment. The comment runs through the end of the line. You can also use `/*` and `*/` for multiline comments if comments that you want to have in the middle of a line. Programmers use comments to leave notes for other programmers or themselves at a later point in time; however, don't overdo your comments. Let your code do the talking instead.
* Use **camelCase** formatting for variable and function names. Such names begin with a lowercase letter. If the name contains multiple words, each subsequent word should begin with an uppercase letter:

```javascript
let answerToUltimateQuestion = 42; // initializing a variable
function fourScoreAndSevenYearsAgo() { // defining a function
      // do something
}
```

* Some function names—constructor functions—can use PascalCase names. For instance:

```javascript
function DomesticCat(name) { // defining a function
  // do something
}
```

We discuss constructors briefly a little later.

* Use uppercase names with underscores to represent const values: values that don't change,

```javascript
const INTEREST_RATE = 0.0525;
const FOUR = 'four';
```

* All names—variables and constants as well as functions—should use the alphabetic and numeric characters only. The first character must be alphabetic. Constants may use underscores within the name, but should not use consecutive underscores nor may they begin or end with an underscore.

* When writing a code block with curly braces, write the opening brace on the same line as the function name or conditional expression. Use a single space between the function name and the opening brace:

```javascript
 bad
function test(){
 // do something
}

// bad
function test()
{
  // do something
}

// good
function test() {
  // do something
}
```

* Use spaces between operators and operands to make your code less cluttered and easier to read:

```javascript
    // bad
    let sum=x+5;

    // good
    let sum = x + 5;
```

* Use semicolons to terminate each logical line of code unless the line ends with `{`, `}`, or `:`. See the next section for details.

That covers the essential style conventions that you need to get started. If you want more information about JavaScript styling, we recommend [Airbnb's JavaScript style guide](https://github.com/airbnb/javascript).

## Semicolons

We recommend that you use them. JavaScript allows you to omit them, but it will automatically and invisibly insert them itself. Usually this works, but sometimes the insertion mechanism can make a mistake, which is difficult to debug. It's safer to insert them yourself:

```javascript
let x = 3
let y = 5

if (x === y) {
  console.log("x is equal to y")
} else {
  console.log("x is not equal to y")
}
```
