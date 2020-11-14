// Multiples of 3 and 5
// 
// Write a function that logs the integers from 1 to 100 (inclusive) that are multiples of either 3 or 5. If the number is divisible by both 3 and 5, append an "!" to the number.
// Example
// 
// multiplesOfThreeAndFive();
// 
// // output on console
// '3'
// '5'
// '6'
// '9'
// '10'
// '12'
// '15!'
// // … remainder of output omitted for brevity

// function multiplesOfThreeAndFive() {
//   for(let number = 1; number <= 100; number += 1) {
//     if (number % 3 === 0 && number % 5 === 0) {
//       console.log(String(number) + '!');
//     } else if (number % 3 === 0 || number % 5 === 0) {
//       console.log(String(number));
//     }
//   }
// }

// multiplesOfThreeAndFive();

// Further Exploration
// For additional practice, how would you change your function so it takes, as arguments, the range of numbers it should check?

function multiplesOfThreeAndFive(lowerBound, upperBound) {
  for(let number = lowerBound; number <= upperBound; number += 1) {
    if (number % 3 === 0 && number % 5 === 0) {
      console.log(String(number) + '!');
    } else if (number % 3 === 0 || number % 5 === 0) {
      console.log(String(number));
    }
  }
}

multiplesOfThreeAndFive(6, 35);
