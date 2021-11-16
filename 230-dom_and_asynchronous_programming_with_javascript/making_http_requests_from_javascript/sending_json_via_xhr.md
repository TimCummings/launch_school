
# Example: Sending JSON via XHR - 3/13/2021

## Problems

1. Write out the raw text of the HTTP request the last example above will send to the server.


### Solution

```
POST /books HTTP/1.1

Host: ls-230-book-ctalog.herokuapp.com
Content-Type: application/json; charset=utf-8

{"title":"Eloquent JavaScript","author":"Marijn Haverbeke"}
```

#### Adjustments based on provided solution

There is no empty line between the request line and the headers section. There will also be an `Accept` header with a value of `*/*`.

---

2. Write some JavaScript to create a new product by sending a request to the JSON API on our web store. To create a product, make a `POST` request to `https://ls-230-web-store-demo.herokuapp.com/v1/products`. To make the post request, you'll need the following:

* `Content-Type` header set to `application/json; charset=utf-8`
* `Authorization` header set to `token AUTH_TOKEN`
* `json` object with with the following properties:
  * name
  * sku (must have 3 or more characters)
  * price (must be an integer greater than 0)

### Solution

```javascript
let data = {
  name: 'Green Pen',
  sku: 'grep100',
  price: 100,
};

let request = new XMLHttpRequest();
request.open('POST', 'https://ls-230-web-store-demo.herokuapp.com/v1/products');
request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
request.setRequestHeader('Authorization', 'token AUTH_TOKEN');

request.send(JSON.stringify(data));
```
