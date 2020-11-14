
# Object Properties - 11/2/2020

## Property Names and Values

A property name for an object can be any valid *string*. A property value can be any valid *expression*:

```javascript
let object = {
  a: 1,                            // `a` is a string with quotes omitted
  'foo': 2 + 1,                    // property name with quotes
  'two words': 'this works too',   // a two word string
  true: true,                      // property name is implicitly converted to string "true"
  b: {                             // object as property value
    name: 'Jane',
    gender: 'female',
  },
  c: function () {                 // function expression as property value
    return 2;
  },
  d() {                            // compact method syntax
    return 4;
  },
};
```

## Accessing Property Values

You can use either dot notation or bracket notation (style guides usually suggest dot notation where possible):

```javascript
let object = {
  a: 'hello',
  b: 'world',
};

object.a;      // "hello", dot notation
object['b'];   // "world", bracket notation
object.c;      // `undefined` when property is not defined

let foo = {
  a: 1,
  good: true,
  'a name': 'hello',
  person: {
    name: 'Jane',
    gender: 'female',
  },
  c: function () {   // function expression as property value
    return 2;
  },
  d() {
    return 4;        // compact method syntax
  },
};

foo['a name'];       // "hello": must use bracket notation when property name is an invalid identifier
foo['goo' + 'd'];    // true: bracket notation can take expressions
let a = 'a';
foo[a];              // 1: bracket notation works with variables since they are expressions
foo.person.name;     // "Jane", dot notation can be chained to dig into nested objects
foo.c();             // 2: call the method 'c'
foo.d();             // 4: call the method 'd'
```

## Adding and Updating Properties

To add a new property or update an existing property, use either dot notation or bracket notation along with assignment:

```javascript
let object = {};

object.a = 'foo';
object.a;           // "foo"

object['a name'] = 'hello';
object['a name'];   // "hello"

object;             // { a: "foo" }
```

To remove a property, use the reserved keyword `delete`:

```javascript
let foo = {
  a: 'hello',
  b: 'world',
};

delete foo.a;
foo;            // { b: "world" }
```
