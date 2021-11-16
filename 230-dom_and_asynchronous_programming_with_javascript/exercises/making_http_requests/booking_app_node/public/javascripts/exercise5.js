function loadSchedules(schedules, staff) {
  const form = document.getElementById('new_booking_form');
  let scheduleSelect = form['schedule'];

  schedules.forEach(schedule => {
    let option = document.createElement('option');
    option.setAttribute('value', schedule.id);

    let name = staff[schedule.staff_id].name;
    option.textContent = `${name} | ${schedule.date} | ${schedule.time}`;

    scheduleSelect.appendChild(option);
  });
}

function bookingFormToJson(form) {
  return {
    id: parseInt(form['schedule'].value, 10),
    student_email: form['email'].value,
  };
}

function studentFormToJson(form) {
  return {
    email: form['student_email'].value,
    name: form['student_name'].value,
    booking_sequence: parseInt(form['booking_sequence'].value, 10),
  };
}

function buildStudentForm(bookingSequence) {
  let container = document.createElement('div');
  container.style.background = 'lightgrey';
  let heading = document.createElement('h1');
  let form = document.createElement('form');
  form.setAttribute('id', 'new_student_form');

  let dl = document.createElement('dl');
  let dt = document.createElement('dt');
  let label = document.createElement('label');
  label.setAttribute('for', 'student_email');
  label.textContent = 'Email:';
  dt.appendChild(label);
  dl.appendChild(dt);

  let dd = document.createElement('dd');
  let input = document.createElement('input');
  input.setAttribute('type', 'email');
  input.setAttribute('id', 'student_email');
  input.setAttribute('name', 'student_email');
  dd.appendChild(input);
  dl.appendChild(dd);

  dt = document.createElement('dt');
  label = document.createElement('label');
  label.setAttribute('for', 'student_name');
  label.textContent = 'Name:';
  dt.appendChild(label);
  dl.appendChild(dt);

  dd = document.createElement('dd');
  input = document.createElement('input');
  input.setAttribute('type', 'text');
  input.setAttribute('id', 'student_name');
  input.setAttribute('name', 'student_name');
  dd.appendChild(input);
  dl.appendChild(dd);

  dt = document.createElement('dt');
  label = document.createElement('label');
  label.setAttribute('for', 'booking_sequence');
  label.textContent = 'Booking Sequence:';
  dt.appendChild(label);
  dl.appendChild(dt);

  dd = document.createElement('dd');
  input = document.createElement('input');
  input.setAttribute('type', 'text');
  input.setAttribute('id', 'booking_sequence');
  input.setAttribute('name', 'booking_sequence');
  input.setAttribute('value', bookingSequence);
  dd.appendChild(input);
  dl.appendChild(dd);

  let button = document.createElement('button');
  button.setAttribute('type', 'submit');
  button.setAttribute('form', form.id);
  button.textContent = 'Submit';

  form.appendChild(dl);
  form.appendChild(button);

  form.addEventListener('submit', event => {
    event.preventDefault();

    let xhr = new XMLHttpRequest();
    xhr.open('POST', '/api/students');
    xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

    xhr.addEventListener('load', event => {
      alert(xhr.response);

      const bookingForm = document.getElementById('new_booking_form');
      xhr = new XMLHttpRequest();
      xhr.open('POST', '/api/bookings');
      xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

      xhr.addEventListener('load', event => {
        if (/^2\d\d/.test(String(xhr.status))) {
          alert('Booked.');
          bookingForm.reset();
        } else if (/^4\d\d/.test(String(xhr.status))) {
          alert(xhr.response);
        }
      });

      const data = bookingFormToJson(bookingForm);
      console.log('data:', data);
      xhr.send(JSON.stringify(data));
    });

    const data = studentFormToJson(form);
    xhr.send(JSON.stringify(data));
  });

  container.appendChild(heading);
  container.appendChild(form);

  return container;
}

document.addEventListener('DOMContentLoaded', () => {
  let availableSchedules;
  const staff = {};

  (function getStaff() {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/staff_members');
    xhr.responseType = 'json';
    xhr.addEventListener('load', event => {
      xhr.response.map(member => {
        staff[String(member.id)] = member;
      });
    });

    xhr.send();
  })();

  (function getSchedules() {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/schedules');
    xhr.responseType = 'json';
    xhr.addEventListener('load', event => {
      availableSchedules = xhr.response.filter(({student_email}) => {
        return student_email === null;
      });

      loadSchedules(availableSchedules, staff);
    });

    xhr.send();
  })();

  const bookingForm = document.getElementById('new_booking_form');
  bookingForm.addEventListener('submit', event => {
    event.preventDefault();

    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/api/bookings');
    xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

    xhr.addEventListener('load', event => {
      console.log(xhr.status);
      console.log(typeof xhr.status);
      if (/^2\d\d/.test(String(xhr.status))) {
        alert('Booked.');
        bookingForm.reset();
      } else if (/^4\d\d/.test(String(xhr.status))) {
        alert(xhr.response);
        const regexp = /booking_sequence: (\d+)$/;
        const bookingSequence = xhr.response.match(regexp)[1];
        console.log('booking sequence:', bookingSequence);

        const studentForm = buildStudentForm(bookingSequence);
        bookingForm.insertAdjacentElement('afterend', studentForm);
      }
    });

    const data = bookingFormToJson(bookingForm);
    console.log('data:', data);
    xhr.send(JSON.stringify(data));
  });
});
