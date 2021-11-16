
# Project: Photo Gallery, Part 2 - Slide Show - 3/30/2021

In this assignment we'll handle the slideshow functionality. This will not only fade in the next photo, but also re-render the photo information as well as request the comments for that photo. The new comments are then rendered below the photo information.

## Step 3: Create the Slide Show Functionality

In this step, implement the feature that allows users to navigate through the photos like a slide show. The requirements are the following:

* Attach events to the previous and next anchors to fade out the current photo and fade in the new one at the same time
* If we're on the first photo and click "previous", we loop to the last one. Clicking "next" when on the last one should bring the first photo.
* Each slide transition will also render the photo details for that photo below it
* When the slideshow is advanced, request and render the comments for that photo

If using jQuery to implement your solution, the library provides several techniques for adding [animation effects](https://api.jquery.com/category/effects/) to your application, including the [fadeIn](http://api.jquery.com/fadein/) and [fadeOut](http://api.jquery.com/fadeout/) methods.

Modern CSS allows us to add many animation effects without having to resort to using JavaScript library like jQuery. One approach for the fading effect using vanilla JS would be to alter the [opacity](https://developer.mozilla.org/en-US/docs/Web/CSS/opacity) of the various slides, and set a [transition](https://developer.mozilla.org/en-US/docs/Web/CSS/transition) `duration` for that property change. Note that some CSS properties **cannot** be animated, including `display`. In order to fade the slides using `opacity`, you'll need to update the stylesheet so that `#slides figure + figure` selector uses `opacity` rather than `display` to be initially hidden from view.

```javascript
#slides figure + figure {
  opacity: 0;
}
```

You can then define some new CSS classes to alter the `opacity` of the slides, and add and remove these classes to the appropriate slides using JavaScript. Be sure to use the correct specificity for the classes.

jQuery also provides some handy methods, [prev](http://api.jquery.com/prev/) and [next](http://api.jquery.com/next/), which can be used to get to the previous or the next photo from the current photo. If using a vanilla JavaScript implementation, you'll need to be a little bit more creative about how to approach this piece of functionality.

### Solution

```css
/* remove #slides figure + figure */

#slides figure {
  position: absolute;
  top: 0;
  left: 0;
  z-index: 1;
  margin: 0;
  width: 100%;
  height: 784px;
  transition-property: opacity, visibility;
  transition-duration: 1s;

/* ... */

.hidden {
  opacity: 0;
  visibility: hidden;
}

.shown {
  opacity: 1;
  visibility: visible;
}
}
```

```javascript
function getPhotos() {
  const xhr = new XMLHttpRequest();
  xhr.responseType = 'json';

  xhr.addEventListener('load', () => {
    console.log('loaded photos:', xhr.response);
    if (xhr.status >= 400) console.log('photos not found');

    renderPhotos({ photos: xhr.response });
    renderPhotoInfo(xhr.response[0]);

    getComments(xhr.response[0].id);
  });

  xhr.addEventListener('error', () => {
    console.log('error getting photos');
  });

  xhr.open('GET', '/photos');
  xhr.send();
}

function renderPhotos(photos) {
  const photosTemplate = Handlebars.compile(document.querySelector('#photos').innerHTML);
  const slides = document.querySelector('#slides');
  slides.insertAdjacentHTML('beforeend', photosTemplate(photos));

  let figures = document.querySelectorAll('#slides figure');
  figures[0].classList.add('shown');
  for (let index = 1; index < figures.length; index += 1) {
    figures[index].classList.add('hidden');
  }
}

function renderPhotoInfo(photo) {
  const photoInfoTemplate = Handlebars.compile(document.querySelector('#photo_information').innerHTML);
  const header = document.querySelector('section > header');
  header.insertAdjacentHTML('beforeend', photoInfoTemplate(photo));
}

function getComments(photoId) {
  const xhr = new XMLHttpRequest();
  xhr.responseType = 'json';

  xhr.addEventListener('load', () => {
    console.log('loaded comments:', xhr.response);
    if (xhr.status >= 400) console.log('comments not found');
    renderComments({ comments: xhr.response });
  });

  xhr.addEventListener('error', () => {
    console.log('error getting comments');
  });

  xhr.open('GET', `/comments?photo_id=${photoId}`);
  xhr.send();
}

function renderComments(comments) {
  const commentsTemplate = Handlebars.compile(document.querySelector('#photo_comments').innerHTML);
  Handlebars.registerPartial('photo_comment', document.querySelector('#photo_comment').innerHTML);

  const list = document.querySelector('#comments ul');
  list.textContent = null;
  list.insertAdjacentHTML('beforeend', commentsTemplate(comments));
}

function transitionSlide(event) {
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

  getComments(nextSlide.dataset.id);
}

document.addEventListener('DOMContentLoaded', () => {
  getPhotos();

  document.querySelector('a.prev').addEventListener('click', transitionSlide);
  document.querySelector('a.next').addEventListener('click', transitionSlide);
});
```

#### Adjustments

By the third section of this project, I realized that I had forgotten to update the photo information when transitioning from photo to photo via the `prev` and `next` anchors. I took this opportunity to also refactor my solution into an object oriented solution:

```javascript
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
        if (template.dataset.type === 'partial') {
          let id = template.id;
          templates[id] = Handlebars.registerPartial(id, template.innerHTML);
        } else {
          let id = template.id;
          templates[id] = Handlebars.compile(template.innerHTML);
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
          this.renderComments({ comments: data });
        })
        .catch(error => alert(`error getting comments: ${error}`));
    }

    renderComments(comments) {
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

    bindEvents() {
      document.querySelector('a.prev').addEventListener('click', this.transitionSlide);
      document.querySelector('a.next').addEventListener('click', this.transitionSlide);
    }
  };
})();

document.addEventListener('DOMContentLoaded', () => {
  gallery = new Slideshow();
});
```

#### Further Adjustments

In part 3 of this project, I discovered that I wasn't updating the `value` of the comment form's hidden `photo_id` input; this resulted in all comment submissions being added to only the first photo, regardless of which photo was currently active. To fix this, the value of the `photo_id` input needs to be updated after a slide transition; when new comments are rendered was a good fit:

```javascript
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
```
