function getBookingDetails(date) {
  return new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `/api/bookings/${date}`);
    xhr.responseType = 'json';

    xhr.addEventListener('load', () => {
      if (xhr.status === 200) resolve(xhr.response);
      reject(xhr.statusText);
    });

    xhr.addEventListener('error', () => reject('Request was not completed.'));

    xhr.send();
  });
}

function buildList(items, isOuter = false) {
  let ul = document.createElement('ul');

  items.forEach(item => {
    let li = document.createElement('li');

    if (isOuter) {
      li.textContent = item;
      li.style.cursor = 'pointer';
      li.addEventListener('click', event => {
        let outerItem = event.target;
        getBookingDetails(outerItem.textContent.trim()).then(response => {
          outerItem.appendChild(buildList(response));
        });
      });
    } else {
      li.textContent = item.join(' | ');
    }

    ul.appendChild(li);
  });

  return ul;
}

document.addEventListener('DOMContentLoaded', () => {
  const bookingDatesPromise = new Promise((resolve, reject) => {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/bookings');
    xhr.responseType = 'json';

    xhr.addEventListener('load', () => {
      if (xhr.status === 200) resolve(xhr.response);
      reject(xhr.statusText);
    });

    xhr.addEventListener('error', () => reject('Request was not completed.'));

    xhr.send();
  });

  const bookingDates = [];
  bookingDatesPromise.then(response => {
    response.forEach(date => bookingDates.push(date));

    const container = document.getElementById('bookings');
    container.appendChild(buildList(bookingDates, true));
  }).catch(error => alert(error));
});
