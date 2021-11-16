function activateImage(oldActive, newActive) {
  if (oldActive !== newActive) {
    if (oldActive) oldActive.classList.remove('active');
    newActive.classList.add('active');
  }

  transitionImage(newActive);

  return newActive;
}

function transitionImage(activeImage) {
  const delay = 600;
  const container = document.querySelector('figure');
  container.classList.replace('shown', 'hidden');

  setTimeout(() => {
    container.querySelector('img').src = activeImage.src;
    container.querySelector('figcaption').textContent = activeImage.title;
    container.classList.replace('hidden', 'shown');
  }, delay);
}

document.addEventListener('DOMContentLoaded', () => {
  let currentActive = activateImage(null, document.querySelector('ul img'));

  document.querySelector('ul').addEventListener('click', event => {
    if (event.target.tagName === 'IMG') {
      currentActive = activateImage(currentActive, event.target);
    }
  });
});
