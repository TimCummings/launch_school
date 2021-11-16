let inventory;

(function() {
  function sanitizeInput(root, selector) {
    let input = root.querySelector(selector).value;

    return input.replace(/[<>&'" ]/g, char => {
      switch (char) {
        case '<': return '&lt;';
        case '>': return '&gt;';
        case '&': return '&amp;';
        case '\'': return '&apos;';
        case '"': return '&quot;';
        case ' ': return '&nbsp;';
        default: return '';
      }
    });
  }

  inventory = {
    lastId: 0,
    collection: [],
    setDate: function() {
      let date = new Date();
      document.querySelector('#order_date').textContent = date.toUTCString();
    },
    cacheTemplate: function() {
      let itemTemplate = document.querySelector("#inventory_item");
      itemTemplate.remove();
      this.template = Handlebars.compile(itemTemplate.innerHTML);
    },
    add: function() {
      this.lastId++;
      let item = {
        id: this.lastId,
        name: "",
        stock_number: "",
        quantity: 1
      };
      this.collection.push(item);

      return item;
    },
    remove: function(idx) {
      this.collection = this.collection.filter(function(item) {
        return item.id !== idx;
      });
    },
    get: function(id) {
      let found_item;

      this.collection.forEach(function(item) {
        if (item.id === id) {
          found_item = item;
          return false;
        }
      });

      return found_item;
    },
    update: function(itemElement) {
      let id = this.findID(itemElement);
      let item = this.get(id);

      item.name = sanitizeInput(itemElement, "[name^=item_name]");
      item.stock_number = sanitizeInput(itemElement, "[name^=item_stock_number]");
      item.quantity = +sanitizeInput(itemElement, "[name^=item_quantity]");
    },
    newItem: function(event) {
      event.preventDefault();
      let item = this.add();
      let itemElement = this.template({ id: item.id });

      document.querySelector("#inventory tbody").insertAdjacentHTML('beforeend', itemElement);
    },
    findParent: function(event) {
      return event.target.closest("tr");
    },
    findID: function(itemElement) {
      return +itemElement.querySelector("input[type=hidden]").value;
    },
    deleteItem: function(event) {
      if (!event.target.matches('a.delete')) return;

      event.preventDefault();
      let item = this.findParent(event);
      item.remove();
      this.remove(this.findID(item));
    },
    updateItem: function(event) {
      if (!event.target.matches('input[type=text], input[type=number]')) return;

      let itemElement = this.findParent(event);
      this.update(itemElement);
    },
    bindEvents: function() {
      document.querySelector('#add_item').addEventListener('click', this.newItem.bind(this));
      document.querySelector("#inventory").addEventListener('click', this.deleteItem.bind(this));
      document.querySelector('#inventory').addEventListener('focusout', this.updateItem.bind(this));
    },
    init: function() {
      this.setDate();
      this.cacheTemplate();
      this.bindEvents();
    }
  };
})();

document.addEventListener('DOMContentLoaded', inventory.init.bind(inventory));
