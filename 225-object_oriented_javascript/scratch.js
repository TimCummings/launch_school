const Item = (function() {
  function isValid(name, category, quantity) {
    return nameIsValid(name) && categoryIsValid(category)
      && quantityIsValid(quantity);
  }

  function nameIsValid(name) {
    return name.replace(/\s/g, '').length >= 5;
  }

  function categoryIsValid(category) {
    return (category.search(/\s/) === -1) && (category.length >= 5);
  }

  function quantityIsValid(quantity) {
    return quantity >= 0;
  }

  function generateSKU(name, category) {
    const NAME_LETTER_COUNT = 3;
    const CATEGORY_LETTER_COUNT = 2;

    let sku = '';
    sku += name.replace(/\s/g, '').slice(0, 3);
    sku += category.slice(0, 2);

    return sku.toUpperCase();
  }

  return {
    init(name, category, quantity) {
      if (isValid(name, category, quantity)) {
        this.sku = generateSKU(name, category);
        this.name = name;
        this.category = category;
        this.quantity = quantity;

        return this;
      } else {
        return { notValid: true };
      }
    },
  };
})();

const ItemManager = {
  items: {},

  create(name, category, quantity) {
    let item = Object.create(Item).init(name, category, quantity);
    if (item.notValid) {
      return false;
    } else {
      this.items[item.sku] = item;
      return item;
    }
  },

  update(sku, changes) {
    Object.assign(this.items[sku], changes);
  },

  delete(sku) {
    delete this.items[sku];
  },

  inStock() {
    return Object.keys(this.items)
      .filter(sku => this.items[sku].quantity > 0)
      .map(sku => this.items[sku]);
  },

  itemsInCategory(category) {
    return Object.keys(this.items)
      .filter(sku => this.items[sku].category === category)
      .map(sku => this.items[sku]);
  },
};

const ReportManager = {
  init(itemManager) {
    this.items = itemManager;
  },

  createReporter(sku) {
    return (() => {
      const item = this.items.items[sku];

      return {
        itemInfo() {
          Object.keys(item).forEach(prop => {
            console.log(`${prop}: ${item[prop]}`);
          });
        },
      };
    })();
  },

  reportInStock() {
    this.items.inStock().forEach(item => console.log(item.name));
  },
};

console.log(ItemManager.create('basket ball', 'sports', 0));           // valid item
console.log(ItemManager.create('asd', 'sports', 0));
console.log(ItemManager.create('soccer ball', 'sports', 5));           // valid item
console.log(ItemManager.create('football', 'sports'));
console.log(ItemManager.create('football', 'sports', 3));              // valid item
console.log(ItemManager.create('kitchen pot', 'cooking items', 0));
console.log(ItemManager.create('kitchen pot', 'cooking', 3));          // valid item

console.log(ItemManager.items);
// // returns list with the 4 valid items

ReportManager.init(ItemManager);
ReportManager.reportInStock();
// logs soccer ball,football,kitchen pot

ItemManager.update('SOCSP', { quantity: 0 });
console.log(ItemManager.inStock());
// returns list with the item objects for football and kitchen pot
ReportManager.reportInStock();
// // logs football,kitchen pot
console.log(ItemManager.itemsInCategory('sports'));
// returns list with the item objects for basket ball, soccer ball, and football
ItemManager.delete('SOCSP');
console.log(ItemManager.items);
// returns list with the remaining 3 valid items (soccer ball is removed from the list)

const kitchenPotReporter = ReportManager.createReporter('KITCO');
kitchenPotReporter.itemInfo();
// logs
// skuCode: KITCO
// itemName: kitchen pot
// category: cooking
// quantity: 3

ItemManager.update('KITCO', { quantity: 10 });
kitchenPotReporter.itemInfo();
// logs
// skuCode: KITCO
// itemName: kitchen pot
// category: cooking
// quantity: 10
