
# Practice Problem: Total Square Area - 11/15/2020

For this practice problem, we'll represent rectangles as Arrays with two elements: a height and a width.

Write a Function named `totalArea` that takes an Array of rectangles as an argument. The Function should return the total area covered by all the rectangles.

```javascript
let rectangles = [[3, 4], [6, 6], [1, 8], [9, 9], [2, 2]];

totalArea(rectangles);    // 141
```

### Solution

```javascript
let area = function area(rectangle) {
  let height = rectangle[0];
  let width = rectangle[1];

  return height * width;
};

let totalArea = function totalArea(rectangles) {
  let areas = rectangles.map(area);
  return areas.reduce((sum, area) => sum + area, 0);
};
```

---

Now, write a second Function named `totalSquareArea`. This Function should calculate the total area of a set of rectangles, just like `totalArea`. However, it should only include squares in its calculations: it should ignore rectangles that aren't square.

```javascript
let rectangles = [[3, 4], [6, 6], [1, 8], [9, 9], [2, 2]];

totalSquareArea(rectangles);    // 121
```

### Solution

```javascript
let totalSquareArea = function totalSquareArea(rectangles) {
  let squares = rectangles.filter(rectangle => rectangle[0] === rectangle[1]);

  return totalArea(squares);
};
```
