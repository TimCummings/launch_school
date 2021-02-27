
# Banking with Objects and Closures - 1/14/2021

In this assignment, we'll build a small banking application and look at how we can use closures to control access to the application's data. We'll proceed through this assignment using some example code and then you will write code that satisfies it.

1. Create an object named `account` that represents a bank account. It should contain a `balance` property that stores the account's current balance.

### Solution

```javascript
let account = {
  balance: 0,
};
```

---

2. Add a `deposit` method to the `account` object that takes a single argument, the value of the deposit. `deposit` adds the value of argument passed to it to the account's balance, and then returns it.

```javascript
> account.balance;
= 0
> account.deposit(12);
= 12
> account.balance;
= 12
> account.deposit(10);
= 10
> account.balance;
= 22
```

### Solution

```javascript
let account = {
  balance: 0,

  deposit(amount) {
    this.balance += amount;
    return amount;
  },
};
```

---

3. Add a `withdraw` method to the `account` object that takes a single argument, the amount to withdraw. It should subtract the amount from the account's balance and return the amount subtracted.

```javascript
> account.balance;
= 100
> account.withdraw(19);
= 19
> account.balance;
= 81
```

If the account contains less than the withdrawal amount, the method should limit the withdrawal to the amount available, and return the actual amount withdrawn. This should leave the account with a balance of `0`.

```javascript
> account.balance;
= 81
> account.withdraw(91);
= 81
> account.balance;
= 0
```

### Solution

```javascript
let account = {
  balance: 0,

  deposit(amount) {
    this.balance += amount;
    return amount;
  },
  withdraw(amount) {
    if (amount > this.balance) amount = this.balance;

    this.balance -= amount;
    return amount;
  },
};
```

---

4. Each account should have a record of every deposit and withdrawal applied to it. To do this, add a property named `transactions` to `account` that contains an array of transactions, each of which is an object with `type` and `amount` properties.

```javascript
> account.deposit(23);
= 23
> account.transactions;
= [{...}]
> account.transactions[0];
= {type: "deposit", amount: 23}
```

### Solution

```javascript
let account = {
  balance: 0,
  transactions: [],

  deposit(amount) {
    this.balance += amount;
    this.transactions.push({ type: 'deposit', amount });
    return amount;
  },
  withdraw(amount) {
    if (amount > this.balance) amount = this.balance;

    this.balance -= amount;
    this.transactions.push({ type: 'withdrawal', amount });
    return amount;
  },
};
```

---

5. We want to create more than one account. Move the account creation code to a function named `makeAccount` that returns a new account object.

```javascript
> let account = makeAccount();
> account.deposit(15);
= 15
> account.balance;
= 15
> let otherAccount = makeAccount();
> otherAccount.balance;
= 0
```

### Solution

```javascript
```

---

6. We also need an object to manage accounts: a bank. Create a function that returns an object that represents a bank. The bank should have a property named `accounts` that represents a list of accounts.

```javascript
> let bank = makeBank();
> bank.accounts;
= []
```

### Solution

```javascript
function makeBank() {
  return {
    accounts: [],
  };
}
```

---

7. Add a new method named `openAccount` to the object returned by `makeBank`. It should create a new account, add it to the bank's `accounts` collection, and return the new account. Each new account should have a unique account number, starting at `101`; each account number should be one greater than the previous account created.

```javascript
> let bank = makeBank();
> let account = bank.openAccount();
> account.number;
= 101
> bank.accounts;
= [{...}]
> bank.accounts[0];
= {number: 101, balance: 0, transactions: Array[0]}
> let secondAccount = bank.openAccount();
> secondAccount.number;
= 102
```

### Solution

```javascript
function makeAccount() {
  return {
    balance: 0,
    transactions: [],

    deposit(amount) {
      this.balance += amount;
      this.transactions.push({ type: 'deposit', amount });
      return amount;
    },
    withdraw(amount) {
      if (amount > this.balance) amount = this.balance;

      this.balance -= amount;
      this.transactions.push({ type: 'withdrawal', amount });
      return amount;
    },
  };
}

function makeBank() {
  return {
    accounts: [],
    nextAccountNumber: 101,

    openAccount() {
      let account = makeAccount();
      account.number = this.nextAccountNumber;
      this.nextAccountNumber += 1;
      this.accounts.push(account);

      return account;
    },
  };
}
```

#### Adjustments based on provided solution

Add account number via a `number` parameter in the `makeAccount` function. The `openAccount` function can pass the appropriate number to `makeAccount` by offsetting the length of its `accounts` array; I can take this a step further by making the minimum account number a private constant:

```javascript
function makeAccount(number) {
  return {
    number,
    balance: 0,
    transactions: [],

    deposit(amount) {
      this.balance += amount;
      this.transactions.push({ type: 'deposit', amount });
      return amount;
    },

    withdraw(amount) {
      if (amount > this.balance) amount = this.balance;

      this.balance -= amount;
      this.transactions.push({ type: 'withdrawal', amount });
      return amount;
    },
  };
}

function makeBank() {
  const MIN_ACCOUNT_NUMBER = 101;

  return {
    accounts: [],

    openAccount() {
      let number = this.accounts.length + MIN_ACCOUNT_NUMBER;
      let account = makeAccount(number);
      this.accounts.push(account);
      return account;
    },
  };
}
```

---

8. Add a new method to the bank object that transfers money from one account to another.

```javascript
> let bank = makeBank();
> let source = bank.openAccount();
> source.deposit(10);
= 10
> let destination = bank.openAccount();
> bank.transfer(source, destination, 7);
= 7
> source.balance;
= 3
> destination.balance;
= 7
```

### Solution

```javascript
function makeBank() {
  const MIN_ACCOUNT_NUMBER = 101;

  return {
    accounts: [],

    openAccount() {
      let number = this.accounts.length + MIN_ACCOUNT_NUMBER;
      let account = makeAccount(number);
      this.accounts.push(account);
      return account;
    },

    transfer(source, destination, amount) {
      let withdrawnAmount = source.withdraw(amount);
      return destination.deposit(withdrawnAmount);
    },
  };
}
```

---

9. Change the code so that users can access the account balance, account number, and transactions list by calling methods, but not by directly accessing those properties.

```javascript
> let bank = makeBank();
> let account = bank.openAccount();
> account.balance();
= 0
> account.deposit(17);
= 17
> let secondAccount = bank.openAccount();
> secondAccount.number();
= 102
> account.transactions();
= [Object]
```

### Solution

```javascript
function makeAccount(number) {
  let balance = 0;
  let transactions = [];

  return {
    balance() {
      return balance;
    },

    deposit(amount) {
      balance += amount;
      transactions.push({ type: 'deposit', amount });
      return amount;
    },

    number() {
      return number;
    },

    transactions() {
      return transactions;
    },

    withdraw(amount) {
      if (amount > balance) amount = balance;

      balance -= amount;
      transactions.push({ type: 'withdrawal', amount });
      return amount;
    },
  };
}
```

---

10. Change the code so that users can no longer access the list of accounts.

```javascript
> let bank = makeBank();
> bank.accounts;
= undefined
```

### Solution

```javascript
function makeBank() {
  const MIN_ACCOUNT_NUMBER = 101;
  let accounts = [];

  return {
    openAccount() {
      let number = accounts.length + MIN_ACCOUNT_NUMBER;
      let account = makeAccount(number);
      accounts.push(account);
      return account;
    },

    transfer(source, destination, amount) {
      let withdrawnAmount = source.withdraw(amount);
      return destination.deposit(withdrawnAmount);
    },
  };
}
```
