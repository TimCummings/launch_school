
# Implicit Primitive Type Coercions - 10/22/2020

In several cases, when the types of an operator's operands don't match, JavaScript will change one's type to what it thinks is suitable. This is **implicit type coercion**:

```javascript
1 + true       // true is coerced to the number 1, so the result is 2
'4' + 3        // 3 is coerced to the string '3', so the result is '43'
false == 0     // false is coerced to the number 0, so the result is true
```

In most other programming languages, such type mis-matches will produce exceptions or errors, but JavaScript tries silently to make them work. While this seems convenient, it tends to make bugs more likely and leads them to undetected for longer. We'll walk through the more common implicit conversions you're likely to encounter. Avoid these as a rule, but be aware of them since you're likely to encounter their use (both intentionally and not.)

## The Plus (+) Operator

### Unary Plus

The unary plus operator converts a value into a number, following the same rules as the `Number` function:

```javascript
+('123')       // 123
+(true)        // 1
+(false)       // 0
+('')          // 0
+(' ')         // 0
+('\n')        // 0
+(null)        // 0
+(undefined)   // NaN
+('a')         // NaN
+('1a')        // NaN
```

### Binary Plus

The binary plus operator means either addition for numbers or concatenation for strings. When used with mixed operands that include a string, JavaScript converts the other operand to a string and performs concatenation:

```javascript
'123' + 123   // "123123"
123 + '123'   // "123123"
null + 'a'    // "nulla"
'' + true     // "true"
```

When both operands are a combination of numbers, booleans, nulls, or undefineds, they are converted to numbers and added together:

```javascript
1 + true        // 2
1 + false       // 1
true + false    // 1
null + false    // 0
null + null     // 0
1 + undefined   // NaN
```

In the last example above, `undefined` is coerced to `NaN`. `1 + NaN` is `NaN`.

When one of the operands is an object (including arrays and functions), both operands are converted to strings and concatenated:

```javascript
[1] + 2                    // "12"
[1] + '2'                  // "12"
[1, 2] + 3                 // "1,23"
[] + 5                     // "5"
[] + true                  // "true"
42 + {}                    // "42[object Object]"
(function foo() {}) + 42   // "function foo() {}42"
```

## Other Arithmetic Operators

The other arithmetic operators `-`, `*`, `/`, `%` are only defined for numbers so JavaScript converts both operands to numbers:

```javascript
1 - true       // 0
'123' * 3      // 369
'8' - '1'      // 7
-'42'          // -42
null - 42      // -42
false / true   // 0
true / false   // Infinity
'5' % 2        // 1
```

## Equality Operators

Recall that strict equality operators `===`, `!==` don't perform coercion and only return true (`===`) or false (`!==`) if their operands have the same **value** *and* **type**. The non-strict equality operators coerce operands of different types based on the following rules:

1. When one operand is a string and one is a number, the string is converted into a number:

```javascript
'42' == 42   // true: 42 == 42
42 == '42'   // true: 42 == 42
42 == 'a'    // false: 42 == NaN
0 == ''      // true: 0 == 0
0 == '\n'    // true: 0 == 0
```

2. When one operand is a boolean, it is converted to a number:

```javascript
42 == true       // false: 42 == 1
0 == false       // true: 0 == 0
'0' == false     // true: '0' == 0, then 0 == 0 (two conversions)
'' == false      // true: '' == 0, then 0 == 0
true == '1'      // true: 1 == '1', then 1 == 1
true == 'true'   // false: 1 == 'true', then 1 == NaN
```

3. When one operand is `null` and the other is `undefined`, the non-strict operator always returns `true`. If both operands are `null` or both are `undefined`, the return value is `true`. Comparing `null` or `undefined` to all other values returns `false`:

```javascript
null == undefined        // true
undefined == null        // true
null == null             // true
undefined == undefined   // true
undefined == false       // false
null == false            // false
undefined == ''          // false
undefined === null       // false - note strict comparison!
```

4. When at least one of the operands is `NaN`, the comparison always returns `false`:

```javascript
NaN == 0      // false
NaN == NaN    // false
NaN === NaN   // false - note strict comparison!
NaN != NaN    // true - NaN is the only JavaScript value to not equal itself!
```

## Relational Operators

The relational operators `<`, `>`, `<=`, `>=` are defined for numbers (numeric comparison) and strings (lexicographic order.) There are no strict versions of these operators. When both operands are strings, they're compared lexicographically. Otherwise, JavaScript converts both operands to numbers before comparing them.

```javascript
11 > '9'         // true: 11 > 9
'11' > 9         // true: 11 > 9
123 > 'a'        // false: 123 > NaN (any comparison with NaN returns false)
123 <= 'a'       // false: same as above
true > null      // true: 1 > 0
true > false     // true: 1 > 0
null <= false    // true: 0 <= 0
undefined >= 1   // false: NaN >= 1
```

## Best Practices

Understanding JavaScript's implicit type coercions is important when you're debugging code. However, when you're writing your own programs, it's best to:

* **always use explicit type coercions**
* **always use strict equality operators**

Clearly show your intentions and be explicit.

> Our advice to avoid `==` and `!=` isn't universal. There are JavaScript developers, including some well-known ones, who will tell you to go ahead and use the loose operators, `==` and `!=`; some even recommend preferring it. Their reasoning is easy to understand: your code should not be attempting to compare different kinds of things, except in a few well-defined, isolated cases. Using the strict operators as a workaround is just masking bad code. They're not wrong! If you're comparing strings with arrays, your code is almost certainly needs a redesign.
>
> That said, you need to be aware of some edge cases with the loose operators. For that reason, the style we use at Launch School insists that you always use the strict operators. Doing so won't prevent you from fixing bad code, but at this stage of your journey, it's less confusing to use the strict operators, and easier to debug.
