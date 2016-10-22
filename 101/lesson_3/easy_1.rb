# easy_1.rb

# Question 1
# This will print the original numbers array: [1, 2, 2, 3] like so:
# 1
# 2
# 2
# 3

# Question 2
# ! is used for negation or to indicate destruction
# ? is used to create single character strings, start a conditional, or indicate a boolean return

  # 1) != is an inequality boolean comparison to determine if two things are unequal or not

  # 2) ! before something will negate it: !true evaluates to false

  # 3) ! at the end of a method indicates the method is destructive/mutates the caller

  # 4) ? before a single character creates a single character string or can be used with : to start a ternary conditional

  # 5) ? at the end of a method idicates it returns a boolean value

  # 6) !! before something results in a double negation and acts as a shortcut to translate something to a boolean value

# Question 3
# advice.gsub!("important", "urgent")

# Question 4
# numbers.delete_at(1) removes the item from numbers at index 1 (removes 2); afterwards, numbers = [1, 3, 4, 5]
# numbers.delete(1) removes all occurrences of 1 in numbers; afterwards, numbers = [2, 3, 4, 5]

# Question 5
# range = (10..100).to_a
# range.include?(42)

# Question 6
# famous_words = "seven years ago..."
  # 1) famous_words = "Four score and " + famous_words
  # 2) famous_words.insert(0, "Four score and seven ")

# Question 7
# It will not print anything but it will return 42; number will still be 2.

# Question 8
# flintstones.flatten!

# Question 9
# flintstones.assoc("Barney")

# Question 10
# flintstones.collect!.with_index { |item, index|
#   [item, index + 1]}
# flintstones.to_h
