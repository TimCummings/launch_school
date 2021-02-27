
# Objects and Closures - 1/14/2021

## Problems

Reimplement `makeList`, so that it returns an Object that provides the interface shown above, including `add`, `list`, and `remove` methods.

### Solution

```javascript
function makeList() {
  let items = [];

  return {
    add(todo) {
      let index = items.indexOf(todo);
      if (index === -1) {
        items.push(todo);
        console.log(`${todo} added!`);
      } else {
        console.log(`${todo} is already on the list, nothing added.`);
      }
    },
    list() {
      if (items.length === 0) {
        console.log('The list is empty.');
      } else {
        items.forEach(item => console.log(item));
      }
    },
    remove(todo) {
      let index = items.indexOf(todo);
      if (index === -1) {
        console.log(`Could not find ${todo}, nothing removed.`);
      } else {
        items.splice(index, 1);
        console.log(`${todo} removed!`);
      }
    },
  };
}
```

#### Adjustments based on provided solution

`items` should be a property on the returned object now, not a local variable.

```javascript
function makeList() {
  return {
    items: [],

    add(item) {
      let index = this.items.indexOf(item);
      if (index === -1) {
        this.items.push(item);
        console.log(`${item} added!`);
      } else {
        console.log(`${item} is already on the list, nothing added.`);
      }
    },
    list() {
      if (this.items.length === 0) {
        console.log('The list is empty.');
      } else {
        this.items.forEach(item => console.log(item));
      }
    },
    remove(item) {
      let index = this.items.indexOf(item);
      if (index === -1) {
        console.log(`Could not find ${item}, nothing removed.`);
      } else {
        this.items.splice(index, 1);
        console.log(`${item} removed!`);
      }
    },
  };
}
```

---

2. Notice that the solution lets us access the array of items through the items property:

```javascript
> list.items;            // items accessible from outside object
= ['corn']               // since it is an object property
```

This was not the case in the single-function implementation:

```javascript
> list.items;            // items not accessible from outside function
= undefined              // since it is within a closure
```

Update the implementation from problem 1 so that it retains the use of an object with methods but prevents outside access to the items the object stores internally.

### Solution

```javascript
function makeList() {
  let items = [];

  return {
    add(item) {
      let index = items.indexOf(item);
      if (index === -1) {
        items.push(item);
        console.log(`${item} added!`);
      } else {
        console.log(`${item} is already on the list, nothing added.`);
      }
    },
    list() {
      if (items.length === 0) {
        console.log('The list is empty.');
      } else {
        items.forEach(item => console.log(item));
      }
    },
    remove(item) {
      let index = items.indexOf(item);
      if (index === -1) {
        console.log(`Could not find ${item}, nothing removed.`);
      } else {
        items.splice(index, 1);
        console.log(`${item} removed!`);
      }
    },
  };
}
```
