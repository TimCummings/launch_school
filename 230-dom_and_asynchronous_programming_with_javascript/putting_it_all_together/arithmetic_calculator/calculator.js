function calculate(firstOperand, secondOperand, operator) {
  if (Number.isNaN(firstOperand) || Number.isNaN(secondOperand)) {
    return 'Inputs must be numbers.';
  }

  switch (operator) {
    case '+': return firstOperand + secondOperand;
    case '-': return firstOperand - secondOperand;
    case '*': return firstOperand * secondOperand;
    case '/': return firstOperand / secondOperand;
    default: return `Unrecognized operator: ${operator}`;
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  form.addEventListener('submit', event => {
    event.preventDefault();

    const firstOperand = parseInt(document.getElementById('first-number').value, 10);
    const secondOperand = parseInt(document.getElementById('second-number').value, 10);
    const operator = document.getElementById('operator').value;
    const result = document.getElementById('result');

    result.textContent = calculate(firstOperand, secondOperand, operator);
  });
});
