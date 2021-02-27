
# Practice Problems: Create Objects with Factory Functions - 1/27/2020

1. What are the two disadvantages of working with factory functions?

### Solution

Each instantied object contains a full copy of any functions in the factory's returned object. There's not a way to tell if an object was created from a specific factory function.

---

2. Rewrite the code below to use object-literal syntax to generate the returned object:

```javascript
function makeObj() {
  return {
    propA: 10,
    propB: 20,
  };
}
```

### Solution

```javascript
function makeObj() {
  return {
    propA: 10,
    propB: 20,
  };
}
```

---

3. In the following problems, we'll be working through an invoice processing program. To get you started, we provide you with the following code that can process one invoice:

```javascript
let invoice = {
  phone: 3000,
  internet: 6500,
};
let payment = {
  phone: 1300,
  internet: 5500,
};
let invoiceTotal = invoice.phone + invoice.internet;
let paymentTotal = payment.phone + payment.internet;
let remainingDue = invoiceTotal - paymentTotal;

console.log(paymentTotal);         // => 6800
console.log(remainingDue);         // => 2700
```

To be able to process multiple invoices, we'll need to have a factory method that we can use to create invoices. The requirements for this factory function are the following:

1. It returns an invoice object, with `phone` and `internet` properties, and a `total` method.
2. The default value for the phone service is `3000`, and the internet service is `5500` (in cents, of course!).
3. The function takes an object argument with attributes to override the default values.

Your implemented function should be able to work with the code below:

```javascript
function createInvoice(services) {
  // implement the factory function here
}

function invoiceTotal(invoices) {
  let total = 0;
  let i;

  for (i = 0; i < invoices.length; i += 1) {
    total += invoices[i].total();
  }

  return total;
}

let invoices = [];
invoices.push(createInvoice());
invoices.push(createInvoice({
  internet: 6500,
}));

invoices.push(createInvoice({
  phone: 2000,
}));

invoices.push(createInvoice({
  phone: 1000,
  internet: 4500,
}));

console.log(invoiceTotal(invoices));             // => 31000
```

### Solution

```javascript
function createInvoice({phone = 3000, internet = 5500} = {}) {
  return {
    phone,
    internet,

    total() {
      return this.phone + this.internet;
    },
  };
}
```

---

4. Now let's build a factory function to create payments. The function can take an `object` argument in one of 3 forms:

* Payment for one service, such as: `{internet: 1000}` or `{phone: 1000}`
* Payment for both services, such as: `{internet: 2000, phone: 1000}`.
* Payment with just an `amount` property, such as: `{amount: 2000}`.

and should return an object that has paid services, and a `total` method that returns the payment total. If the `amount` property is not present, this should return the sum of phone and internet services; if the `amount` property is present, just return the value of that property.

Your code should work with the following:

```javascript
function createPayment(services) {
  // implement the factory function here
}

function paymentTotal(payments) {
  let total = 0;
  let i;

  for (i = 0; i < payments.length; i += 1) {
    total += payments[i].total();
  }

  return total;
}

let payments = [];
payments.push(createPayment());
payments.push(createPayment({
  internet: 6500,
}));

payments.push(createPayment({
  phone: 2000,
}));

payments.push(createPayment({
  phone: 1000,
  internet: 4500,
}));

payments.push(createPayment({
  amount: 10000,
}));

console.log(paymentTotal(payments));      // => 24000
```

### Solution

```javascript
function createPayment({internet = 0, phone = 0, amount = 0} = {}) {
  return {
    internet,
    phone,
    amount,

    total() {
      if (this.amount > 0) return this.amount;
      return this.internet + this.phone;
    },
  };
}
```

---

5. Update your `createInvoice` function to make it possible to add payment(s) to invoices. Use the code below as a guideline:

```javascript
let invoice = createInvoice({
  phone: 1200,
  internet: 4000,
});

let payment1 = createPayment({
  amount: 2000,
});

let payment2 = createPayment({
  phone: 1000,
  internet: 1200,
});

let payment3 = createPayment({
  phone: 1000,
});

invoice.addPayment(payment1);
invoice.addPayments([payment2, payment3]);
invoice.amountDue();       // this should return 0
```

### Solution

```javascript
function createInvoice({phone = 3000, internet = 5500} = {}) {
  const payments = [];

  return {
    phone,
    internet,

    total() {
      return this.phone + this.internet;
    },

    addPayment(newPayment) {
      payments.push(newPayment);
    },

    addPayments(newPayments) {
      newPayments.forEach(this.addPayment);
    },

    amountDue() {
      return invoiceTotal([this]) - paymentTotal(payments);
    },
  };
}
```
