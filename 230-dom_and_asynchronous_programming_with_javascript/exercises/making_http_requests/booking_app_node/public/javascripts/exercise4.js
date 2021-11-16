function buildSchedule(number, staff) {
  let schedule = document.createElement('fieldset');

  let legend = document.createElement('legend');
  legend.textContent = `Schedule ${number}`;
  schedule.appendChild(legend);

  let dl = document.createElement('dl');
  schedule.appendChild(dl);

  let dt = document.createElement('dt');
  let label = document.createElement('label');
  label.setAttribute('for', `staff_${number}`);
  label.textContent = 'Staff Name:';
  dt.appendChild(label);
  dl.appendChild(dt);

  let dd = document.createElement('dd');
  let select = document.createElement('select');
  select.setAttribute('id', `staff_${number}`);
  select.setAttribute('name', `staff_${number}`);

  staff.forEach(member => {
    let option = document.createElement('option');
    option.setAttribute('value', member.id);
    option.textContent = member.name;
    select.appendChild(option);
  });
  dd.appendChild(select);
  dl.appendChild(dd);

  ['Date', 'Time'].forEach(field => {
    let dt = document.createElement('dt');
    let label = document.createElement('label');
    label.setAttribute('for', `${field.toLowerCase()}_${number}`);
    label.textContent = `${field}:`;
    dt.appendChild(label);
    dl.appendChild(dt);

    let dd = document.createElement('dd');
    let input = document.createElement('input');
    input.setAttribute('type', 'text');
    input.setAttribute('id', `${field.toLowerCase()}_${number}`);
    input.setAttribute('name', `${field.toLowerCase()}_${number}`);
    dd.appendChild(input);
    dl.appendChild(dd);
  });

  return schedule;
};

function formIsEmpty(form) {
  let fields = Array.from(form.querySelectorAll('input'));
  return (fields.length === 0) || fields.some(f => f.value.trim() === '');
}

function serializeForm(form, scheduleCount) {
  let schedules = [];
  for (let counter = 1; counter <= scheduleCount; counter += 1) {
    let schedule = {
      staff_id: form[`staff_${counter}`].value,
      date: form[`date_${counter}`].value,
      time: form[`time_${counter}`].value,
    };
    schedules.push(schedule);
  }
  return { schedules: schedules };
}


document.addEventListener('DOMContentLoaded', () => {
  let form = document.getElementById('new_schedule_form');
  let button = document.getElementById('add_schedule');
  let scheduleCount = 0;
  let staff;

  (function getStaff() {
    let xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/staff_members');
    xhr.responseType = 'json';
    xhr.send();

    xhr.addEventListener('load', () => {
      staff = xhr.response;

      scheduleCount += 1;
      let newSchedule = buildSchedule(scheduleCount, staff);
      form.insertBefore(newSchedule, form.lastElementChild);
    });
  })();

  button.addEventListener('click', event => {
    event.preventDefault();
    scheduleCount += 1;
    let newSchedule = buildSchedule(scheduleCount, staff);
    form.insertBefore(newSchedule, form.lastElementChild);
  });

  form.addEventListener('submit', event => {
    event.preventDefault();

    if (formIsEmpty(form)) {
      alert('Please check your inputs.');
      return;
    }

    let request = new XMLHttpRequest();
    request.open('POST', '/api/schedules');
    request.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

    request.addEventListener('load', event => {
      if (request.status === 201) {
        alert(request.response);
        form.reset();
      } else {
        alert(`Request status: ${request.status} - ${request.responseText}`);
      }
    });

    request.addEventListener('error', event => {
      alert('Error! Request did not complete. Please try again.');
    });

    let data = serializeForm(form, scheduleCount);
    request.send(JSON.stringify(data));
  });
});
