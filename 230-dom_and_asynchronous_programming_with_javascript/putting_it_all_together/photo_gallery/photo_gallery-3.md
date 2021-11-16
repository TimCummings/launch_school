
# Project: Photo Gallery, Part 3 - Like, Favorite, and Comment - 3/30/2021

## Step 4: Like and Favorite a Photo

In this step, we'll allow the user to click on the "Like" and "Favorite" buttons and consequently, increment the respective counts.

The API end-point that we're going to use for this step:

* Like a photo:
  * Path: `/photos/like`; send `photo_id` as the data
  * HTTP method: POST
* Favorite a photo:
  * Path: `/photos/favorite`; send `photo_id` as the data
  * HTTP method: POST

Both of these end-points respond with a JSON object with a total. Use that to update the numbers on the buttons.

```
{
  total: 6
}
```

### Solution

```javascript
// inside Slideshow class; other code omitted for brevity
    handleAction = (event) => {
      if (!event.target.matches('a.button.like, a.button.favorite')) return;

      event.preventDefault();
      if (event.target.classList.contains('like')) {
        this.postAction(event.target.dataset.id, 'like');
      } else if (event.target.classList.contains('favorite')) {
        this.postAction(event.target.dataset.id, 'favorite');
      }
    }

    postAction(id, type) {
      fetch(`/photos/${type}`, {
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
      photos[photoId][`${type}s`] = count;
      const element = document.querySelector(`section > header a.button.${type}`);
      element.textContent = element.textContent.replace(/\d+/, String(count));
    }

    bindEvents() {
      document.querySelector('a.prev').addEventListener('click', this.transitionSlide);
      document.querySelector('a.next').addEventListener('click', this.transitionSlide);
      document.querySelector('section > header').addEventListener('click', this.handleAction);
    }
```

#### Adjustments based on provided solution

Basing button logic on the `data-property` attribute is cleaner than `classList` and should be more reliable and maintainable (`data-property` is likely to not exist or have one value; `classList` already has multiple values and is likely to expand.)

```javascript
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
```
---

## Step 5: Add a New Comment for a Photo

Lastly, we're going to allow the user to add comments. We're going to add a submit callback to the comment form that will serialize and send the data to the server. The API end point that we're going to use for this step:

* Path: `/comments/new`
* HTTP method: POST

The server will save the comment and return a JSON object back with the same data with a `date` property. If the email has a [Gravatar](https://en.gravatar.com/) associated with it, you'll get back a Gravatar url that you can use to render the comment. Here's an example server response:

```javascript
{
  "name": "Shane Riley",
  "photo_id": 1,
  "gravatar": "http://gravatar.com/avatar/9f6f9c0b100d371267f07a12f73edf9d",
  "date": "3/31/15",
  "body": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
}
```

Once we get the response, we're going to:

* Render the new comment at the end of the current comments list using the JSON data that is returned
* Reset the form

The server is expecting the data as a set of parameters in the structure of a query string (although we're sending it in the body, since this is a post request):

`photo_id=1&name=Bill&email=bill%40gmail.com&body=some+random+comment`

One tricky part of the implementation is converting the submitted form data to the format required by the server.

> Hint (jQuery): You can call jQuery's [serialize](https://api.jquery.com/serialize/) method on the form object to serialize the form data for sending to the server.

> Hint (vanilla JS): You can use the [FormData](https://developer.mozilla.org/en-US/docs/Web/API/FormData) API in conjunction with the [URLSearchParams](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams).

### Solution

```javascript
postComment = (event) => {
  event.preventDefault();
  const query = new URLSearchParams(new FormData(event.currentTarget));

  fetch('/comments/new', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body: query.toString(),
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

// ...
```

#### Adjustments based on provided solution

* When submitting form data via an event listener, you can set the path and method based on the form's attributes instead of hard coding them into your backend code.
* In a `fetch` call, you don't have to manually call `toString` on the `URLSearchParams` instance:

### Solution

```javascript
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
```
