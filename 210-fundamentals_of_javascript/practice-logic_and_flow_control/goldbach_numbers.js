// Goldbach Numbers
//
// Write a function named checkGoldbach that uses [Goldbach's Conjecture](https://en.wikipedia.org/wiki/Goldbach%27s_conjecture) to log every pair of primes that sum to the number supplied as an argument. The conjecture states that "you can express every even integer greater than 2 as the sum of two primes". The function takes as its only parameter, an integer expectedSum, and logs all combinations of two prime numbers whose sum is expectedSum. Log the prime pairs with the smaller number first. If expectedSum is odd or less than 4, your function should log null.
//
// Your checkGoldbach function may call the isPrime function you wrote for a previous practice problem.
// Example

checkGoldbach(3); // logs: null

checkGoldbach(4);
// logs: 2 2

checkGoldbach(12);
// logs: 5 7

checkGoldbach(100);
// logs:
// 3 97
// 11 89
// 17 83
// 29 71
// 41 59
// 47 53


// our function from a previous exercise:
function isPrime(number) {
  if (number <= 1 || (number > 2 && number % 2 === 0)) return false;

  let halfOfNumber = Math.floor(number / 2);
  for (let factor = 3; factor < halfOfNumber; factor += 2) {
    if (number % factor === 0) return false;
  }

  return true;
}

function checkGoldbach(expectedSum) {
  if (expectedSum < 4 || expectedSum % 2 === 1) {
    console.log(null);
    return;
  }

  // 4 is the only input that outputs even numbers; treating it as a special
  // case makes the for loop below simpler (only tries odd numbers)
  if (expectedSum === 4) {
    console.log(2, 2);
    return;
  }

  let midPoint = Math.floor(expectedSum / 2);
  for (let counter = 3; counter <= midPoint; counter += 2) {
    if (isPrime(counter)) {
      let difference = expectedSum - counter;
      if (isPrime(difference)) console.log(counter, difference);
    }
  }
}
