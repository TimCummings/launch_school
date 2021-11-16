
# Making HTTP Requests - 3/16/2021

## 1. Exploring the Booking App

You'll be using a booking app throughout the exercise group, "Making HTTP Requests." To help you explore the documentation, try answering the following questions by running the server, opening your browser, visiting `/doc`, and carefully reading the documentation available for each route in the app. The app has seed data, so you can freely test out the different routes. You should only need to visit one route to determine the answer; if you'll need to visit more than one route, then the answer is *"There is no route that will provide this information."*

1. How many staff are there?
2. How many students are there?
3. How many schedules exist?
4. How many schedules have bookings?
5. Do all staff have schedules?
6. Did all students book a schedule?

### Solution
1. 5
2. 5
3. There is no route that will provide this information.
4. There is no route that will provide this information.
5. There is no route that will provide this information.
6. There is no route that will provide this information.

#### Adjustments based on provided solution

3. There are 9 schedules: `/api/schedules`.
4. There are 3 schedules with bookings: go to `/api/schedules` and count how many have emails.

---

## 2. Getting Schedules

Implement a function that retrieves all the schedules that are available. If one or more schedules are available, tally the count of schedules for each staff and alert the user of result as "key: value" pairs with the staff id as key (in the format of `'staff {id}'`; e.g, `'staff 1'`) and the count of schedules as the value. If there are no schedules, alert the user that there are currently no schedules available for booking.

When implementing the function, keep in mind that server has been known to slow down when there are more than 7 schedules to retrieve. It doesn't always happen, but be sure to handle it accordingly. Once 5 seconds have passed, cancel the retrieval and inform the user to try again.

Finally, inform the user about the completion of the request regardless of the success or failure (timeout) of the request.

> Note: Server slow down for when there are more than 7 schedules to retrieve is manufactured only. For reference, the manufactured time is 7 seconds.

> When running the JavaScript code, be sure that you're not doing cross origin requests; the app is not set to handle it. The easiest way to avoid it is to create an HTML file in the public directory of the app, access that file (page) via the proper path, and run the JS code from the web page.
>
> For example, if you've created a `public/exercise1.html` file you'll access it via: `http://localhost/exercise1.html`.

### Solution

[exercise2.html](./booking_app_node/public/exercise2.html)

```javascript
function getSchedules() {
  let request = new XMLHttpRequest();
  let timeout;

  request.open('GET', '/api/schedules');
  request.responseType = 'json';

  request.addEventListener('load', event => {
    clearInterval(timeout);
    alert('Request completed successfully.');

    let schedules = request.response;
    let schedulesByStaff = {};

    schedules.forEach(schedule => {
      let key = `staff ${schedule.staff_id}`;
      if (!schedulesByStaff[key]) schedulesByStaff[key] = 0;
      schedulesByStaff[key] += 1;
    });

    if (Object.keys(schedulesByStaff).length > 0) {
      Object.keys(schedulesByStaff).forEach(staff => {
        alert(`${staff}: ${schedulesByStaff[staff]}`);
      });
    } else {
      alert('There are currently no schedules available for booking.');
    }
  });

  request.addEventListener('loadstart', event => {
    timeout = setTimeout(() => {
      request.abort();
      alert('Request timed out.');
    }, 5000);
  });

  request.send();
}
```

#### Adjustments based on provided solution

Instead of using `setTimeout`, you can set an actual timeout directly on the XHR object via its `timeout` property: `request.timeout = 5000;`. Then add an event listener for the `timeout` event.

Instead of an individual alert for every key-value pair, join them all into a single string:

```javascript
alert(Object.keys(schedulesByStaff)
            .map(staff => `${staff}: ${schedulesByStaff[staff]}`)
            .join('\n'));
```

I misunderstood the final requirement about informing the user about the completion of the request. The notice does not need to specify whether the request succeeded or timed out, just that it completed; use the `loadend` event for that:

```javascript
request.addEventListener('loadend', event => {
  alert('The request has completed.');
});
```

---

## 3. Adding Staff

Implement a form for adding new staff, and then use the booking app API to add the staff to the database. Your implementation should handle the different possible responses of the server and inform the user of the outcome.

### Solution

[exercise3.html](./booking_app_node/public/exercise3.html)

```javascript
function formIsEmpty(form) {
  let fields = Array.from(form.querySelectorAll('input'));
  if (fields.length === 0 || fields.some(f => f.value.trim() === '')) {
    return true;
  }

  return false;
}

document.addEventListener('DOMContentLoaded', () => {
  let form = document.getElementById('new_staff_form');

  form.addEventListener('submit', event => {
    event.preventDefault();
    console.log('stopping default submit!');

    if (formIsEmpty(form)) {
      alert('Staff can not be created. Check your inputs.');
      return;
    }

    let data = new FormData(form);

    let request = new XMLHttpRequest();
    request.open('POST', '/api/staff_members');
    request.responseType = 'json';

    request.addEventListener('load', event => {
      if (request.status === 201) {
        alert(`Successfully created staff with id: ${request.response.id}`);
      } else {
        alert(`Request status: ${request.status} - ${request.statusText}`);
      }
    });

    request.addEventListener('error', event => {
      alert('Error! Request did not complete. Please try again.');
    });

    request.send(data);
  });
});
```

#### Adjustments based on provided solution

DON'T set the XHR request's `responseType` to `json`, because, if you get a response with a status other than `201`, you won't be able to read the `responseText`, which would be more meaningful than just the `statusText`.

You should also reset the form after a successful request submission with `form.reset()`.

---

## 4. Adding Schedules

Implement the markup and JavaScript to add one or more schedules. You should handle and inform the user of the different possible responses of the server.

### Solution

[exercise4.html](./booking_app_node/public/exercise4.html)
[exercise4.js](./booking_app_node/public/javascripts/exercise4.js)

#### Adjustments based on provided solution

* Use arguments instead of relying on data from an outer scope to better encapsulate logic.
* Use object destructuring to simplify property access, especially with callback arguments.
* Increment the schedule counter immediately before building a new schedule from the template; this keeps the counter accurate instead of being one number too high. This is useful for serializing the form data (with the counter instead of iterating through the data.)

---

## 5. Booking Time Slots

Implement the markup and JavaScript for booking a schedule. Be sure to check out the documentation on the requirements for a booking.

In the event that the student who's booking the appointment isn't in the database, you must provide a way for the user to create the student, and then automatically proceed with the booking once the student is successfully created.

Assume that only one schedule at a time can be booked.

### Solution

[exercise5.html](./booking_app_node/public/exercise5.html)
[exercise5.js](./booking_app_node/public/javascripts/exercise5.js)

---

## 6. Viewing Bookings
Implement the markup and JavaScript to view bookings made by students. The view for bookings should have two levels of detail. The first level shows only a list of dates that have bookings. the second level becomes visible only when a date is clicked and shows a nested list of booking details for the data. Details include the staff name, student email address, and the time booked.

### Solution

[exercise6.html](./booking_app_node/public/exercise6.html)
[exercise6.js](./booking_app_node/public/javascripts/exercise6.js)

#### Adjustments based on provided solution

I fundamentally misunderstood what this exercise was asking me to do. My approach was to load all of the data and add all of the elements to the page right away, but hide the inner lists until an outer list item is clicked. However, the point of this exercise is to load the data incrementally, i.e. load only the outer list, then, when a list item is clicked, load and populate the specific data just for that list item.

---

## 7. Cancellations

Implement two functions: one for cancelling schedules and the other for cancelling of bookings. The functions take a `scheduleId` and a `bookingId` as arguments respectively.

### Solution

```javascript
function cancelSchedule(scheduleId) {
  const xhr = new XMLHttpRequest();
  xhr.open('DELETE', `/api/schedules/${scheduleId}`);

  xhr.addEventListener('load', () => {
    if (xhr.status === 204) {
      alert (`Schedule ${scheduleId} cancelled.`);
    } else {
      alert(xhr.response);
    }
  });

  xhr.addEventListener('error', () => {
    alert('Request failed.');
  });

  xhr.send();
}

function cancelBooking(bookingId) {
  const xhr = new XMLHttpRequest();
  xhr.open('PUT', `/api/bookings/${bookingId}`);

  xhr.addEventListener('load', () => {
    if (xhr.status === 204) {
      alert(`Booking ${bookingId} cancelled.`);
    } else {
      alert(xhr.response);
    }
  });

  xhr.addEventListener('error', () => {
    alert('Request failed.');
  });

  xhr.send();
}
```
