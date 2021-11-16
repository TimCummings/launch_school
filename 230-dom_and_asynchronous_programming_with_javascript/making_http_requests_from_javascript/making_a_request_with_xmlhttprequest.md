
# Making a Request with XMLHttpRequest - 3/9/2021

## Problems

1. Write JavaScript code that makes a GET request to this URL: `https://api.github.com/repos/rails/rails`.

### Solution

```javascript
let request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');
request.send();
```

---

2. What property will contain the response body after the request from the previous problem completes?

### Solution

The `response` property of the request object will have the parsed response body. The `responseText` propety will have the raw text of the response's body.
