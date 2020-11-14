
# JavaScript Language Fundamentals - Debugging - 11/9/2020

Study the provided code to see if you can spot the hidden bugs and implement a fix. You should complete all of JS210 before attempting these exercises.

1. Hello Friends!

You have written basic functions to display a random greeting to any number of friends upon each invocation of `greet`. Upon invoking the `greet` function, however, the output is not as expected. Figure out why not and fix the code.

```javascript
function randomGreeting() {
  const words = ['Hello', 'Howdy', 'Hi', 'Hey there', 'What\'s up',
               'Greetings', 'Salutations', 'Good to see you'];

  const idx = Math.floor(Math.random() * words.length);

  words[idx];
}

function greet(...args) {
  const names = Array.prototype.slice.call(args);

  for (let i = 0; i < names.length; i++) {
    const name = names[i];
    const greeting = randomGreeting;

    console.log(`${greeting}, ${name}!`);
  }
}

greet('Hannah', 'Jose', 'Beatrix', 'Julie', 'Ian');
```

### Solution

The issues are that the `randomGreeting` method does not return anything and will consequently always resolve to `undefined` when invoked; this can be fixed by changing line 7 to `return words[idx];`. Also, the `randomGreeting` function is never invoked. The `greet` function on line 15 assigns the `randomGreeting` function to the `greeting` variable, but it does not invoke it because the parentheses have been omitted; this can be fixed by changing line 15 to `const greeting = randomGreeting();`.

```javascript
function randomGreeting() {
  const words = ['Hello', 'Howdy', 'Hi', 'Hey there', 'What\'s up',
    'Greetings', 'Salutations', 'Good to see you'];

  const idx = Math.floor(Math.random() * words.length);

  return words[idx];
}

function greet(...args) {
  const names = Array.prototype.slice.call(args);

  for (let index = 0; index < names.length; index += 1) {
    const name = names[index];
    const greeting = randomGreeting();

    console.log(`${greeting}, ${name}!`);
  }
}

greet('Hannah', 'Jose', 'Beatrix', 'Julie', 'Ian');
```

---

2. Includes False

Caroline has written a very simple function, `includesFalse`, that searches a list of primitives for the boolean `false`. If `false` is found, the function immediately returns `true`. If no occurrence of `false` has been found after iterating through the entire array, the function returns `false`.

Caroline's last method invocation of `includesFalse` (line 15) doesn't return what she expects. Why is that? Fix the code so that it behaves as intended.

```javascript
function includesFalse(list) {
  for (let i = 0; i < list.length; i++) {
    let element = list[i];

    if (element == false) {
      return true;
    }
  }

  return false;
}
                                                                  // returns:
includesFalse([8, null, 'abc', true, 'launch', 11, false]);       // true
includesFalse(['programming', undefined, 37, 64, true, 'false']); // false
includesFalse([9422, 'lambda', true, 0, '54', null]);             // true
```

### Solution

This code produces unexpected results because it uses the non-strict equality operator `==` to compare values. The non-strict equality operator will silently coerce its operands to different types if they aren't the same type; these silent coercions lead to the unexpected results, specifically `0 == false` returns `true`.

```javascript
function includesFalse(list) {
  for (let index = 0; index < list.length; index += 1) {
    let element = list[index];

    if (element === false) {
      return true;
    }
  }

  return false;
}
                                                                  // returns:
console.log(includesFalse([8, null, 'abc', true, 'launch', 11, false]));       // true
console.log(includesFalse(['programming', undefined, 37, 64, true, 'false'])); // false
console.log(includesFalse([9422, 'lambda', true, 0, '54', null]));             // false
```

---

3. Place A Bet

The function `placeABet` below accepts a guess from the user between 1 and 25. The function should determine a winning number and return a message to the user indicating whether he/she entered a winning guess. When you try to invoke `placeABet`, an error is raised. Fix the bug and explain what caused it.

```javascript
function placeABet(guess) {
  (function generateRandomInt() {
    return Math.floor(Math.random() * 25) + 1;
  });

  const winningNumber = generateRandomInt();

  if (guess < 1 || guess > 25) {
    return 'Invalid guess. Valid guesses are between 1 and 25.';
  }

  if (guess === winningNumber) {
    return "Congratulations, you win!";
  } else {
    return "Wrong-o! You lose.";
  }
}

const userGuess = parseInt(prompt('Input a guess between 1-25'), 10);
alert(placeABet(userGuess));
```

### Solution

This code raises a `ReferenceError` because the `generateRandomInt` function is not defined. Lines 2-3 are an anonymous function expression that isn't assigned to a variable so there is no way to call that function. This can be fixed by either assigning the function expression to a variable or changing it to a function declaration by removing the parentheses and semicolon:

```javascript
function placeABet(guess) {
  function generateRandomInt() {
    return Math.floor(Math.random() * 25) + 1;
  }

  const winningNumber = generateRandomInt();

  if (guess < 1 || guess > 25) {
    return 'Invalid guess. Valid guesses are between 1 and 25.';
  }

  if (guess === winningNumber) {
    return "Congratulations, you win!";
  } else {
    return "Wrong-o! You lose.";
  }
}

const userGuess = parseInt(prompt('Input a guess between 1-25'), 10);
alert(placeABet(userGuess));
```

---

4. Picky Museum Filter

We love to visit museums if they are about science or computers. We're undecided when it comes to modern art, and would rather not go in most cases. However, we're willing to go to any modern art museum that is about Andy Warhol (we like him!) or that is located in nearby Amsterdam. We'd rather skip any other museums.

We tried to implement these preferences in a function, so we can automatically sort through long lists of museums and find the ones that sound interesting. However, our Boolean check is flawed, as it fails some of our test cases. Can you fix it?

```javascript
function wantToVisit(museum, city) {
  return museum.includes('Computer')
      || museum.includes('Science')
      && !(
        museum.includes('Modern')
        && museum.includes('Art')
        && museum.includes('Andy Warhol')
        || city === 'Amsterdam'
      );
}

// Tests (should all print 'true')

console.log(wantToVisit('Computer Games Museum', 'Berlin') === true);
console.log(wantToVisit('National Museum of Nature and Science', 'Tokyo') === true);
console.log(wantToVisit('Museum of Modern Art', 'New York') === false);
console.log(wantToVisit('El Paso Museum of Archaeology', 'El Paso') === false);
console.log(wantToVisit('NEMO Science Museum', 'Amsterdam') === true);
console.log(wantToVisit('National Museum of Modern Art', 'Paris') === false);
console.log(wantToVisit('Andy Warhol Museum of Modern Art', 'Medzilaborce') === true);
console.log(wantToVisit('Moco: Modern Contemporary Art', 'Amsterdam') === true);
console.log(wantToVisit('Van Gogh Museum', 'Amsterdam') === false);
console.log(wantToVisit('Andy Warhol Museum', 'Melbourne') === false);
```

### Solution

There are too many logical operators being used without parentheses; the logic in the function does not match the problem description due to operator precedence and an unnecessary NOT: `&&` takes higher precedence than `||`, so the provided code is effectively this:

```javascript
  return museum.includes('Computer')
      || (
        museum.includes('Science')
        && !(
          (
            museum.includes('Modern')
            && museum.includes('Art')
            && museum.includes('Andy Warhol')
          )
          || city === 'Amsterdam'
        )
      );
```

Verbally, this logic looks for museums that meet at least one of the following sets of criteria:

* are about computers
* are about science and are not about (modern and art and Andy Warhol)
* are about science and are not in Amsterdam

To correct this, we at least need to refactor the logic and add parentheses to properly handle operator precedence, however using if statements might be easier to follow:

```javascript
function wantToVisit(museum, city) {
  if (museum.includes('Computer') || museum.includes('Science')) return true;

  if (museum.includes('Modern') && museum.includes('Art')) {
    if (museum.includes('Andy Warhol') || city === 'Amsterdam') return true;
  }

  return false;
}
```

---

5. Shop Transactions

Todd wrote some simple code in an attempt to log his shop's financial transactions. Each time he makes a sale or spends money on inventory, he logs that deposit or withdrawal via the `logTransaction` function. His code also intends to ensure that each transaction logged is a valid numerical amount. At the end of each day, he displays his total gain or loss for the day with `transactionTotal`.

Test out the code yourself. Can you spot the problem and fix it?

```javascript
const transactionLog = [];

function processInput(input) {
  const numericalData = parseFloat(input);

  if (Number.isNaN(numericalData)) {
    throw (new Error('Data could not be converted to numerical amount.'));
  }

  return numericalData;
}

function logTransaction() {
  let data = prompt('Please enter the transaction amount: ');

  try {
    data = processInput(data);
    transactionLog.push(data);

    alert('Thank you. Data accepted.');
  } catch {
    alert(error.message);
  }
}

function transactionTotal() {
  let total = 0;

  for (let i = 0; i < transactionLog.length; i++) {
    total += transactionLog[i];
  }

  return total;
}

logTransaction();
logTransaction();
logTransaction();

console.log(transactionTotal());
```

### Solution

This code throws an exception when the user enters invalid input instead of catching the error and logging an appropriate message. The reason for this is that the `catch` clause does not have a paramater, causing the `error` variable to not be defined when a user enters invalid input. This can be fixed with:

```javascript
function logTransaction() {
  let data = prompt('Please enter the transaction amount: ');

  try {
    data = processInput(data);
    transactionLog.push(data);

    alert('Thank you. Data accepted.');
  } catch (error) {
    alert(error.message);
  }
}
```

---

6. Full Moon

Run the following code. Why is every warning displayed twice? Change the code so that each warning is displayed only once, as intended.

```javascript
const species = ['wolf', 'human', 'wasp', 'squirrel', 'weasel', 'dinosaur'];
const isMidnight = true;
const isFullmoon = true;

function isTransformable(species) {
  return species[0] === 'w';
}

function transform(species) {
  return `were${species}`;
}

for (let i = 0; i < species.length; i++) {
  const thisSpecies = species[i];
  var newSpecies;

  if (isMidnight && isFullmoon && isTransformable(thisSpecies)) {
      newSpecies = transform(thisSpecies);
  }

  if (newSpecies) {
    console.log(`Beware of the ${newSpecies}!`);
  }
}
```

### Solution

This is a subtle error! We are lucky that it caused such an obvious issue by duplicating each warning - with different input, this bug could go undetected for quite a while. The issue is that the variable `newSpecies` is declared with `var`, giving it function scope, not block scope. Our input happens to be staggered such that every other species starting with the first is transformable, and every other species starting with the second is not transformable. Because the `newSpecies` variable has function scope, it continues to persist after the end of each iteration of the for loop, retaining the value from the iteration that just terminated. Consequently, each iteration of a non-transformable species where we expect `newSpecies` to evaluate to undefined, it actually still retains the transformed name of the previous transformable species, which is a truthy value and leads to the previous transformed name being logged again. This can be fixed by declaring `newSpecies` with `let` so it's block scoped and stays local to the for loop each iteration instead of persisting through it:

```javascript
const species = ['wolf', 'human', 'wasp', 'squirrel', 'weasel', 'dinosaur'];
const isMidnight = true;
const isFullmoon = true;

function isTransformable(species) {
  return species[0] === 'w';
}

function transform(species) {
  return `were${species}`;
}

for (let i = 0; i < species.length; i++) {
  const thisSpecies = species[i];
  let newSpecies;

  if (isMidnight && isFullmoon && isTransformable(thisSpecies)) {
      newSpecies = transform(thisSpecies);
  }

  if (newSpecies) {
    console.log(`Beware of the ${newSpecies}!`);
  }
}
```

---

7. Space Design

We're putting together some information about our new company *Space Design*. Not all roles have been filled yet. But although we have a CEO and Scrum Master, displaying them shows `undefined`. Why is that?

```javascript
// Roles (salary still to be determined)

const ceo = {
  tasks: ['company strategy', 'resource allocation', 'performance monitoring'],
  salary: 0,
};

const developer = {
  tasks: ['turn product vision into code'],
  salary: 0,
};

const scrumMaster = {
  tasks: ['organize scrum process', 'manage scrum teams'],
  salary: 0,
};

// Team -- we're hiring!

const team = {};

team[ceo] = 'Kim';
team[scrumMaster] = 'Alice';
team[developer] = undefined;

const company = {
  name: 'Space Design',
  team,
  projectedRevenue: 500000,
};

console.log(`----{ ${company.name} }----`);
console.log(`CEO: ${company.team[ceo]}`);
console.log(`Scrum master: ${company.team[scrumMaster]}`);
console.log(`Projected revenue: $${company.projectedRevenue}`);

// ----{ Space Design }----
// CEO: undefined
// Scrum master: undefined
// Projected revenue: $500000
```

> Hint: Log the `team` object to the console after line 24.
>
### Solution

Object keys (property names) are *strings*. Attempting to use an object as a key for another object will result in the key's value being the object coerced to a a string: `"[object Object]"`. On lines 22-24, instead of setting three different properties on the `team` object, we are reassigning the `"[object Object]"` property three times, with its final value being `undefined` on line 24, which explains our unexpected output. Instead, the keys need to be strings and they need to be accessed from the `company` object either with dot notation or with string literals so the variables (`ceo, developer, scrumMaster`) aren't used:

```javascript
// Roles (salary still to be determined)

const ceo = {
  tasks: ['company strategy', 'resource allocation', 'performance monitoring'],
  salary: 0,
};

const developer = {
  tasks: ['turn product vision into code'],
  salary: 0,
};

const scrumMaster = {
  tasks: ['organize scrum process', 'manage scrum teams'],
  salary: 0,
};

// Team -- we're hiring!

const team = {};

team['ceo'] = 'Kim';
team['scrumMaster'] = 'Alice';
team['developer'] = undefined;

const company = {
  name: 'Space Design',
  team,
  projectedRevenue: 500000,
};

console.log(`----{ ${company.name} }----`);
console.log(`CEO: ${company.team.ceo}`);
console.log(`Scrum master: ${company.team.scrumMaster}`);
console.log(`Projected revenue: $${company.projectedRevenue}`);
```

---

8. Expensive Study Preparation

We make a few purchases to prepare for our study session, but the amount charged upon checkout seems too high. Run the following code and find out why we are charged incorrectly.

```javascript
// The shopping cart is a list of items, where each item
// is an object { name: <string>, amount: <number> }.
let shoppingCart = [];

// Currently available products with prices.
const prices = {
  'notebook': 9.99,
  'pencil': 1.70,
  'coffee': 3.00,
  'smoothie': 2.10,
};

function price({name}) {
  return prices[name];
}

// Adding an item to the shopping cart.
// The amount is optional and defaults to 1.
// If the item is already in the cart, its amount is updated.
function updateCart(name, amount) {
  amount = amount || 1;

  let alreadyInCart = false;

  for (let i = 0; i < shoppingCart.length; i += 1) {
    let item = shoppingCart[i];

    if (item.name === name) {
      item.amount = amount;
      alreadyInCart = true;
      break;
    }
  }

  if (!alreadyInCart) {
    shoppingCart.push({ name, amount });
  }
}

// Calculating the price for the whole shopping cart.
function total() {
  let total = 0;

  for (let i = 0; i < shoppingCart.length; i += 1) {
    let item = shoppingCart[i];

    total += (item.amount * price(item));
  }

  return total.toFixed(2);
}

function pay() {
  // omitted

  console.log(`You have been charged $${total()}.`);
}

function checkout() {
  pay();
  shoppingCart = {};
}

// Example purchase.

updateCart('notebook');
updateCart('pencil', 2);
updateCart('coffee', 1);
// "Oh, wait, I do have pencils..."
updateCart('pencil', 0);

checkout();
// You have been charged $14.69.
```

### Solution

The `updateCart` function does not allow us to completely remove an item from the cart, only set it's quantity down to 1. This is due to line 21: an `amount` of `0` will be implicitly coerced to `false`, causing `amount` to be reassigned `1` instead of `0`. To fix this, instead of using `||` with a potential `0` value, we can compare `amount` directly to `undefined` (`if (amount === undefined) amount = 1;`) or use a default parameter in the function definition:

```javascript
// Adding an item to the shopping cart.
// The amount is optional and defaults to 1.
// If the item is already in the cart, its amount is updated.
function updateCart(name, amount = 1) {
  let alreadyInCart = false;

  for (let i = 0; i < shoppingCart.length; i += 1) {
    let item = shoppingCart[i];

    if (item.name === name) {
      item.amount = amount;
      alreadyInCart = true;
      break;
    }
  }

  if (!alreadyInCart) {
    shoppingCart.push({ name, amount });
  }
}
```

---

9. Stuck on Page 18

The following code is a simplified (and not so serious) model of how we read a software development book. But running this code results in a stack overflow. What is wrong?

```javascript
const totalPages = 364;
let energy = 100;

function read() {
  let currentPage = 1;

  while (energy > 0 && currentPage < totalPages) {
    currentPage += 1;
    energy -= (5 + currentPage * 0.1);
  }

  console.log(`Made it to page ${String(currentPage)}.`);

  // Drink a cup of coffee.
  energy = 100;

  // Continue reading.
  if (currentPage < totalPages) {
    read();
  } else {
    console.log('Done!');
  }
}

read();
```

### Solution

The `read` function recursively calls itself, but it's terminating condition, `currentPage` not being less than `totalPages` is never met, because `currentPage` is local to the `read` function and starts with a value of `1` each time `read` is invoked. The declaration and intializing of `currentPage` needs to be moved outside of the `read` function:

```javascript
const totalPages = 364;
let energy = 100;
let currentPage = 1;

function read() {
  while (energy > 0 && currentPage < totalPages) {
    currentPage += 1;
    energy -= (5 + currentPage * 0.1);
  }

  console.log(`Made it to page ${String(currentPage)}.`);

  // Drink a cup of coffee.
  energy = 100;

  // Continue reading.
  if (currentPage < totalPages) {
    read();
  } else {
    console.log('Done!');
  }
}

```
