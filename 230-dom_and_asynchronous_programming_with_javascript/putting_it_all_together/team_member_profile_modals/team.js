function resetOverlay(overlay) {
  let profileImg = overlay.querySelector('article img');
  if (profileImg) profileImg.remove();

  overlay.querySelector('h4').textContent = '';
  overlay.querySelector('p').textContent = '';
}

function setOverlay(overlay, currentTarget) {
  let img = currentTarget.querySelector('article img').cloneNode(false);
  let heading = overlay.querySelector('h4');

  heading.insertAdjacentElement('beforebegin', img);
  heading.textContent = img.alt;
  overlay.querySelector('p').textContent = currentTarget.dataset.bio;

  overlay.classList.replace('hidden', 'shown');
}

document.addEventListener('DOMContentLoaded', () => {
  const overlay = document.getElementById('overlay');
  overlay.addEventListener('click', function(event) {
    if (event.target === this) this.classList.replace('shown', 'hidden');
  });

  const overlayCloseBtn = document.getElementById('close-modal');
  overlayCloseBtn.addEventListener('click', event => {
    event.stopPropagation();
    overlay.classList.replace('shown', 'hidden');
  });

  document.addEventListener('keyup', event => {
    if (event.key === 'Escape') {
      overlay.classList.replace('shown', 'hidden');
    }
  });

  const teamMembers = Array.from(document.querySelectorAll('#team li'));
  teamMembers.forEach(member => {
    member.addEventListener('click', event => {
      event.preventDefault();
      event.stopPropagation();
      resetOverlay(overlay);
      setOverlay(overlay, event.currentTarget);
    });
  });
});
