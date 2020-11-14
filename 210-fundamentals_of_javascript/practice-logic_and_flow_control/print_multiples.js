// Print Multiples
// 
// Write a function logMultiples that takes one argument number. It should log all multiples of the argument between 0 and 100 (inclusive) that are also odd numbers. Log the values in descending order.
// 
// You may assume that number is an integer between 0 and 100.
// Example
// 
// logMultiples(17);
// // output (5x, 3x and 1x)
// 85
// 51
// 17
// 
// logMultiples(21);
// // output (3x and 1x)
// 63
// 21

// function logMultiples(number) {
//   let multiples = [];

//   for(let factor = 1; factor * number <= 100; factor += 2) {
//     let multiple = number * factor;
//     if (multiple % 2 === 1) multiples.push(multiple);
//   }

//   while (multiples.length > 0) {
//     console.log(multiples.pop());
//   }
// }

logMultiples(17);
logMultiples(21);

// Further Exploration
//
// This solution must step through every number between 100 and 0. Alternatively, you can determine the number's largest multiple that is less than 100, then start the loop with that multiple. With each iteration of the loop, you can decrement the number by the argument; when the result is negative, you can quit.
//
// As above, we must check each multiple to determine whether it is odd. If it is odd, we log it.
//
// Math.floor(100 / number) * number returns the largest multiple of number that is between 0 and 100.

function largestMultipleUnder100(number) {
  return Math.floor(100 / number) * number;
}

function logMultiples(number) {
  let current = largestMultipleUnder100(number);
  for (current; current >= number; current -= number) {
    if (current % number === 0 && current % 2 === 1) console.log(current);
  }
}
