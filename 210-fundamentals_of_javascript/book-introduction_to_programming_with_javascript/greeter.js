function solicitName(prompt) {
  let rlSync = require('readline-sync');
  let name = rlSync.question(prompt);
  return name;
}

let firstName = solicitName('What is your first name? ');
let lastName = solicitName('What is your last name? ');
console.log(`Hello, ${firstName} ${lastName}!`);
