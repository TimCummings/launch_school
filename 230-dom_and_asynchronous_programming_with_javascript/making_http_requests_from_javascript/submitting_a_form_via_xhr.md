
# Example: Submitting a Form via XHR 5/9/2021

```html
<h1>Existing Page</h1>

<div id="store"></div>
```

```css
#store {
  border: solid 1px black;
  padding: 0 1em;
  float: left;
  h1 {
    font-size: 1.2em;
  }
  
  h2 {
    font-size: 1em;
  }
  form {
    button {
      margin-bottom: 1em;
    }
  }
}
```

```javascript
document.addEventListener('DOMContentLoaded', () => {
  let store = document.getElementById('store');

  let request = new XMLHttpRequest();
  request.open('GET', 'https://ls-230-web-store-demo.herokuapp.com/products');

  request.addEventListener('load', event => store.innerHTML = request.response);
  request.send();

  store.addEventListener('click', event =>  {
    let target = event.target;
    if (target.tagName !== 'A') {
      return;
    }

    event.preventDefault();

    let request = new XMLHttpRequest();

    request.open('GET', `https://ls-230-web-store-demo.herokuapp.com${target.getAttribute('href')}`);

    request.addEventListener('load', event => store.innerHTML = request.response);
    request.send();
  });
});
```

## Problems

1. Recall that the product edit form didn't work properly in the last assignment. Make changes to the JavaScript to submit the edit form using `XMLHttpRequest`. Once your code is working, you should see the message — "You must be logged in to do that." — when you try to submit the form. We'll deal with this in the next problem.

### Solution

```javascript
document.addEventListener('DOMContentLoaded', () => {
  let store = document.getElementById('store');

  let request = new XMLHttpRequest();
  request.open('GET', 'https://ls-230-web-store-demo.herokuapp.com/products');

  request.addEventListener('load', event => store.innerHTML = request.response);
  request.send();

  store.addEventListener('click', event =>  {
    let target = event.target;
    if (target.tagName !== 'A') {
      return;
    }

    event.preventDefault();

    let request = new XMLHttpRequest();

    request.open('GET', `https://ls-230-web-store-demo.herokuapp.com${target.getAttribute('href')}`);

    request.addEventListener('load', event => store.innerHTML = request.response);
    request.send();
  });

  store.addEventListener('submit', event => {
    event.preventDefault();
    let form = event.target;
    let data = new FormData(form);

    let request = new XMLHttpRequest();
    request.open('POST', form.action);
    request.addEventListener('load', event => {
      store.innerHTML = request.response;
    });

    request.send(data);
  });
});
```

#### Adjustments based on provided solution

In `request.open`, the value of the form's `action` attribute needs to be appended to the root URL:

```javascript
  request.open(`https://ls-230-web-store-demo.herokuapp.com${form.getAttribute('action')}`);
```

---

2. The message, "You must be logged in to do that", tells us that the user must provide the proper authentication credentials; that is, they must prove they have the authority to update the product information. Without credentials, anybody in the world can change the product information. One way to authenticate is to provide a special header that contains an authentication token that only an authorized client should know. In a real application, the user would login to a site, which in turn would return a unique token, possible via a cookie. For now, we'll add the header manually with a simple (and insecure) string.

Modify the code you wrote in the previous exercise to add an `Authorization` header to the `XMLHttpRequest` before sending it. The header's value should be `token AUTH_TOKEN`.

### Solution

```javascript
  store.addEventListener('submit', event => {
    event.preventDefault();
    let form = event.target;
    let data = new FormData(form);

    let request = new XMLHttpRequest();
    request.open('POST', form.action);
    request.setRequestHeader('Authorization', 'token AUTH_TOKEN');
    request.addEventListener('load', event => {
      store.innerHTML = request.response;
    });

    request.send(data);
  });
```
