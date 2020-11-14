// Greatest Common Divisor
//
// Create a function that computes the Greatest Common Divisor of two positive integers.
// Example

// console.log(gcd(12, 4));   // 4
// console.log(gcd(15, 10));  // 5
// console.log(gcd(9, 2));    // 1

// function gcd(num1, num2) {
//   let lesserNum = (num1 > num2) ? num2 : num1;

//   console.log('lesser: ', lesserNum);

//   for (lesserNum; lesserNum >= 1; lesserNum -= 1) {
//     if (num1 % lesserNum === 0 && num2 % lesserNum === 0) return lesserNum;
//   }
// }

// // using Euclid's algorithm:
// function gcd(num1, num2) {
//   let lesserNum = (num1 < num2) ? num1 : num2;
//   let greaterNum = (lesserNum === num1) ? num2 : num1;

//   do {
//     let remainder = greaterNum % lesserNum;
//     greaterNum = lesserNum;
//     lesserNum = remainder;
//   } while (lesserNum !== 0);

//   return greaterNum;
// }

// Further Exploration 1
// The examples all put the larger number first. Do you think the program will still work if you reverse the order and place the smaller number first?

// Yes, but only because I assumed sorting the numbers was an implicit requirement and already implemented it. If I wasn't already sorting the numbers, my solutions would need adjustments before working with reversed order inputs.



// Further Exploration 2
// Our solution works with only two numbers. Can you expand it to accept an array of two or more numbers instead? Hint: the GCD is associative. To compute the GCD of 12, 4, and 8, for instance, you can compute:
//
// gcd(12, gcd(4, 8));  // 4
//
// You can also compute it with:
//
// gcd(gcd(12, 4), 8);  // 4

function euclidsGcd(num1, num2) {
  let lesserNum = (num1 < num2) ? num1 : num2;
  let greaterNum = (lesserNum === num1) ? num2 : num1;

  do {
    let remainder = greaterNum % lesserNum;
    greaterNum = lesserNum;
    lesserNum = remainder;
  } while (lesserNum !== 0);

  return greaterNum;
}

function gcd(numbers) {
  let currentGcd = euclidsGcd(numbers[0], numbers[1]);

  for (let index = 2; index < numbers.length; index += 1) {
    currentGcd = euclidsGcd(currentGcd, numbers[index]);
  }

  return currentGcd;
}

console.log(gcd([12, 4]));      // 4
console.log(gcd([15, 10]));     // 5
console.log(gcd([9, 2]));       // 1
console.log(gcd([12, 4, 8]));   // 4
