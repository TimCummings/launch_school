
# Explicit Primitive Type Coercions - 10/21/2020

We sometimes want to convert primitive JavaScript values into values of different types. For example, we may want to convert the string `'345'` into the number `345`. We call such operations **coercions** or **conversions**. However, you may recall that JavaScript primitives are immutable values: JavaScript doesn't actually convert values. Instead, it returns a new value of the proper type.

## Strings to Numbers

* `Number()` function
  * returns `NaN` if the string can't be converted to a number

```javascript
Number('1');             // 1
Number('1.234');         // 1.234
Number('abc123');        // NaN
```

* `parseInt()` function
  * takes a second optional `radix` argument to specify the base
  * it's recommended to provide `radix` to avoid confusion
  * can't process decimals; whole numbers only
  * stops at invalid characters instead of returning `NaN`

```javascript
parseInt('123', 10);     // 123
parseInt('123.12', 10);  // 123, will only return whole numbers
parseInt('123.12');      // 123
```

* `parseFloat()` function
  * similar to `parseInt()` but handles decimals

```javascript
parseFloat('123.12');    // 123.12, can handle floating point values
```

## Numbers to Strings

`String()` or `Number.prototype.toString()`:

```javascript
String(123);             // "123"
String(1.23);            // "1.23"
(123).toString();        // "123"
(123.12).toString();     // "123.12"
```

You can also concatenate a number with an empty string, but this is discouraged: the intent is not clear.

```javascript
123 + '';                // "123"
'' + 123;                // "123"
```

## Booleans to Strings

`String()` or `Boolean.prototype.toString()`:

```javascript
String(true);            // "true"
String(false);           // "false"

true.toString();         // "true"
false.toString();        // "false"
```

## Primitives to Boolean?

There is no direct coercion of strings to booleans, so simply compare against the strings `"true"` and `"false"`.

You can technically coerce a string to a boolean with `Boolean()` or `!!`, but most values will be truthy, including the string `"false"`, and that probably isn't what you want.

```javascript
Boolean(null);           // false
Boolean(NaN);            // false
Boolean(0);              // false
Boolean('');             // false
Boolean(false);          // false
Boolean(undefined);      // false
Boolean('abc');          // other values will be true
Boolean(123);            // true
Boolean('true');         // including the string 'true'
Boolean('false');        // but also including the string 'false'!
```
