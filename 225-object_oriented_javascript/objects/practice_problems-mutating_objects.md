
# Practice Problems: Mutating Objects - 12/9/2020


## 1. What will the code below output to the console?

```javascript
let message = 'Hello from the global scope!';

function func(message) {
  message = 'Hello from the function scope!';
  console.log(message);
}

func(message);
console.log(message);
```

### Solution

This will log:

```
Hello from the function scope!
Hello from the global scope!
```

---

## 2. What will the code below log to the console? What does this output demonstrate in relation to the output of problem one?

```javascript
let myObj = { message: 'Greetings from the global scope!' };

function func(obj) {
  obj.message = 'Greetings from the function scope!';
  console.log(obj.message);
}

func(myObj);

console.log(myObj.message);
```

### Solution

This will log:

```
Greetings from the function scope!
Greetings from the function scope!
```

This demonstrates that objects in JavaScript are passed by reference, as opposed to primitive values which are passed by value.

---

## 3. What will the code below log to the console?

```javascript
let message = 'Hello from the global scope!';

function func() {
  message = 'Hello from the function scope!';
  console.log(message);
}

func();
console.log(message);
```

### Solution

This will log:

```
Hello from the function scope!
Hello from the function scope!
```

---

## 4. What will the code below log to the console?

```javascript
let a = 10;
let obj = {
  a
}

let newObj = obj;
newObj.a += 10;

console.log(obj.a === a);
console.log(newObj.a === obj.a);
```

### Solution

This will log:

```
false
true
```

---

## 5. Consider the code below:

```javascript
let animal = {
  name: 'Pumbaa',
  species: 'Phacochoerus africanus',
};

let menagerie = {
  warthog: animal,
};

animal = {
  name: 'Timon',
  species: 'Suricata suricatta',
};

menagerie.meerkat = animal;

menagerie.warthog === animal; // false
menagerie.meerkat === animal; // true
```

If objects are mutable, why does the second to last line return false?

### Solution

While objects are mutable, `animal` is not mutated on line 10; it's reassigned to a different object.
