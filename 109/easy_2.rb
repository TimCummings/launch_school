# easy_2.rb

# # How old is Teddy?
# puts "What is your name?"
# name = gets.chomp
# name = 'Teddy' if name == ''
#
# ages = *(20..200)
#
# puts "#{name} is #{ages.sample} years old!"



# # How big is the room?
# SQMETERS_TO_SQFEET = 10.7639
# SQFEET_TO_SQINCHES = 144
# SQFEET_TO_SQCM = 929.03
#
# puts "What is the room's length in feet?"
# length = gets.chomp.to_f
#
# puts "What is the room's width in feet?"
# width = gets.chomp.to_f
#
# area_ft = length * width
# area_in = area_ft * SQFEET_TO_SQINCHES
# area_cm = area_ft * SQFEET_TO_SQCM
#
# puts "The room's area is:"
# puts "#{area_ft.round(2)} square feet"
# puts "#{area_in.round(2)} square inches"
# puts "#{area_cm.round(2)} square centimeters"



# # Tip Calculator
# puts "How much is the bill?"
# bill = gets.to_f
#
# puts "What percentage would you like to tip?"
# tip_percent = gets.to_f
#
# tip = (bill * (tip_percent / 100)).round(2)
#
# puts "The tip is: $#{format("%.2f", tip)}"
# puts "The total is: $#{format("%.2f", tip + bill)}"



# # When will I Retire?
# current_year = Time.now.year
#
# puts "How old are you?"
# current_age = gets.to_i
#
# puts "At what age would you like to retire?"
# retire_age = gets.to_i
#
# years = retire_age - current_age
#
# puts "It's #{current_year}. " + \
#      "You will retire in #{current_year + years}. " + \
#      "You only have #{years} years of work left!"



# # Greeting a user
# puts "What is your name?"
# name = gets.chomp
#
# if name.chars.last == '!'
#   puts "HELLO, #{name.upcase} WHY ARE WE YELLING?"
# else
#   puts "Hello, #{name}."
# end



# # Odd Numbers
# (1..99).each do |num|
#   puts num if num % 2 != 0
# end



# Even Numbers
# # based off of my odd numbers above:
# (1..99).each do |num|
#   puts num if num % 2 == 0
# end
#
# # more Ruby-like:
# (1..99).each do |num|
#   puts num if num.even?
# end
#
# # more optimized:
# num = 2
# while num <= 99
#   puts num
#   num += 2
# end



# # Sum or Product of Consecutive Integers
# def cons_sum(upper)
#   sum = (1..upper).inject(:+)
#   puts "The sum of 1 to #{upper} is: #{sum}"
# end
#
# def cons_product(upper)
#   product = (1..upper).inject(:*)
#   puts "The product of 1 to #{upper} is: #{product}"
# end
#
# puts "Please enter a positive integer: "
# number = gets.to_i
#
# puts "Please enter 's' for sum or 'p' for product:"
# operation = gets.chomp.downcase
#
# if operation.start_with?('s')
#   cons_sum(number)
# elsif operation.start_with?('p')
#   cons_product(number)
# else
#   puts "Sorry - that is not a valid selection."
# end



# # String Assignment
# The first section of code outputs:
#   Alice
#   Bob
# because the variable `name` is re-assigned to a new object (`Alice`), not mutated.
#
# The second section of code outputs:
#   BOB
#   BOB
# because the variable `name` is not reassigned; the object `name` references is mutated with the `upcase!` method.



# Mutation
# This code will print:
#  Moe
#  Larry
#  CURLY
#  CHEMP
#  Harpo
#  CHICO
#  Groucho
#  Zeppo
# because, while the `array1` and `array2` variables reference different array objects, those different array objects contain references to the same string objects. So when `<<` is used to mutate some of those objects with `upcase!`, the mutations are visiable with both array variables ()`array1` and `array2`).
