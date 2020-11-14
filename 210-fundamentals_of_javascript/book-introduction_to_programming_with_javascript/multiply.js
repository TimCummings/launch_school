function multiply(num1, num2) {
  return num1 * num2;
}

let rlsync = require('readline-sync');

let num1 = rlsync.question('Enter the first number: ');
num1 = Number(num1);

let num2 = rlsync.question('Enter the second number: ');
num2 = Number(num2);

console.log(`${num1} * ${num2} = ${multiply(num1, num2)}`);
