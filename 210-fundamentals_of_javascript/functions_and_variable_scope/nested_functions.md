
# Nested Functions - 10/22/2020

You can nest functions inside other functions:

```javascript
function circumference(radius) {
  function double(number) {
    return 2 * number;
  }

  return 3.14 * double(radius);
}
```

There's no hard limit to how deeply you can nest functions; this is a source of enormous expressive power for JavaScript. We'll cover this further; for now just know that you can do this.
