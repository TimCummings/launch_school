## Loops and Iterators - Exercises

### Exercise 1
What does the `each` method in the following program return after it is finished executing?
```ruby
x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end
```

The each method above, after it is finished executing, returns the original array, `x`: `[1, 2, 3, 4, 5]`

---
### Exercise 2
Write a `while` loop that takes input from the user, performs an action, and only stops when the user types `"STOP"`. Each loop can get info from the user.

``` ruby
puts "Please enter a command:"
input = gets.chomp

while input != "STOP"
  puts "Please enter a command:"
  input = gets.chomp
end
```

---
### Exercise 3
Use the `each_with_index` method to iterate through an array of your creation that prints each index and value of the array.

``` ruby
my_array = ['alpha', 'bravo', 'charlie', 'delta', 'epsilon']

my_array.each_with_index do |value, index|
  puts "#{index}: #{value}"
end
```

---
### Exercise 4
Write a method that counts down to zero using recursion.

``` ruby
def countdown(num)
  puts num
  if num > 0
    countdown(num - 1)
  end
end

puts "Enter a number to begin the countdown:"

countdown(gets.chomp.to_i)
```
