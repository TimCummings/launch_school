let Slideshow = (function() {
  const photos = {};
  const templates = {};

  return class Slideshow {
    constructor() {
      this.initializeTemplates();
      this.getPhotos();
      this.bindEvents();
    }

    initializeTemplates() {
      Array.from(document.querySelectorAll('script[type="text/x-handlebars"]')).forEach(template => {
        let id = template.id;
        templates[id] = Handlebars.compile(template.innerHTML);

        if (template.dataset.type === 'partial') {
          Handlebars.registerPartial(id, template.innerHTML);
        }
      });
    }

    getPhotos() {
      fetch('/photos')
        .then(response => {
          if (!response.ok) alert('photos not found');
          return response.json();
        })
        .then(data => {
          data.forEach(photo => photos[photo.id] = photo);
          this.renderPhotos({ photos: data });
          this.renderPhotoInfo(data[0].id);
          this.getComments(data[0].id);
        })
        .catch(error => alert(`error getting photos: ${error}`));
    }

    renderPhotos() {
      const slides = document.querySelector('#slides');
      let input = { photos: Object.values(photos) };
      slides.insertAdjacentHTML('beforeend', templates['photos'](input));

      let figures = document.querySelectorAll('#slides figure');
      figures[0].classList.add('shown');
      for (let index = 1; index < figures.length; index += 1) {
        figures[index].classList.add('hidden');
      }
    }

    renderPhotoInfo(id) {
      const header = document.querySelector('section > header');
      header.textContent = null;
      header.insertAdjacentHTML('beforeend', templates['photo_information'](photos[id]));
    }

    getComments(id) {
      fetch(`/comments?photo_id=${id}`)
        .then(response => {
          if (!response.ok) alert('comments not found');
          return response.json();
        })
        .then(data => {
          this.renderComments(id, { comments: data });
        })
        .catch(error => alert(`error getting comments: ${error}`));
    }

    renderComments(photoId, comments) {
      document.querySelector('#comments input[name="photo_id"]').value = photoId;

      const list = document.querySelector('#comments ul');
      list.textContent = null;
      list.insertAdjacentHTML('beforeend', templates['photo_comments'](comments));
    }

    transitionSlide = (event) => {
      event.preventDefault();
      let currentSlide = document.querySelector('#slides figure.shown');
      let nextSlide;

      if (event.currentTarget.classList.contains('prev')) {
        nextSlide = currentSlide.previousElementSibling ||
          currentSlide.parentElement.lastElementChild;
      } else {
        nextSlide = currentSlide.nextElementSibling ||
          currentSlide.parentElement.firstElementChild;
      }

      currentSlide.classList.replace('shown', 'hidden');
      nextSlide.classList.replace('hidden', 'shown');

      this.renderPhotoInfo(nextSlide.dataset.id);
      this.getComments(nextSlide.dataset.id);
    }

    handleAction = (event) => {
      const type = event.target.dataset.property;
      if (!type) return;

      event.preventDefault();
      if (type === 'likes' || type === 'favorites') {
        this.postAction(event.target.dataset.id, type);
      }
    }

    postAction(id, type) {
      fetch(`/photos/${type.slice(0, -1)}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ photo_id: id }),
      })
        .then(response => {
          if (!response.ok) alert(`${type} request failed`);
          return response.json();
        })
        .then(data => this.renderCount(id, data.total, type))
        .catch(error => alert(`Error posting like: ${error}`));
    }

    renderCount(photoId, count, type) {
      photos[photoId][type] = count;
      const element = document.querySelector(`a[data-property="${type}"]`);
      element.textContent = element.textContent.replace(/\d+/, String(count));
    }

    postComment = (event) => {
      event.preventDefault();

      fetch('/comments/new', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: new URLSearchParams(new FormData(event.currentTarget)),
      })
        .then(response => {
          if (!response.ok) alert('comment post request failed');
          return response.json();
        })
        .then(data => this.appendComment(data))
        .catch(error => alert(`Error posting comment: ${error}`));
    }

    appendComment(comment) {
      document.querySelector('#comments form').reset();
      const list = document.querySelector('#comments ul');
      list.insertAdjacentHTML('beforeend', templates['photo_comment'](comment));
    }

    bindEvents() {
      document.querySelector('a.prev').addEventListener('click', this.transitionSlide);
      document.querySelector('a.next').addEventListener('click', this.transitionSlide);
      document.querySelector('section > header').addEventListener('click', this.handleAction);
      document.querySelector('#comments form').addEventListener('submit', this.postComment);
    }
  };
})();

document.addEventListener('DOMContentLoaded', () => {
  const gallery = new Slideshow();
});
