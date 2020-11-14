
# Working with Dates - 11/3/2020

Let's do some practice problems with the `Date` object and its methods. You can refer to the [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) as you go through these.

1. Create a variable named `today` with the current date and time as its value.

### Solution

```javascript
let today = Date.now();
```

#### Adjustments based on provided solution

The `now()` method is unnecessary; `let today = new Date();` is sufficient.

---

2. Log a string, "Today's day is 5", that tells the current day of the week as a number between 0 and 6 (Sunday is 0, Saturday is 6). Use the `getDay` method to obtain the number of the day of week.

### Solution

```javascript
let today = new Date();
console.log(`Today's day is ${today.getDay()}`);
```

---

3. The `getDay` method, like many of the get methods on the date object, returns a zero-based index of the current day of week instead of the day name. This enables support for multiple locales and formats. Modify the output message of the previous problem to show the 3-letter day name abbreviation. You may use the following array:

```javascript
let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
```

### Solution

```javascript
let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
let today = new Date();
let thisDay = daysOfWeek[today.getDay()];
console.log(`Today's day is ${thisDay}`);
```

---

4. Let's add the calendar date (the day of month) to our log message: "Today's date is Mon, the 6th". Use the `getDate` method to obtain the current day of month. Don't worry about using different suffixes for numbers that end with `1`, `2`, or `3` just yet; we'll deal with that in the next problem.

### Solution

```javascript
let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
let today = new Date();
console.log(`Today's day is ${daysOfWeek[today.getDay()]}, the ${today.getDate()}th`);
```

---

5. Ideally, the suffix on the day number needs to adjust to the proper suffix for days like the `1st`, `22nd`, and `3rd`. Write a function named `dateSuffix` that takes the day of month as a numeric value and returns the formatted day of month and suffix. Make sure you use the correct suffixes.

### Solution

```javascript
function dateSuffix(day) {
  if (day >= 11 and <= 13) {
    return 'th';
  } else if (day % 10 === 1) {
    return 'st';
  } else if (day % 10 === 2) {
    return 'nd';
  } else if (day % 10 === 3) {
    return 'rd';
  } else {
    return 'th';
  }
}

let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
let today = new Date();
let indexedDay = today.getDay();
console.log(`Today's day is ${daysOfWeek[indexedDay]}, the ${today.getDate()}${dateSuffix(indexedDay + 1)}`);
```

---

6. Change your output to include the value from the `getMonth` method. Thus, the logged string will read "Today's date is Mon, 11 6th", where `11` is the month number returned by `getMonth`.

### Solution

```javascript
let today = new Date();
let indexedDay = today.getDay();
console.log(`Today's date is ${daysOfWeek[indexedDay]}, ${today.getMonth()} the ${today.getDate()}${dateSuffix(indexedDay + 1)}`);
```

---

7. Let's make the month readable. Using the same technique we used in problem 3, convert the month number in the output string to a 3-letter month name abbreviation. You may use the following array:

```javascript
let months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
```

### Solution

```javascript
let months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
let today = new Date();
let indexedDay = today.getDay();
console.log(`Today's date is ${daysOfWeek[indexedDay]}, ${months[today.getMonth()]} the ${today.getDate()}${dateSuffix(indexedDay + 1)}`);
```

---

8. Our call to `console.log` is getting cluttered. Let's clean things up a bit and refactor the code into a few formatting functions that we can call from anywhere in our code. Create `formattedMonth` and `formattedDay` functions to format the month and day, then write a `formattedDate` function that pulls everything together and logs the fully formatted date.

### Solution

```javascript
function dateSuffix(day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  } else if (day % 10 === 1) {
    return 'st';
  } else if (day % 10 === 2) {
    return 'nd';
  } else if (day % 10 === 3) {
    return 'rd';
  } else {
    return 'th';
  }
}

function formattedMonth(date, style) {
  let indexedMonth = date.getMonth();

  if (style === 'numeral') {
    return String(indexedMonth + 1);
  } else {
    let months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[indexedMonth];
  }
}

function formattedDay(date, style) {
  let indexedDay = date.getDay();

  if (style === 'numeral') {
    return String(indexedDay + 1) + dateSuffix(indexedDay + 1);
  } else {
    let daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return daysOfWeek[indexedDay];
  }
}

function formattedDate(date) {
  console.log(`The date is ${formattedDay(date, 'name')}, ${formattedMonth(date, 'name')} the ${formattedDay(date, 'numeral')}`);
}

let today = new Date();
formattedDate(today);
```

---

9. Log the values returned from the `getFullYear` and `getYear` methods. Note how these values differ. Note especially that `getYear` is deprecated: you should avoid using deprecated methods as they may one day disappear.

### Solution

```javascript
let today = new Date();
console.log(today.getYear());
console.log(today.getFullYear());
```

---

10. Use the `getTime` method and log the current date and time in total milliseconds since Jan. 1st 1970.

### Solution

```javascript
let today = new Date();
console.log(today.getTime());
```

---

11. Create a new date object variable named `tomorrow` that contains a Date object. Initialize the variable by setting it to the value of `today`. You can get the value of `today` using the `getTime` method. Next, change the date on the `tomorrow` object to the day after today: you should use `setDate` to change the date. Finally, log the `tomorrow` object with your `formattedDate` function.

### Solution

```javascript
let today = new Date();
let tomorrow = new Date();
tomorrow.setTime(today.getTime());
tomorrow.setDate(today.getDay() + 2);

formattedDate(tomorrow);
```

#### Adjustments based on provided solution

The intended way to initialize `tomorrow` was: `let tomorrow = new Date(today.getTime());`. Also, use `getDate()` instead of `getTime()` to avoid having to increment the day by an additional one (since it's an index): `tomorrow.setDate(today.getDate() + 1);`.

---

12. Create a new variable named `nextWeek` that is a new Date copied from the `today` object. Compare `nextWeek` and `today`, and log the results. Are they equal? Why or why not?

### Solution

```javascript
let today = new Date();
let nextWeek = new Date(today);
console.log(today === nextWeek);
```

They are not equal because they are not the same object, which is how the strict equality operator compares objects in JavaScript.

---

13. The `===` operator only returns `true` with Date objects if the objects are the same object. Since we have two different objects (with the same values), we must instead compare the values represented by those objects. Compare the values returned by `toDateString` to determine whether the two objects are equal. Finally, add 7 days to the `nextWeek` date and compare the two objects again.

### Solution

```javascript
let today = new Date();
let nextWeek = new Date(today);
console.log(today.toDateString() === nextWeek.toDateString());

nextWeek.setDate(7);
console.log(today === nextWeek);
console.log(today.toDateString() === nextWeek.toDateString());
```

---

14. Finally, write a function named `formatTime` that takes a date object as an argument and returns a string formatted with the hours and minutes as "15:30". Make sure you handle the case where the hours or minutes has only one digit: you need to pad the value with a leading zero in such cases, e.g., "03:04". You can use the `getHours` and `getMinutes` methods to obtain the hours and minutes.

### Solution

```javascript
function formatTime(date) {
  let hours = today.getHours();
  let minutes = today.getMinutes();

  hours = (hours < 10) ? `0${hours}` : `${hours}`;
  minutes = (minutes < 10) ? `0${minutes}` : `${minutes}`;

  return hours + ':' + minutes;
}

let today = new Date();
console.log(formatTime(today));
```
