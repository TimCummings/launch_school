
[comment]: # (easy_testing.md)

# Easy Testing - 9/6/2017

---
## 1. Boolean Assertions
Write a minitest assertion that will fail if the `value.odd?` is not true.

### Solution
``` ruby
  assert(value.odd?)
```

#### Refactored based on provided solution
For most assertions, the default failure message is "good enough". However, `assert`'s failure message is usually vague. Specify a more explicit one when using `assert`:
``` ruby
assert value.odd?, 'value is not odd'
```

Also, if you want to test whether or not your method returns `true` (and not just a truthy value), do the following:
``` ruby
assert_equal true, value.odd?
```

---
## 2. Equality Assertions
Write a minitest assertion that will fail if `value.downcase` does not return `'xyz'`.

### Solution
``` ruby
assert_equal 'xyz', value.downcase
```

---
## 3. Nil Assertions
Write a minitest assertion that will fail if `value` is not `nil`.

### Solution
``` ruby
assert_nil value
```

---
## 4. Empty Object Assertions
Write a minitest assertion that will fail if the Array `list` is not empty.

### Solution
``` ruby
assert_empty list
```

## 5. Included Object Assertions
Write a minitest assertion that will fail if the `'xyz'` is not in the Array `list`.

### Solution
``` ruby
assert_includes list, 'xyz'
```

---
## 6. Exception Assertions
Write a minitest assertion that will fail unless `employee.hire` raises a `NoExperienceError` exception.

### Solution
``` ruby
assert_raises(NoExperienceError) { employee.hire }
```

---
## 7. Type Assertions
Write a minitest assertion that will fail if `value` is not an instance of the `Numeric` class exactly. `value` may not be an instance of one of `Numeric`'s superclasses.

### Solution
``` ruby
assert_instance_of Numeric, value
```

---
## 8. Kind Assertions
Write a minitest assertion that will fail if the class of `value` is not `Numeric` or one of `Numeric`'s subclasses (e.g. `Integer`, `Fixnum`, `Float`, etc.)

### Solution
``` ruby
assert_kind_of Numeric, value
```

---
## 9. Same Object Assertions
Write a unit test that will fail if `list` and the return value of `list.process` are different objects.

### Solution
``` ruby
assert_same list, list.process
```

---
## 10. Refutations
Write a unit test that will fail if `'xyz'` is one of the elements in the `Array` `list`.

### Solution
``` ruby
refute_includes list, 'xyz'
```
