
# JS210 Small Problems - Debugging - 12/1/2020

## 1. Word Ladder

Gemma and some friends are working on a complex program to generate [word ladders](https://en.wikipedia.org/wiki/Word_ladder), transforming one word into another word one character at a time. The smallest of her tasks is to print the resulting ladder to the screen.

A "ladder" is simply an array of word strings; Gemma decides to transform this array into a single string where each word within the string is separated by a hyphen (`'-'`). For example, the array `['pig', 'pie', 'lie', 'lit', 'let']` should be printed as the string `'pig-pie-lie-lit-let'`.

Upon first glance, Gemma's code below looks like it should work. But it throws a `TypeError`, saying: `Cannot read property 'forEach' of undefined`. Why is that?

```javascript
let ladder = ''

['head', 'heal', 'teal', 'tell', 'tall', 'tail'].forEach(word => {
  if (ladder !== '') {
    ladder += '-'
  }

  ladder += word
})

console.log(ladder)  // expect: head-heal-teal-tell-tall-tail
```

### Solution

This code is missing semi-colons, specifically one after `let ladder = ''`. JavaScript is treating the array literal on line 3 as property access via bracket notation. While adding a semicolon after `let ladder = ''` gets the code to run as expected, there are several more missing semi-colons:

```javascript
let ladder = '';

['head', 'heal', 'teal', 'tell', 'tall', 'tail'].forEach(word => {
  if (ladder !== '') {
    ladder += '-';
  }

  ladder += word;
});

console.log(ladder);  // expect: head-heal-teal-tell-tall-tail
```

---

## 2. Reserved Keywords

We have been asked to implement a function that determines whether or not a given word is a reserved [keyword](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Lexical_grammar#Keywords). We wrote the `isReserved` function below along with some test cases, but we aren't seeing the expected result. Why not? Fix the code so that it behaves as intended.

```javascript
const RESERVED_KEYWORDS = ['break', 'case', 'catch', 'class', 'const', 'continue',
  'debugger', 'default', 'delete', 'do', 'else', 'enum', 'export', 'extends', 'finally',
  'for', 'function', 'if', 'implements', 'import', 'in', 'instanceof', 'interface',
  'let', 'new', 'package', 'private', 'protected', 'public', 'return', 'static',
  'super', 'switch', 'this', 'throw', 'try', 'typeof', 'var', 'void', 'while',
  'with', 'yield'];

function isReserved(name) {
  RESERVED_KEYWORDS.forEach(reserved => {
    if (name === reserved) {
      return true;
    }
  });

  return false;
}

console.log(isReserved('monkey')); // false
console.log(isReserved('patch'));  // false
console.log(isReserved('switch')); // should be: true
```

### Solution

The problem with this code is line 11: the `return` statement doesn't return from the `forEach` function as intended, but from inside the anonymous callback function that is provided as an argument to `forEach`. `forEach` will continue to iterate through the array and the `isReserved` function will always return `false`.

This can be a fixed a few ways: the least amount of code change is to add a boolean `result` variable outside of `forEach`, then reassign `result` to true on line 11 instead of returning true. The downside to this solution is that `forEach` will iterate through the entire array even if it detects a keyword before finishing and could otherwise return early.

An alternative solution that allows early return is to iterate the `RESERVED_KEYWORDS` array with a block instead of a function. This could be done with a `for` loop, a `while` loop, or `for...of`:


```javascript
function isReserved(name) {
  for (let index = 0; index < RESERVED_KEYWORDS.length; index += 1) {
    if (name === RESERVED_KEYWORDS[index]) {
      return true;
    }
  }

  return false;
}
```

---

## 3. Random Recipe Generator

One bored and hungry evening we decided to randomly generate recipes. We can't wait to see the first suggestions, but JavaScript raises a `TypeError`, telling us that `dishName.join` is not a function. What is wrong?

```javascript
// Picks n random elements from an array,
// and returns a new array with those elements.
function random(array, n) {
  if (n === undefined) {
    n = 1;
  }

  const elements = array.slice();
  const randomElements = [];

  while (n > 0 && elements.length > 0) {
    const randomIndex = Math.floor(Math.random() * elements.length);
    const randomElement = elements[randomIndex];

    randomElements.push(randomElement);
    elements.splice(randomIndex, 1);
    n--;
  }

  return randomElements;
}

// Ingredients

const ingredients = ['rice', 'green bell pepper', 'mushrooms', 'carrot', 'kebab',
  'spinach', 'soy bean sprouts', 'mashed potatoes', 'corn', 'cucumber', 'peas'];

const spices = ['peri peri', 'cinnamon', 'nutmeg', 'cardamom', 'ground ginger',
  'poppy seed', 'cumin'];

const extras = ['peanuts', 'sesame seeds', 'egg', 'wasabi', 'soy sauce'];

// Name

const adjective  = ['Delicious', 'Hot', 'Exotic', 'Creative', 'Festive', 'Dark'];
const firstNoun  = ['Power', 'After Work', 'Holiday', 'Disco', 'Late Night'];
const secondNoun = ['Mix', 'Delight', 'Bowl', 'Chunk', 'Surprise', 'Bliss'];

// Generate!

const dishName = random(adjective) + random(firstNoun) + random(secondNoun);
const dish = random(ingredients, 3) + random(spices, 2) + random(extras, 1);

console.log(`How about: ${dishName.join(' ')}`);
console.log(`You need: ${dish.join(', ')}`);
```

### Solution

The problem is with lines 41 and 42: the binary `+` operator does not handle arrays as this code expects. `+` does not concatenate arrays but coerces them to strings and then concatenates the strings. The `TypeError` comes from calling `.join` on a string, which is what `dishName` contains on line 44. If we fix this error, we'll see it again with `dish` on line 45 for the same reason. This can be fixed by using `Array.prototype.concat` on lines 41 and 42 instead of `+`:

```javascript
const dishName = random(adjective).concat(random(firstNoun), random(secondNoun));
const dish = random(ingredients, 3).concat(random(spices, 2), random(extras, 1));
```

---

## 4. Task List

We were asked to implement a task list and the following functionality:

* adding a new task
* completing a given number of existing tasks
* displaying the task list

We decided to keep things simple and model the tasks as strings. Completing a task for us simply means deleting the string from the array of tasks.

Experimenting with our code reveals that it doesn't work exactly as we expected. Find the problem and fix it.

```javascript
const todos = ['wash car', 'exercise', 'buy groceries', 'balance budget',
             'call plumber', 'feed fido', 'get gas',  'organize closet'];

function addTask(task) {
  if (todos.includes(task)) {
    console.log('That task is already on the list.');
  } else {
    todos.push(task);
  }
}

function completeTasks(n = 1) {
  let tasksComplete = 0;

  while (todos.length > 0 && tasksComplete < n) {
    console.log(`${todos[0]} complete!`);
    delete todos[0];
    tasksComplete++;
  }

  if (todos.length === 0) {
    console.log('All tasks complete!');
  } else {
    console.log(`${tasksComplete} tasks completed; ${todos.length} remaining.`);
  }
}

function displayTaskList() {
  console.log(`ToDo list (${todos.length} tasks):`)
  console.log('---------------------');

  for (let i = 0; i < todos.length; i++) {
    console.log(`-- ${todos[i]}`);
  }
}

// Utilizing our task manager

addTask('oil change');
addTask('dentist');
addTask('homework');

completeTasks(3);
displayTaskList();
```

### Solution

The problem is on line 17: using `delete` on an array element does not reduce the size of the array. Instead of the `todos` array getting smaller as expected, its length stays the same and attempting to access an index with a deleted element evaluates to `undefined`. This can be fixed by using `Array.prototype.shift` or `Array.prototype.splice` instead of `delete`:
```javascript
function completeTasks(n = 1) {
  let tasksComplete = 0;

  while (todos.length > 0 && tasksComplete < n) {
    console.log(`${todos[0]} complete!`);
    todos.shift();
    tasksComplete++;
  }

  if (todos.length === 0) {
    console.log('All tasks complete!');
  } else {
    console.log(`${tasksComplete} tasks completed; ${todos.length} remaining.`);
  }
}
```

---

## 5. Range

We are assigned the task to implement a `range` function that returns an array of integers beginning and ending with specified start and end numbers. When only a single argument is provided, that argument should be used as the ending number and the starting number should be 0.

Check our code below. Why do the example invocations fail with an error saying `Maximum call stack size exceeded`? Can you fix the code, so it runs without error and satisfies the requirements?

```javascript
function range(start, end) {
  const range = [];

  for (let element = start; element <= end; element++) {
    range.push(element);
  }

  return range;
}

function range(end) {
  return range(0, end);
}

// Examples

console.log(range(10, 20));
console.log(range(5));
```

### Solution

`range` is used way too many places: for two different functions and as a variable inside one of the functions. The immediate problem resulting in the `Maximum call stack size exceeded` error is that the `range` function on lines 11-13 calls itself and has no terminating condition. The range function defined on lines 1-9 is never invoked because the `range` global variable is reassigned to the second `range` function. These functions need different names or need to be combined into a single function.

The `range` function should also not define a local `range` variable - this is extremely confusing and likely to cause furhter bugs.

```javascript
function range(start, end) {
  const numbers = [];

  if (!end) {
    end = start;
    start = 0;
  }

  for (let element = start; element <= end; element++) {
    numbers.push(element);
  }

  return numbers;
}
```

#### Adjustments based on Further Exploration

```javascript
function range(start, end) {
  const numbers = [];

  if (arguments.length === 1) {
    end = start;
    start = 0;
  }

  for (let element = start; element <= end; element++) {
    numbers.push(element);
  }

  return numbers;
}
```

#### Further exploration

There are two reasons why the following is not a working solution. Can you spot them?

```javascript
function range(start, end) {
  if (!end) {
    start = 0;
    end = start;
  }

  // ...
}
```

##### FE Solution

As this was almost my exact solution, this is an especially important Further Exploration for me to do:

One issue is a range that starts with a negative number and ends with 0: 0 is a falsy value in JavaScript, so it will trigger the `if (!end)` conditional, swapping the `start` and `end` values and returning an empty array, e.g. `range(-5, 0)` returns `[]` instead of `[-5, -4, -3, -2, -1, 0]`.

The second issue is one I narrowly avoided: this specified solution assigns `start` and `end` in the wrong order: since `start` is first assigned to zero, then `end` is assigned to start, `start` and `end` will both be zero.


---

## 6. Member Directory

Caroline manages the member directory of her club and decided to implement a program she can use for doing that. Since the club is not very big, it's sufficient for her to keep the members' names and phone numbers in an object. Later she wants to add functionality that allows her to write this object to a file.

One requirement Caroline takes very seriously is input validation. She intended for her code to strictly require that only alphabetic letters be included in the members' first and last names, separated by a space. But upon making a typo when entering the information of the newest member, she realizes that isn't the case.

Figure out why not and fix the code so that it works as expected. You may also consider writing a few more test cases to insure that the input validation requirement is properly met.

```javascript
const memberDirectory = {
  'Jane Doe': '323-8293',
  'Margaret Asbury': '989-1111',
  'Callum Beech': '533-9090',
  'Juanita Eastman': '424-1919',
};

function isValidName(name) {
  return (/^\w+ \w+$/).test(name);
}

function isValidPhone(phone) {
  return (/^\d{3}-\d{4}$/).test(phone);
}

function validMemberInfo(name, phone) {
  return isValidName(name) && isValidPhone(phone);
}

function addMember(name, phone) {
  if (validMemberInfo(name, phone)) {
    memberDirectory[name] = phone;
  } else {
    console.log('Invalid member information.');
  }
}

addMember('Laura Carlisle', '444-2223');
addMember('Rachel Garcia', '232-1191');
addMember('Earl 5mith', '331-9191');

console.log(memberDirectory);
```

### Solution

The problem is that regexp word characters (specified with `\w`) allow letters, numbers, and underscores. If we want to allow only letters, we must use `[a-z]` with the case insensitive flag `i`, or `[a-zA-Z]`:

```javascript
function isValidName(name) {
  return (/^[a-z]+ [a-z]+$/i).test(name);
}

addMember('Laura Carlisle', '444-2223');
addMember('Rachel Garcia', '232-1191');
addMember('Earl 5mith', '331-9191');
addMember('Earl-Smith', '331-9191');
addMember('Earl_Smith', '331-9191');
addMember('Earl*Smith', '331-9191');
addMember('EarlSmith', '331-9191');
addMember('Earl Smith', '2331-9191');
addMember('Earl Smith', '331-91918');
addMember('Earl Smith', '3319191');
```

---

## 7. Molecules

We decided to dip our toes into computational chemistry. Our first task is to write a function that computes the total number of [valence electrons](https://en.wikipedia.org/wiki/Valence_electron) in a molecule. Fortunately, this is relatively straightforward. For each element in the molecule, we need to know two things:

* The element's atomic number. We can get this from the periodic table and decided to simply hard-code it in a `valence` function for now.
* The number of atoms of that element in the molecule. We can read this directly from the string representation of the molecule.

For example, [Geosmin](https://en.wikipedia.org/wiki/Geosmin) has the string representation `C12H22O`, so it has 12 `C` atoms, 22 `H` atoms, and 1 `O` atom, summing up to `12*4 + 22*1 + 1*6 = 76` valence electrons.

We decided to write our function `valenceOfMolecule` such that it expects string representations of each element in the molecule as input, e.g. `valenceOfMolecule('C12', 'H22', 'O')`. It then returns the total number of all valence electrons in that molecule. Well, almost. Can you explain why it throws an exception and how to fix it?

```javascript
function valence(element) {
  switch (element) {
    case 'H': return 1;
    case 'C': return 4;
    case 'N': return 5;
    case 'O': return 6;
    // omitting the rest
  }
}

function valenceOfMolecule() {
  let sum = 0;

  arguments.forEach(atom => {
    const match   = /([a-zA-Z]+)([0-9]*)/.exec(atom);
    const element = match[1];
    const number  = parseInt(match[2]) || 1;

    sum += number * valence(element);
  });

  return sum;
}

// Example

console.log('Number of valence electrons');
console.log('---------------------------');
console.log(`Water:     ${String(valenceOfMolecule('H2', 'O'))}`);
console.log(`Propane:   ${String(valenceOfMolecule('C3', 'H8'))}`);
console.log(`Vitamin C: ${String(valenceOfMolecule('C6', 'H8', 'O6'))}`);
console.log(`Caffeine:  ${String(valenceOfMolecule('C8', 'H10', 'N4', 'O2'))}`);

// Expected output:
// Number of valence electrons
// ---------------------------
// Water:     8
// Propane:   20
// Vitamin C: 68
// Caffeine:  74
```

### Solution

`arguments` is not an array, it's only *array-like* in some ways; those ways do not include a `forEach` method, which causes the `TypeError` we encounter when running this code. A better way to do this as of ES6 is with a rest parameter. Also, while it doesn't directly cause an error here, we should specify a `radix` argument inside the `parseInt` function:

```javascript
function valenceOfMolecule(...atoms) {
  let sum = 0;

  atoms.forEach(atom => {
    const match   = /([a-zA-Z]+)([0-9]*)/.exec(atom);
    const element = match[1];
    const number  = parseInt(match[2], 10) || 1;

    sum += number * valence(element);
  });

  return sum;
}
```

---

## 8. Glory!

We want to implement a role-playing game and started working on the dice roll functionality. First, study the game code. Then take a look at the example output and information provided below.

```javascript
// Standard role-playing dice, ranging from 4 faces to 20,
// specified in terms of minimum and maximum face value.
const d4  = {min: 1, max: 4};
const d6  = {min: 1, max: 6};
const d8  = {min: 1, max: 8};
const d10 = {min: 0, max: 9};
const d12 = {min: 1, max: 12};
const d20 = {min: 1, max: 20};

function roll({max, min}) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

// Toss one or more dice and sum up their face values.
function toss(...args) {
  const dice = Array.prototype.slice.call(args);

  return dice.map(roll).reduce((sum, value) => sum + value);
}

// Standard target roll tossing a 20-sided die,
// with optional bonus and penalty dice.
// Used to determine whether a character wanting to perform an action
// succeeds or fails, based on whether the sum of the dice is higher
// or lower than the relevant character trait.
// (See below for examples.)
function targetRoll(characterValue, bonus = {min: 0, max: 0}, penalty = {min: 0, max: 0}) {
  let result = toss(d20, bonus, penalty);
  // Normalize in case bonus or penalty push result out of the D20 range.
  result = Math.max(1, result);
  result = Math.min(20, result);

  console.log(`--> ${result}`);

  switch (result) {
    case 1:  automaticFail();
    case 20: automaticSuccess();
    default: result >= characterValue ? success() : fail();
  }
}

function success() {
  console.log('Your character succeeds.');
}

function fail() {
  console.log('Your character fails.');
}

function automaticSuccess() {
  console.log('Your character succeeds without effort. Glory!');
}

function automaticFail() {
  console.log('Meagre attempt. Your character fails miserably.');
}

// Example character.
const myCharacter = {
  name: 'Jenkins',
  strength: 4,
  constitution: 6,
  education: 11,
  luck: 3,
  sanity: 9,
};

// Example rolls:

// Jenkins wants to break in a door with brute force,
// so he has to roll against his strength value.
targetRoll(myCharacter.strength);

// Jenkins is challenged to a drinking contest.
// In order to determine how much he can take, he rolls against his
// constitution. Since he just ate a huge portion of pork roast, he
// gets a D4 bonus die.
targetRoll(myCharacter.constitution, {min: 0, max: 4});

// Jenkins found an ancient scroll and attempts to decipher it.
// He has to roll against his education, in order to determine
// whether he's able to read it.
targetRoll(myCharacter.education);
```

When playing around with the above program, our three test rolls result in three random values that produce the sample output below (because each dice roll produces a random value, your output may differ). The outcome of rolling 16 looks correct, but the output when we rolled values 1 and 20 doesn't make sense. For each roll, only *one* outcome should be displayed. What is wrong with the code?

```
--> 1
Meagre attempt. Your character fails miserably.
Your character succeeds without effort. Glory!
Your character fails.
--> 20
Your character succeeds without effort. Glory!
Your character succeeds.
--> 16
Your character succeeds.
```

### Solution

The issue is with the case statements on lines 38 and 39: they are missing their `break`, so evaluation "falls through": a `result` of `1` will execute the first case, fall through to the second (`case 20`), and then fall through to the `default`, executing all three. A `result` of `20` will execute its case, then fall through to the `default` case, executing both. This is fixed by adding `break`s at the end of the cases:

```javascript
function targetRoll(characterValue, bonus = {min: 0, max: 0}, penalty = {min: 0, max: 0}) {
  let result = toss(d20, bonus, penalty);
  // Normalize in case bonus or penalty push result out of the D20 range.
  result = Math.max(1, result);
  result = Math.min(20, result);

  console.log(`--> ${result}`);

  switch (result) {
    case 1:
      automaticFail();
      break;
    case 20:
      automaticSuccess();
      break;
    default: result >= characterValue ? success() : fail();
  }
}
```

---

## 9. Grade Analysis

Professor Graham wrote some simple code to help him determine the average and [median](https://en.wikipedia.org/wiki/Median) scores on each of his quarterly exams, but some of the test cases are failing. Figure out why, and write the code necessary for the program to work as expected.

```javascript
function average(nums) {
  const sum = nums.reduce((total, num) => total + num);

  return sum / nums.length;
}

function median(nums) {
  nums.sort();

  let median;
  const length = nums.length;
  if (length % 2 === 0) {
    median = average([nums[(length / 2) - 1], nums[length / 2]]);
  } else {
    median = nums[Math.floor(length / 2)];
  }

  return median;
}

// Tests

const quarter1ExamScores = [89, 72, 100, 93, 64, 97, 82, 87, 90, 94];
const quarter2ExamScores = [76, 91, 89, 90, 91, 67, 99, 82, 91, 87];
const quarter3ExamScores = [99, 91, 88, 72, 76, 64, 94, 79, 86, 88];
const quarter4ExamScores = [100, 94, 73, 88, 82, 91, 97, 99, 80, 84];

// should all log 'true':
console.log(average(quarter1ExamScores) === 86.8);
console.log(average(quarter2ExamScores) === 86.3);
console.log(average(quarter3ExamScores) === 83.7);
console.log(average(quarter4ExamScores) === 88.8);

console.log(median(quarter1ExamScores) === 89.5);
console.log(median(quarter2ExamScores) === 89.5);
console.log(median(quarter3ExamScores) === 87);
console.log(median(quarter4ExamScores) === 89.5);
```

### Solution

The problem is on line 8: no callback function is provided to `Array.prototype.sort()`, so it coerces the scores to strings and compares them lexicographically. The solution is to provide a callback function to `sort` that compares the scores numerically:

```javascript
function median(nums) {
  nums.sort((score1, score2) => score1 - score2);

  let median;
  const length = nums.length;
  if (length % 2 === 0) {
    median = average([nums[(length / 2) - 1], nums[length / 2]]);
  } else {
    median = nums[Math.floor(length / 2)];
  }

  return median;
}
```

---

## 10. Weekday Classes

There are a lot of exciting classes offered in our region. We wrote a small script that checks which ones are still upcoming and compatible with our calendar. We must be available to attend all sessions of a particular class in order to sign up for it. We can always arrange that on weekends, but for weekdays we have to check whether our calendar is free.

Although the code below runs, something is wrong with it. Why is everything except for the *Back To The Future Movie Night* in the list of compatible classes?

```javascript
const TODAY = toDate("2018-08-05");

function toDate(string) {
  return new Date(`${string}T00:00:00`);
}

function toString(date) {
  return `${date.getYear()}-${date.getMonth()}-${date.getDay()}`;
}

function isInThePast(date) {
  return date < TODAY;
}

function isWeekday(date) {
  return date.getDay() >= 1 &&
         date.getDay() <= 5;
}

const myCalendar = {
  "2018-08-13": ["JS debugging exercises"],
  "2018-08-14": ["Read 'Demystifying Rails'", "Settle health insurance"],
  "2018-08-15": ["Read 'Demystifying Rails'"],
  "2018-08-16": [],
  "2018-08-30": ["Drone video project plan"],
  "2018-09-10": ["Annual servicing of race bike"],
  "2018-09-12": ["Study"],
  "2018-11-02": ["Birthday Party"],
  "2018-11-03": ["Birthday Party"],
};

const offeredClasses = {
  "Back To The Future Movie Night": ["2018-07-30"],
  "Web Security Fundamentals": ["2018-09-10", "2018-09-11"],
  "Pranayama Yoga For Beginners": ["2018-08-30", "2018-08-31", "2018-09-01"],
  "Mike's Hikes": ["2018-08-16"],
  "Gordon Ramsey Master Class": ["2018-09-11", "2018-09-12"],
  "Powerboating 101": ["2018-09-15", "2018-09-16"],
  "Discover Parachuting": ["2018-11-02"],
};

function getCompatibleEvents(classes, calendar) {
  function isAvailable(date) {
    const dateStr = toString(date);
    return !calendar[dateStr] || calendar[dateStr].length === 0;
  };

  const compatibleClasses = [];

  Object.keys(classes).forEach(className => {
    const classDates = classes[className].map(toDate);

    if (classDates.some(isInThePast)) {
      return;
    }

    if (classDates.filter(isWeekday).every(isAvailable)) {
      compatibleClasses.push(className);
    }
  });

  return compatibleClasses;
}

console.log(getCompatibleEvents(offeredClasses, myCalendar));
// expected: ["Mike's Hikes", "Powerboating 101"]
```

### Solution

There are several problems:
* `toDate` function:
  * `getYear` should be `getFullYear`: `getYear` returns two digits prior to year 2000, or three digits for year 2000 or after. `getFullYear` returns four digit years that this code expects.
  * The month and date numbers need to be pre-padded with a 0 if they are only a single digit. The best way to do this is to write a new function to handle the padding.
  * `getMonth` returns an index: 0-11, not 1-12. It needs to be incremented by 1.
  * `getDay` should be `getDate`: `getDay` returns an index representing the day of the week (0-6). `getDate` returns the day of the month as expected.

```javascript
function pad(number, count = 2, char = '0') {
  number = String(number);
  while (number.length < count) {
    number = char + number;
  }

  return number;
}

function toString(date) {
  return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}`;
}
```

---

## 11. Pomodoro

The following code demonstrates the [Pomodoro technique](https://en.wikipedia.org/wiki/Pomodoro_Technique). Although it seems to work in principle, it never prints the minute count from line 11. What is wrong?

```javascript
var tasks = 10;
var checkmarks = 0;
var sessions = 0;
var minutes = 0;

function pomodoro() {
  console.log('Work.');

  while (minutes < 25) {
    minutes += 1;
    console.log('...' + minutes);
  }

  console.log('PLING!');

  sessions += 1;
  checkmarks += 1;

  if (checkmarks === tasks) {
    console.log('Done!');
    return;
  }

  var rest;
  if (sessions === 4) {
    sessions = 0;
    rest = 30;
  } else {
    rest = 5;
  }

  console.log('Rest for ' + rest + ' minutes.');

  var minutes = 0;
  pomodoro();
}

pomodoro();
```

### Solution

The problem is line 34: `var minutes = 0` declares a local function variable `minutes` which shadows the global variable `minutes` from line 4. Due to hoisting, the local function `minutes` is available at the top of the function scope before line 7, but it evaluates to `undefined` since it hasn't been initialized yet, and won't be initialized until line 34. In JavaScript, `undefined` compared to anything other than `undefined` or `null` returns false, so the `while` condition on line 9 never evaluates to `true` and the minute count is never printed.

To fix this issue, the `var` on line 34 needs to be removed: `minutes = 0;`.
