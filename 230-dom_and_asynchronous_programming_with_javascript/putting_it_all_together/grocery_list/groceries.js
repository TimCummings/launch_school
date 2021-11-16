class GroceryList {
  constructor(selector) {
    this.items = [];
    this.list = document.querySelector(selector);
  }

  add(name, quantity) {
    quantity = quantity || '1'
    let item = quantity + ' ' + name;
    this.items.push(item);

    let listItem = document.createElement('li');
    listItem.textContent = item;
    this.list.appendChild(listItem);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const list = new GroceryList('#grocery-list');

  const form = document.querySelector('form');
  form.addEventListener('submit', event => {
    event.preventDefault();

    const name = document.getElementById('name').value;
    const quantity = document.getElementById('quantity').value;

    list.add(name, quantity);

    form.reset();
  });
});
