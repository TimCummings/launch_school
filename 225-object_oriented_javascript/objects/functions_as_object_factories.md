
# Functions as Object Factories - 12/9/2020

## Problems

1. Write a `makeCar` function that works as shown above.

### Solution

```javascript
let makeCar = function makeCar(rate) {
  return {
    speed: 0,
    rate,
    accelerate() {
      this.speed += this.rate;
    },
  };
};
```

---

2. Use your new definition of `makeCar` to create a hatchback car whose rate of acceleration is 9 mph/s.

### Solution

```javascript
let hatchback = makeCare(9);
```

---

3. Our application now needs to handle braking to slow down. Extend the code from problem 1 to handle specifying a braking rate for each car. Also, add a method that tells the car to apply the brakes for one second. It should work like this:

```javascript
> let sedan = makeCar(8, 6);
> sedan.accelerate();
> sedan.speed;
= 8
> sedan.brake();
> sedan.speed;
= 2
> sedan.brake();
> sedan.speed;
= 0
```

Notice how the car's speed doesn't go lower than `0`.

### Solution

```javascript
let makeCar = function makeCar(accelerationRate, decelerationRate) {
  return {
    speed: 0,
    accelerationRate,
    decelerationRate,
    accelerate() {
      this.speed += this.accelerationRate;
    },
    brake() {
      this.speed -= this.decelerationRate;
      if (this.speed < 0) this.speed = 0;
    },
  };
};
```
