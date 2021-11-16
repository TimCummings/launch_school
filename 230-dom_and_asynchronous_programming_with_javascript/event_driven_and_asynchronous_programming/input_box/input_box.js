let intervalId;

document.addEventListener('DOMContentLoaded', () => {
  let textField = document.querySelector('div.text-field');

  textField.addEventListener('click', event => {
    event.stopPropagation();
    textField.classList.add('focused');

    if (!intervalId) {
      intervalId = setInterval(() => {
        textField.classList.toggle('cursor');
      }, 500);
    }
  });
});

document.addEventListener('click', event => {
  let textField = document.querySelector('div.text-field');
  clearInterval(intervalId);
  intervalId = null;
  textField.classList.remove('focused', 'cursor');
});

document.addEventListener('keydown', event => {
  let textField = document.querySelector('div.text-field');
  let contentDiv = document.querySelector('div.content');

  if (textField.classList.contains('focused')) {
    if (event.key === 'Backspace') {
      contentDiv.textContent = contentDiv.textContent.slice(0, -1);
    } else {
      contentDiv.textContent += event.key;
    }
  }
});
