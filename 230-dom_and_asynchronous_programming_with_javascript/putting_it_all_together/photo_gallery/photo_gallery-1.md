
# Project: Photo Gallery, Part 1 - Fetch Data and Render on Page Load - 3/30/2021

## Step 1: Fetch Photos Data and Render Photos on Page Load

For this step, we're going to issue an AJAX request to the server to get the JSON data for all the photos on page load, then use that to:

* Render the `photos` template, and write it to the `#slides` div
* Render the `photo_information` template using the **first photo**'s data, and write it to `section > header` element that needs to contain the photo information

The API end point that we need to use for this step:

* Path: `/photos`
* HTTP method: GET
* Returns: an array of photos data in JSON format

Since this is an HTTP GET, feel free to type `http://localhost:3000/photos` in your browser to see the data that it returns. If you're stuck or need a hint, check out the solution below.

A couple of hints on how to approach the implementation:

* Spend some time looking through the Handlebars templates to understand the data that needs to be supplied to each
* Using your browser, make some calls to the various API endpoints. Use the DevTools network tab to see what json data is returned

### Solution

```javascript
function getPhotos() {
  const xhr = new XMLHttpRequest();
  xhr.responseType = 'json';

  xhr.addEventListener('load', () => {
    console.log('loaded photos:', xhr.response);
    if (xhr.status >= 400) console.log('photos not found');
    renderPhotos({ photos: xhr.response });
    renderPhotoInfo(xhr.response[0]);
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
}

function renderPhotoInfo(photo) {
  const photoInfoTemplate = Handlebars.compile(document.querySelector('#photo_information').innerHTML);
  const header = document.querySelector('section > header');
  header.insertAdjacentHTML('beforeend', photoInfoTemplate(photo));
}

document.addEventListener('DOMContentLoaded', () => {
  getPhotos();
});
```

## Step 2: Render Comments for the First Photo

For this step, request the comments data for the first photo and render it on page load.

The API end point that we need to use for this step:

* Path: `/comments?photo_id=\<number\>`, for example, `comments?photo_id=3`. You can get photo's IDs from the AJAX request you built in the previous step.
* HTTP method: GET
* Returns: an array of comments for the photo with `photo_id`

If you're stuck or need a hint, check out the solution below.

### Solution

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
  const commentTemplate = Handlebars.compile(document.querySelector('#photo_comment').innerHTML);
  Handlebars.registerPartial('photo_comment', document.querySelector('#photo_comment').innerHTML);

  const list = document.querySelector('#comments ul');
  list.insertAdjacentHTML('beforeend', commentsTemplate(comments));
}

document.addEventListener('DOMContentLoaded', () => {
  getPhotos();
});
```
