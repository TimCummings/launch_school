
# Practice Problems - Variables and Numbers - 10/21/2020

Throughout these practice problems, we will tell you to "log the result." Use console.log to do this: it logs a value to the browser's console.

1. Declare a variable named `numerator` and set it to 10.

### Solution

`let numerator = 10;`

---

2. Declare a constant named `DENOMINATOR` and set it to 2.

### Solution

`const DENOMINATOR = 2;`

---

3. Declare a variable named `answer` and set it to the result of `numerator` divided by `DENOMINATOR`. Log the value of `answer` (it should be 5).

### Solution

```javascript
let answer = numerator / DENOMINATOR;
console.log(answer);
```

---

4. Declare a variable named `incrementer` and set it to 1.

### Solution

`let incrementer = 1;`

---

5. Declare a variable named `start` and set it to `incrementer`.

### Solution

`let start = incrementer;`

---

6. Declare variables named `end` and `difference`. Leave them undefined.

### Solution

```javascript
let end;
let difference;
```

---

7. In JavaScript, we can use a shorthand operator to add or subtract values to and from a variable. If we want to add one to our incrementer variable, we can write `incrementer = incrementer + 1`. However, JavaScript lets us shorten this with the self-addition operator, `+=`, e.g., `incrementer += 1`. (All we did was remove the second instance of `incrementer`, and then recombined the `=` and `+` as `+=`.) Analogous arithmetic assignment operators are available for the other basic arithmetic operations: subtraction, multiplication, and division.

Increment the `incrementer` variable by 1 three times using the self-addition notation.

### Solution

```javascript
incrementer += 1;
incrementer += 1;
incrementer += 1;
```

---

8. There's an even shorter way to increment and decrement a variable by one: the increment and decrement operators. To increment a variable by one, we write the variable name immediately followed by two plus signs, e.g., `incrementer++`. We call this the postfix increment operator since it comes after the variable name.

Increment the `incrementer` variable by 1 twice using the increment operator shorthand.

### Solution

```javascript
incrementer++;
incrementer++;
```

---

9. Set the value of `end` to `incrementer` and the value of `difference` to `end` minus `start`. Log the value of `end`, which should be 6. Log the value of `difference`, which should be 5.

### Solution

```javascript
end = incrementer;
difference = end - start;

console.log(end);
console.log(difference);
```

---

10. Declare a variable named `answer` and initialize it to the result of 11 plus 31 multiplied by 3 as one statement, then log the result. Your result should be 126. If you get a different result, you may need to use some parentheses to change the order of operations: you want to perform the addition first, then the multiplication.

### Solution

```javascript
let answer = (11 + 31) * 3;
console.log(answer);
```
