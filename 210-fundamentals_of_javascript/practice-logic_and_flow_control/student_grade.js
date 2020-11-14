// Student Grade
//
// Write a program to determine a student’s grade based on the average of three scores you get from the user. Use these rules to compute the grade:
//
//     If the average score is greater than or equal to 90 then the grade is 'A'
//     If the average score is greater than or equal to 70 and less than 90 then the grade is 'B'
//     If the average score is greater than or equal to 50 and less than 70 then the grade is 'C'
//     If the average score is less than 50 then the grade is 'F'
//
// You may assume that all input values are valid positive integers.
// Example
//
// // prompts to get the 3 scores
// Enter score 1: 90
// Enter score 2: 50
// Enter score 3: 78
//
// // log to the console
// Based on the average of your 3 scores your letter grade is "B".

function getScores() {
  const rlSync = require('readline-sync');
  const SCORES_QTY = 3;
  let scores = [];

  for (let counter = 1; counter <= SCORES_QTY; counter += 1) {
    let input = rlSync.question(`Enter score ${counter}: `);
    scores.push(Number(input));
  }

  return scores;
}

function average(numbers) {
  let sum = numbers.reduce((sum, number) => sum += number);
  return sum / numbers.length;
}

let averageScore = average(getScores());
let grade;

if (averageScore >= 90) {
  grade = 'A';
} else if (averageScore >= 70) {
  grade = 'B';
} else if (averageScore >= 50) {
  grade = 'C';
} else {
  grade = 'F';
}

console.log(`Based on the average of your 3 scores your letter grade is "${grade}".`);
