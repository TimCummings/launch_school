
# Example: Loading JSON via XHR - 3/10/2021

## Problems

1. Write some JavaScript code that loads JSON data from `https://api.github.com/repos/rails/rails`, parses the JSON into a JavaScript object, and then logs the HTTP status code and the number of open issues to the console.

```
200
1159 // This should be whatever the current value is
```

### Solution

```javascript
let request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');
request.addEventListener('load', event => {
  let result = JSON.parse(request.response);
  console.log(request.status);
  console.log(result.open_issues_count);
});

request.send();
```

---

2. Extend the code from the previous exercise to log the message `'The request could not be completed!'` to the console when the request produces an error. You may replace the `url` in the previous exercise to `"hts://api.github.com/repos/rails/rails"` so that the error handler will be triggered.

### Solution

```javascript
let request = new XMLHttpRequest();
request.open('GET', 'hts://api.github.com/repos/rails/rails');
request.addEventListener('load', event => {
  try {
    let result = JSON.parse(request.response);
    console.log(request.status);
    console.log(result.open_issues_count);
  } catch(e) {
    console.log('The request could not be completed!');
  }
});

request.send();
```

#### Adjustments based on provided solution

Responding to `XMLHttpRequest` errors should be handled through appropriate events, not try/catch. Try/catch is for handling errors parsing JSON.

```javascript
let request = new XMLHttpRequest();
request.open('GET', 'hts://api.github.com/repos/rails/rails');
request.addEventListener('load', event => {
  let result = JSON.parse(request.response);
  console.log(request.status);
  console.log(result.open_issues_count);
});

request.addEventListener('error', event => {
  console.log('The request could not be completed!');
});

request.send();
```
