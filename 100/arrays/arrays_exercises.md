## Arrays - Exercises

### Exercise 1
Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.
``` ruby
arr = [1, 3, 5, 7, 9, 11]
number = 3
```

``` ruby
arr = [1, 3, 5, 7, 9, 11]
number = 3

puts arr.include?(number)
```

---
### Exercise 2
What will the following programs return? What is value of arr after each?

**1)**
``` ruby
arr = ["b", "a"]
arr = arr.product(Array(1..3))
arr.first.delete(arr.first.last)
```
This will return `1`  
After this program, the value of `arr1` will be:
`[["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]`

**2)**
``` ruby
arr = ["b", "a"]
arr = arr.product([Array(1..3)])
arr.first.delete(arr.first.last)
```
This will return `[1, 2, 3]`  
After this program, the value of `arr1` will be:
`[["b"], ["a", [1, 2, 3]]]`

---
### Exercise 3
How do you print the word `"example"` from the following array?
``` ruby
arr = [["test", "hello", "world"],["example", "mem"]]
```

``` ruby
puts arr[1][0]
```

---
### Exercise 4
What does each method return in the following example?
``` ruby
arr = [15, 7, 18, 5, 12, 8, 5, 1]

1. arr.index(5)

2. arr.index[5]

3. arr[5]
```

1. 3
2. an error: "undefined method '[]'"
3. 8

---
### Exercise 5
What is the value of `a`, `b`, and `c` in the following program?
``` ruby
string = "Welcome to America!"
a = string[6]
b = string[11]
c = string[19]
```

`a` is `"e"`  
`b` is `"A"`  
`c` is `nil`

---
### Exercise 6
You run the following code...
``` ruby
names = ['bob', 'joe', 'susan', 'margaret']
names['margaret'] = 'jody'
```
...and get the following error message:
```
TypeError: no implicit conversion of String into Integer
  from (irb):2:in `[]='
  from (irb):2
  from /Users/username/.rvm/rubies/ruby-2.0.0-p353/bin/irb:12:in `<main>'
```
What is the problem and how can it be fixed?

#### Solution:
The error is caused by: `names['margaret']`
The bracketed array reference `names[]` expects an integer inside the brackets, but as written above, it is given a string.

If the programmer knows which index of the names array contains `'margaret'`, the error can be fixed with:
`names[3] = 'jody'`

If the programmer does not know which index of the names array contains `'margaret'`, the error can be fixed with:

if we can assume that there is only one `'margaret'`:
`names[names.index('margaret')] = 'jody'`

if there could be multiple `'margaret'`s:
``` ruby
names.each_with_index do |object, index|
  if object == 'margaret'
    names[index] = 'jody'
  end
end
```

---
### Exercise 7
Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of `2`. You should have two arrays at the end of this program: the original array and the new array you've created. Print both arrays to the screen using the `p` method instead of `puts`.

``` ruby
def incr_by_two(array)
  built = []
  array.map { |value| built.push(value + 2) }
  p array
  p built
end

array = [8, 22, 17, 34, 56, 3, 0, 91]

incr_by_two(array)
```
