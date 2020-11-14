// Pattern Generation
//
// Write a function that takes a number of rows as the argument nStars and logs a square of numbers and asterisks. For example, if nStars is 7, log the following pattern:
//
// generatePattern(7);
//
// // console output
// 1******
// 12*****
// 123****
// 1234***
// 12345**
// 123456*
// 1234567
//
// You may assume that nStars is greater than 1 and less than 10.

function numbersString(length) {
  let result = '';

  for (let counter = 1; counter <= length; counter += 1) {
    result += counter;
  }

  return result;
}

function starsString(length) {
  let result = '';

  for (let counter = 1; counter <= length; counter += 1) {
    result += '*';
  }

  return result;
}

// function generatePattern(nStars) {
//   for (let counter = 1; counter <= nStars; counter += 1) {
//     let starsLength = nStars - counter;
//     console.log(numbersString(counter) + starsString(starsLength));
//   }
// }

generatePattern(40);



// Further Exploration
// Have you tried supplying generatePattern with a number greater than 9? What did you observe? Can you fix the current implementation so that it still renders as a rectangle? Try it yourself before scrolling down.
//
// generatePattern(20);
//
// // console output
// 1******************************
// 12*****************************
// 123****************************
// 1234***************************
// 12345**************************
// 123456*************************
// 1234567************************
// 12345678***********************
// 123456789**********************
// 12345678910********************
// 1234567891011******************
// 123456789101112****************
// 12345678910111213**************
// 1234567891011121314************
// 123456789101112131415**********
// 12345678910111213141516********
// 1234567891011121314151617******
// 123456789101112131415161718****
// 12345678910111213141516171819**
// 1234567891011121314151617181920

function maxLength(nStars) {
  let result = 0;

  for (let counter = 1; counter <= nStars; counter += 1) {
    result += String(counter).length;
  }

  return result;
}

function generatePattern(nStars) {
  let totalColumns = maxLength(nStars);

  for (let counter = 1; counter <= nStars; counter += 1) {
    let digitColumns = maxLength(counter);
    let starsLength = totalColumns - digitColumns;
    console.log(numbersString(counter) + starsString(starsLength));
  }
}
