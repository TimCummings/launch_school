
# Practice Problem: Processing Releases - 11/15/2020

Write a Function named `processReleaseData` that processes the following movie release data:

```javascript
let newReleases = [
  {
    'id': 70111470,
    'title': 'Die Hard',
    'boxart': 'http://cdn-0.nflximg.com/images/2891/DieHard.jpg',
    'uri': 'http://api.netflix.com/catalog/titles/movies/70111470',
    'rating': [4.0],
    'bookmark': [],
  },
  {
    'id': 654356453,
    'boxart': 'http://cdn-0.nflximg.com/images/2891/BadBoys.jpg',
    'uri': 'http://api.netflix.com/catalog/titles/movies/70111470',
    'rating': [5.0],
    'bookmark': [{ id:432534, time:65876586 }],
  },
  {
    'title': 'The Chamber',
    'boxart': 'http://cdn-0.nflximg.com/images/2891/TheChamber.jpg',
    'uri': 'http://api.netflix.com/catalog/titles/movies/70111470',
    'rating': [4.0],
    'bookmark': [],
  },
  {
    'id': 675465,
    'title': 'Fracture',
    'boxart': 'http://cdn-0.nflximg.com/images/2891/Fracture.jpg',
    'uri': 'http://api.netflix.com/catalog/titles/movies/70111470',
    'rating': [5.0],
    'bookmark': [{ id:432534, time:65876586 }],
  },
];
```

The Function should generate an Array of Objects that contain only the `id` and `title` key/value pairs. You may assume that `id` and `title`, when existing, is an integer greater than `0` and non-empty string respectively. Here are the rules:

* Keep only releases that have both `id` and `title` property present.
* Keep only the `id` and `title` data for each release.

```javascript
function processReleaseData(data) {
  // ...
}

processReleaseData(newReleases);

// should return:
[{ id: 70111470, title: 'Die Hard'}, { id: 675465, title: 'Fracture' }];
```

### Solution

1. Filter for releases that have both `id` and `title` properties.
2. Map filtered releases to end result, keeping only `id` and `title` properties as specified:

```javascript
let isValid = function isValid(release) {
  return ('id' in release && 'title' in release);
};

let processReleaseData = function processReleaseData(data) {
  let validReleases = data.filter(isValid);
  return validReleases.map(release => ({ id: release.id, title: release.title }));
};
```

#### Further Exploration

The current solution assumes that the value of `id` will be an integer value greater than `0`. If it was possible to have a value of `0` for `id`, what would the implications be to the current solution? What changes, if any, would need to be made in order to handle the `0` value?

##### FE Solution

If `id` could have a value of `0`, the callback we pass to `filter` would need to be changed, since `0` is a falsy value in JavaScript. With the current callback, a valid release with an `id` of `0` would be filtered out as invalid. Passing a callback to `filter` that checks if the `id` property exists (see my solution) rather than if it has a truthy value would work.
