
# Input/Output - 10/17/2020

## Command Line Output

We've already seen one method of command line output: `console.log()`:

```javascript
let name = 'Jane';
console.log(`Good morning, ${name}!`);
```

`node` provides other ways to send messages to the console, but `console.log()` works in `node` and most browsers so we'll stick with it for now.

### Command Line Input

Node.js has an API called **readline** that lets JavaScript programs read input from the command line. However, the API isn't straightforward or simple: it requires an understanding of asynchronous programming and higher-order functions. We don't explore these concepts in this book. For now, we can use a simplified version of the readline library called **readline-sync**.

To install readline-sync, run the following command from the command line:

```
$ npm install readline-sync --save
```

This command installs the package in the `node_modules` subdirectory of your current directory. By placing it in this subdirectory, any Node.js programs stored in the current directory can require the package with a simple call to `require`, as we'll see in the following example:

#### Example: Greet the User By Name

Let's use **readline-sync** to write a program that displays a personalized greeting message for the user based on the name she provides. Create a file named **personalized_greeting.js** with the following code:

```javascript
let rlSync = require('readline-sync');
let name = rlSync.question("What's your name?\n");
console.log(`Good Morning, ${name}!`);
```

This example needs a little explanation. Line 2 uses Node's built-in `require` function to import `readline-sync` into your program. It returns the library as an object, which we assign to the `rlSync` variable. On line 3, we use `rlSync` to call the `question` method. This method displays its string argument, then waits for the user to respond. When the user types some text and presses Return, it returns that text to the program. Here, we assign that text to the variable `name` and use it to display a personalized greeting.

### Input in the Browser

Working with a browser's input controls requires a working knowledge of the Document Object Model (DOM), which is outside the scope of this book. However, you don't need to know about the DOM to get user inputs. Most browsers implement the `prompt` function which lets a program ask for and obtain text-based input from the user.

Let's re-implement our personalized greeting program for the browser. First, we need to create an HTML file with the following content:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Testing Prompt</title>
</head>
<body>
  <script src="personalized_greeting_browser.js"></script>
</body>
</html>
```

Since our HTML expects a `personalized_greeting_browser.js` file, go ahead and create one with the code shown below. Place it in the same directory as the HTML file:

```javascript
let name = prompt("What's your name?");
console.log(`Good Morning, ${name}`);
```

### Exercises

1. Write a dynamic greeter program named `greeter.js`. The program should ask for your name, then output `Hello, {name}!` where `{name}` is the name you entered:

```
$ node greeter.js
What is your name? Sue
Hello, Sue!
```

### Solution

```javascript
rlSync = require('readline-sync');
name = rlSync.question('What is your name? ');
console.log(`Hello, ${name}!`);
```

---

2. Modify the `greeter.js` program to ask for the user's first and last names separately, then greet the user with their full name.

```
$ node greeter.js
What is your first name? Sue
What is your last name? Roberts
Hello, Sue Roberts!
```

### Solution

```javascript
rlSync = require('readline-sync');
firstName = rlSync.question('What is your first name? ');
lastName = rlSync.question('What is your last name? ');
console.log(`Hello, ${firstName} ${lastName}!`);
```

---

3. Modify the `age.js` program you wrote in the exercises for the *Variables* chapter. The updated code should ask the user to enter their age instead of hard-coding the age in the program. Here's an example run:

```
How old are you? 22
You are 22 years old.
In 10 years, you will be 32 years old.
In 20 years, you will be 42 years old.
In 30 years, you will be 52 years old.
In 40 years, you will be 62 years old.
```

### Solution

```javascript
rlSync = require('readline-sync');
age = Number(rlSync.question('How old are you? '));

console.log(`You are ${age} years old.`);
console.log(`In 10 years, you will be ${age + 10} years old.`);
console.log(`In 20 years, you will be ${age + 20} years old.`);
console.log(`In 30 years, you will be ${age + 30} years old.`);
console.log(`In 40 years, you will be ${age + 40} years old.`);
```
