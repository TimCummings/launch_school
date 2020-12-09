
# Practice Problems: Strings - 11/18/2002

1. Create a variable named `firstName` and set it equal to your first name. Set another variable named `lastName` to your last name. Join the two together, separated by a space, and store the result in a variable named `fullName`. Log the value of `fullName`.

### Solution

```javascript
let firstName = 'Timothy';
let lastName = 'Cummings';
let fullName = firstName + ' ' + lastName;
console.log(fullName);
```

---

2. Call `concat` on `firstName` using `lastName` as an argument. Log the return value.

### Solution

```javascript
console.log(firstName.concat(lastName));
```

---

3. Split the `fullName` variable into an array that contains the first and last names as separate strings. Log the value of the array.

### Solution

```javascript
console.log(fullName.split(' '));
```

---

4. Create a variable named `language` and set it equal to `'JavaScript'`. Find the index of the first occurrence of the letter `'S'` and save it to a variable named `idx` variable. Log the value of `idx`.

### Solution

```javascript
let language = 'JavaScript';
let idx = language.indexOf('S');
console.log(idx);
```

---

5. Call `charCodeAt` on the `language` variable with an argument of `idx`. Save the return value to a variable named `charCode`, then log the value of `charCode`.

### Solution

```javascript
let charCode = language.charCodeAt(idx);
console.log(charCode);
```

---

6. Log the return value of `String.fromCharCode` when you pass it `charCode` as an argument.

### Solution

```javascript
console.log(String.fromCharCode(charCode));
```

---

7. Find the index of the last occurrence of the letter `'a'` in the `language` variable and log the result.

### Solution

```javascript
console.log(language.lastIndexOf('a'));
```

---

8. Create two variables, `a = 'a'` and `b = 'b'`. Log a "greater than" comparison between the two variables. Reassign the value `'B'` to variable `b`, then compare the two variables again, and log the comparison value.

### Solution

```javascript
let a = 'a';
let b = 'b';
console.log(a > b);

b = 'B';
console.log(a > b);
```

---

9. Create variables `aIndex` and `vIndex` and store the index of the first occurrences of letters `'a'` and `'v'` in the `language` string. Call the `substr` method on `language` with `aIndex` as the first argument, and `4` as the second argument, e.g., `language.substr(aIndex, 4)`. Log the return value. Repeat the operation using `vIndex` as the first argument.

### Solution

```javascript
let aIndex = language.indexOf('a');
let vIndex = language.indexOf('v');

console.log(language.substr(aIndex, 4));
console.log(language.substr(vIndex, 4));
```

---

10. Repeat the previous problem, but this time use `substring` instead of `substr`. Note how the results differ because of the different ways these methods interpret the second argument:

### Solution

```javascript
let aIndex = language.indexOf('a');
let vIndex = language.indexOf('v');

console.log(language.substring(aIndex, 4));
console.log(language.substring(vIndex, 4));
```

---

11. Create variables named `fact1` and `fact2` and set them equal to `'JavaScript is fun'` and `'Kids like it too'`, respectively. Combine the values of the two variables with the string `' and '` between them, and store the result in a variable named `compoundSentence`. Make sure the first letter of `fact2` shows up as lowercase in `compoundSentence`. Log the value of `compoundSentence`.

### Solution

```javascript
let fact1 = 'JavaScript is fun';
let fact2 = 'Kids like it too';
let compoundSentence = fact1 + ' and ' + fact2.toLowerCase();

console.log(compoundSentence);
```

---

12. Log the first letter of `fact1` and `fact2` using bracket notation.

### Solution

```javascript
console.log(fact1[0]);
console.log(fact2[0]);
```

---

13. Create a variable named `pi` and set it to the result of `22 / 7`. Convert `pi` to a String using the `toString` method. Search the resulting string for the final occurrence of `'14'`, and log its index position.

### Solution

```javascript
let pi = 22 / 7;
console.log(pi.toString().lastIndexOf('14'));
```

---

14. Create a variable named `boxNumber` and set it to the result of calling `356.toString()`, and log the result. Before moving on, try to run your program.

### Solution

```javascript
let boxNumber = 356.toString();
console.log(boxNumber);   // SyntaxError: Invalid or unexpected token
```

One way to avoid this is to use two periods instead of one. Replace `356.toString()` with `356..toString()`, and try running it again.

### Solution

```javascript
let boxNumber = 356..toString();
console.log(boxNumber);   // 356
```

Some "linter" programs reject this usage, and instead suggest that you use parentheses. Update your program again: eliminate the second period, and place `356` in parentheses, then run the program again.

### Solution

```javascript
let boxNumber = (356).toString();
console.log(boxNumber);   // 356
```

---

15. Convert the `boxNumber` variable back to a number using `parseInt`. To make sure the result is a number, you can log `typeof boxNumber` to verify the type of the result. Now convert the number back to a `String` by using the String function and log the `typeof` of the result to verify it is now a String.

### Solution

```javascript
boxNumber = parseInt(boxNumber, 10);
console.log(typeof boxNumber);   // number

boxNumber = String(boxNumber);
console.log(typeof boxNumber);   // string
```

---

16. Write a program that asks for a user's name, then greets the user with that name. If the user appends a `!` to his name (e.g., `'Bill!'`), the computer should "yell" its greeting: that is, it should log everything to the console in uppercase. You can check whether the name ends with a `!` using `String.prototype.endsWith` (ES6 only). You can remove the `!` from the user's name with `String.prototype.slice`.

Examples

```
What is your name? Bob
Hello Bob.                                   // console output

What is your name? Bob!
HELLO BOB. WHY ARE WE SCREAMING?             // console output
```

### Solution

```javascript
const rlSync = require('readline-sync');

let name = rlSync.question('What is your name? ');
let message;

if (name.endsWith('!')) {
  name = name.slice(0, -1);
  message = `HELLO ${name.toUpperCase()}. WHY ARE WE SCREAMING?`;
} else {
  message = `Hello ${name}.`
}

console.log(message);
```
