## Methods - Exercises

### Exercise 1
Write a program that prints a greeting message. This program should contain a method called `greeting` that takes a `name` as its parameter and returns a string.

``` ruby
def greeting(name)
  "Hello, " + name + "!"
end

puts "What is your name?"

puts greeting(gets.chomp)
```

---
### Exercise 2
What do the following expressions evaluate to?
```
1. x = 2

2. puts x = 2

3. p name = "Joe"

4. four = "four"

5. print something = "nothing"
```

#### Solution
1. the integer `2`
2. `nil`
3. the string `"Joe"`
4. the string `"four"`
5. `nil`

---
### Exercise 3
Write a program that includes a method called `multiply` that takes two arguments and returns the product of the two numbers.

``` ruby
def multiply(x, y)
  x * y
end

puts multiply(6, 8)
```

---
### Exercise 4
What will the following code print to the screen?

``` ruby
def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")
```
#### Solution
This prints nothing to the screen. Scream returns before printing anything.

---
### Exercise 5
**1)** Edit the method definition in exercise #4 so that it does print words on the screen.

```ruby
def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee")
```

**2)** What does it return now?

This now prints `"Yippeee!!!!"` and returns `nil`.

---
### Exercise 6
What does the following error message tell you?

The method `calculate_product` was called with the wrong number of arguments (just one instead of the two expected).
