# Exercise 1
def greeting(name)
  "Hello, " + name + "!"
end

puts "What is your name?"

puts greeting(gets.chomp)



# Exercise 2
# 1. the integer 2
# 2. nil
# 3. the string "Joe"
# 4. the string "four"
# 5. nil



# Exercise 3
def multiply(x, y)
  x * y
end

puts multiply(6, 8)



# Exercise 4
def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")
# This prints nothing to the screen. Scream returns before printing anything.



# Exercise 5
def scream(words)
  words = words + "!!!!"
  puts words
end

scream("Yippeee")
# This now prints "Yippeee!!!!" and returns nil.



# Exercise 6
# The method "calculate_product" was called with the wrong number of arguments (just one instead of the two expected).
