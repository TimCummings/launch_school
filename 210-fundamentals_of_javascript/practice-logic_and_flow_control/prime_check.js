// Prime Check
// 
// Write a function that takes a number argument, and returns true if the number is prime, or false if it is not.
// 
// You may assume that the input is always a non-negative integer.
// Example

console.log(isPrime(1));   // false
console.log(isPrime(2));   // true
console.log(isPrime(3));   // true
console.log(isPrime(43));  // true
console.log(isPrime(55));  // false
console.log(isPrime(0));   // false

// function isPrime(number) {
//   if (number <= 1) return false;

//   let halfOfNumber = Math.floor(number / 2);
//   for (let factor = 2; factor < halfOfNumber; factor += 1) {
//     if (number % factor === 0) return false;
//   }

//   return true;
// }

// Further Exploration
//
// If we use the fact that even numbers greater than 2 can't be prime (they're all divisible by 2), we can add this to the guard clause as well, and return immediately for even numbers greater than 2. This also means that we only need to test odd divisors; odd numbers are never divisible by even numbers.

function isPrime(number) {
  if (number <= 1 || (number > 2 && number % 2 === 0)) return false;

  let halfOfNumber = Math.floor(number / 2);
  for (let factor = 3; factor < halfOfNumber; factor += 2) {
    if (number % factor === 0) return false;
  }

  return true;
}
