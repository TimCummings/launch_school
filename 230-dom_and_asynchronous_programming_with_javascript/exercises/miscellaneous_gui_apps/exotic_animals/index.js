let tooltipEvent = null;

function showTooltip(image) {
  const tooltip = image.parentElement.lastElementChild;
  tooltip.classList.replace('hidden', 'shown');
}

function hideTooltip(image) {
  const tooltip = image.parentElement.lastElementChild;
  tooltip.classList.replace('shown', 'hidden');
}

document.addEventListener('DOMContentLoaded', () => {
  const gallery = document.querySelector('#gallery');

  gallery.addEventListener('mouseover', event => {
    event.stopPropagation();
    if (!event.target.matches('img')) return;

    tooltipEvent = setTimeout(showTooltip, 2000, event.target);
  });

  gallery.addEventListener('mouseout', event => {
    event.stopPropagation();
    if (!event.target.matches('img')) return;

    if (tooltipEvent) {
      clearTimeout(tooltipEvent);
      tooltipEvent = null;
    }

    hideTooltip(event.target);
  });
});
