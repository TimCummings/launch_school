
# JS210/215 Small Problems: List Processing - 11/17/2020

## 1. Sum of Digits

Write a function that takes one argument, a positive integer, and returns the sum of its digits. Do this without using `for`, `while`, or `do...while` loops - instead, use a series of method calls to perform the sum.

Examples:

```javascript
sum(23);           // 5
sum(496);          // 19
sum(123456789);    // 45
```

### Solution

```javascript
let sum = function sum(number) {
  let stringDigits = number.toString().split('');
  return stringDigits.reduce((sum, stringDigit) => {
    return sum + parseInt(stringDigit, 10);
  }, 0);
};
```

---

## 2. Alphabetical Numbers

Write a function that takes an array of integers between `0` and `19`, and returns an array of those integers sorted based on the English word for each number:

> zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen

Example:

```javascript
alphabeticNumberSort(
   [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]);
// [8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17, 6, 16, 10, 13, 3, 12, 2, 0]
```

### Solution

```javascript
const alphabeticNumbers = [ 'zero', 'one', 'two', 'three', 'four', 'five',
  'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen',
  'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen',
  'twenty'];

let alphabeticNumberSort = function alphabeticNumberSort(numbers) {
  let numbersCopy = numbers.slice();
  return numbersCopy.sort((number1, number2) => {
    if (alphabeticNumbers[number1] < alphabeticNumbers[number2]) {
      return -1;
    } else if (alphabeticNumbers[number1] > alphabeticNumbers[number2]) {
      return 1;
    } else {
      return 0;
    }
  });
};
```

---

## 3. Multiply All Pairs

Write a function that takes two array arguments, each containing a list of numbers, and returns a new array containing the products of all combinations of number pairs that exist between the two arrays. The returned array should be sorted in ascending numerical order.

You may assume that neither argument will be an empty array.

Example:

```javascript
multiplyAllPairs([2, 4], [4, 3, 1, 2]);    // [2, 4, 4, 6, 8, 8, 12, 16]
```

### Solution

```javascript
let multiplyAllPairs = function multiplyAllPairs(numbers1, numbers2) {
  let result = [];

  numbers1.forEach(number1 => {
    numbers2.forEach(number2 => result.push(number1 * number2));
  });

  return result.sort((num1, num2) => num1 > num2);
};
```

#### Adjustments based on provided solution

For `sort`'s callback, use subtraction instead of less-than/greater-than, since it expects a return value of `-1`, `0`, or `1`:

```javascript
let multiplyAllPairs = function multiplyAllPairs(numbers1, numbers2) {
  let result = [];

  numbers1.forEach(number1 => {
    numbers2.forEach(number2 => result.push(number1 - number2));
  });

  return result.sort((num1, num2) => num1 > num2);
};
```

---

## 4. Sum of Sums

Write a function that takes an array of numbers, and returns the sum of the sums of each leading subsequence for that array. You may assume that the array always contains at least one number.

Examples:

```javascript
sumOfSums([3, 5, 2]);        // (3) + (3 + 5) + (3 + 5 + 2) --> 21
sumOfSums([1, 5, 7, 3]);     // (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) --> 36
sumOfSums([4]);              // 4
sumOfSums([1, 2, 3, 4, 5]);  // 35
```

### Solution

```javascript
let sumOfSums = function sumOfSums(numbers) {
  let sums = numbers.map((number, index) => {
    return numbers.slice(0, index + 1).reduce((sum, number) => sum + number, 0);
  });

  return sums.reduce((result, sum) => result + sum);
};
```

---

## 5. Leading Substrings

Write a function that takes a string argument, and returns a list of all substrings that start from the beginning of the string, ordered from shortest to longest.

Examples:

```javascript
leadingSubstrings('abc');      // ["a", "ab", "abc"]
leadingSubstrings('a');        // ["a"]
leadingSubstrings('xyzzy');    // ["x", "xy", "xyz", "xyzz", "xyzzy"]
```

### Solution

```javascript
let leadingSubstrings = function leadingSubstrings(string) {
  let substrings = [];
  for (let index = 0; index < string.length; index += 1) {
    substrings.push(string.substring(0, index + 1));
  }

  return substrings;
};
```

#### Further Exploration

Rewrite `leadingSubstrings` using list processing functions. That is, convert the string into an array of some sort and use functions like `map`, `filter`, or `reduce` to get the desired substrings. (You will also need to use `join`.) Try not to use `forEach` as that is too similar to the for loop approach.

```javascript
let leadingSubstrings = function leadingSubstrings(string) {
  let letters = string.split('');

  return letters.map((_letter, index) => {
    let subLetters = letters.slice(0, index + 1);
    return subLetters.reduce((substring, letter) => substring + letter);
  });
};
```

---

## 6. All Substrings

Write a function that returns a list of all substrings of a string. Order the returned list by where in the string the substring begins. This means that all substrings that start at position `0` should come first, then all substrings that start at position `1`, and so on. Since multiple substrings will occur at each position, return the substrings at a given position from shortest to longest.

You may (and should) use the `leadingSubstrings` function you wrote in the previous exercise.

Example:

```javascript
substrings('abcde');

// returns
[ "a", "ab", "abc", "abcd", "abcde",
  "b", "bc", "bcd", "bcde",
  "c", "cd", "cde",
  "d", "de",
  "e" ]
```

### Solution

```javascript
let substrings = function substrings(string) {
  return string.split('')
    .map((_char, index) => leadingSubstrings(string.slice(index)))
    .reduce((sub1, sub2) => sub1.concat(sub2));
};
```

---

## 7. Palindromic Substrings

Write a function that returns a list of all substrings of a string that are palindromic. That is, each substring must consist of the same sequence of characters forwards as backwards. The substrings in the returned list should be sorted by their order of appearance in the input string. Duplicate substrings should be included multiple times.

You may (and should) use the `substrings` function you wrote in the previous exercise.

For the purpose of this exercise, you should consider all characters and pay attention to case; that is, `'AbcbA'` is a palindrome, but `'Abcba'` and `'Abc-bA'` are not. In addition, assume that single characters are not palindromes.

Examples:

```javascript
palindromes('abcd');       // []
palindromes('madam');      // [ "madam", "ada" ]

palindromes('hello-madam-did-madam-goodbye');
// returns
[ "ll", "-madam-", "-madam-did-madam-", "madam", "madam-did-madam", "ada",
  "adam-did-mada", "dam-did-mad", "am-did-ma", "m-did-m", "-did-", "did",
  "-madam-", "madam", "ada", "oo" ]

palindromes('knitting cassettes');
// returns
[ "nittin", "itti", "tt", "ss", "settes", "ette", "tt" ]
```

### Solution

```javascript
let isPalindrome = function isPalindrome(string) {
  if (string.length <= 1) return false;
  return string === string.split('').reverse().join('');
};

let palindromes = function palindromes(string) {
  return substrings(string).filter(isPalindrome);
};
```

---

## 8. Grocery List

Write a function that takes a grocery list (a two-dimensional array) with each element containing a fruit and a quantity, and returns a one-dimensional array of fruits, in which each fruit appears a number of times equal to its quantity.

Example:

```javascript
buyFruit([['apple', 3], ['orange', 1], ['banana', 2]]);
// returns ["apple", "apple", "apple", "orange", "banana", "banana"]
```

### Solution

```javascript
let buyFruit = function buyFruit(list) {
  let result = [];
  list.forEach(element => {
    for (let counter = 1; counter <= element[1]; counter += 1) {
      result.push(element[0]);
    }
  });

  return result;
};
```

---

## 9. Inventory Item Transactions

Write a function that takes two arguments, `inventoryItem` and `transactions`, and returns an array containing only the transactions for the specified `inventoryItem`.

Example

```javascript
const transactions = [ { id: 101, movement: 'in',  quantity:  5 },
                       { id: 105, movement: 'in',  quantity: 10 },
                       { id: 102, movement: 'out', quantity: 17 },
                       { id: 101, movement: 'in',  quantity: 12 },
                       { id: 103, movement: 'out', quantity: 15 },
                       { id: 102, movement: 'out', quantity: 15 },
                       { id: 105, movement: 'in',  quantity: 25 },
                       { id: 101, movement: 'out', quantity: 18 },
                       { id: 102, movement: 'in',  quantity: 22 },
                       { id: 103, movement: 'out', quantity: 15 }, ];

console.log(transactionsFor(101, transactions));
// returns
// [ { id: 101, movement: "in",  quantity:  5 },
//   { id: 101, movement: "in",  quantity: 12 },
//   { id: 101, movement: "out", quantity: 18 }, ]
```

### Solution

```javascript
let transactionsFor = function transactionsFor(inventoryItem, transactions) {
  return transactions.filter(transaction => transaction.id === inventoryItem);
};
```

---

## 10. Inventory Item Availability

Building on the previous exercise, write a function that returns `true` or `false` based on whether or not an inventory `item` is available. As before, the function takes two arguments: an inventory `item` and a list of `transactions`. The function should return `true` only if the sum of the `quantity` values of the `item`'s transactions is greater than zero. Notice that there is a `movement` property in each transaction object. A `movement` value of `'out'` will decrease the `item`'s `quantity`.

You may (and should) use the `transactionsFor` function from the previous exercise.

Examples:

```javascript
const transactions = [ { id: 101, movement: 'in',  quantity:  5 },
                       { id: 105, movement: 'in',  quantity: 10 },
                       { id: 102, movement: 'out', quantity: 17 },
                       { id: 101, movement: 'in',  quantity: 12 },
                       { id: 103, movement: 'out', quantity: 15 },
                       { id: 102, movement: 'out', quantity: 15 },
                       { id: 105, movement: 'in',  quantity: 25 },
                       { id: 101, movement: 'out', quantity: 18 },
                       { id: 102, movement: 'in',  quantity: 22 },
                       { id: 103, movement: 'out', quantity: 15 }, ];

isItemAvailable(101, transactions);     // false
isItemAvailable(105, transactions);     // true
```

### Solution

```javascript
let isItemAvailable = function isItemAvailable(item, transactions) {
  let itemTransactions = transactionsFor(item, transactions);

  let remaining = itemTransactions.reduce((sum, transaction) => {
    if (transaction.movement === 'in') {
      return sum + transaction.quantity;
    } else {
      return sum - transaction.quantity;
    }
  }, 0);

  return remaining > 0;
};```
