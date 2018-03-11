# medium_1.rb

# Question 1
# (0..9).each { |count| puts((" " * count) + "The Flintstones Rock!") }

# Question 2
# letter_count = {}
# statement.each_char do |char|
#   if letter_count.has_key?(char)
#     letter_count[char] += 1
#   else
#     letter_count[char] = 1
#   end
# end

# Question 3
  # This statement is trying to add a string and an integer.
  # 1) puts "the value of 40 + 2 is " + (40 + 2).to_s
  # 2) sum = 40 + 2
  #    puts "the value of 40 + 2 is #{sum}"

# Question 4
# It won't cause problems to modify the ITEMS INSIDE an array while iterating, but modifying the array itself can cause problems such as causing the iteration to skip or repeat some entries in the array
# The first set of statements will output:
  # 1
  # 3
# The second set of statements will output:
  # 1
  # 2

# Question 5
# def factors(number)
#   divisors = []
#   if number > 0
#     (1..number).each do |dividend|
#       divisors << dividend if number % dividend == 0
#     end
#     divisors
#   else
#     divisors
#   end
# end
  # Bonus 1: number % dividend == 0 is used to find the remainder of number / dividend so that we know whether dividend is a factor (if % == 0) or not (% != 0)
  # Bonus 2: This ensures divisors is the last statement in the loop so that the method returns the correct value

# Question 6
# rolling_buffer1 will modify the buffer "buffer" that is passed to it; rolling_buffer2 does not modify the buffer "input_array" that is passed to it
# the shovel operator << modifies the memory space instead of making a new copy in memory space; the assignment operator = will assign new memory space

# Question 7
# the "limit" variable is defined outside the scope of the "fib" method and is not passed to "fib" for its use
# To resolve this error, you could
  # 1) define limit as a constant: LIMIT = 15, or
  # 2) you could pass limit to fib:
  #     def fib(first_num, second, num, limit)
  #     ...
  #     end
  #
  #     result = fib(0, 1, limit)

# Question 8
# def titleize(string)
#   words = string.split
#   words.each { |word| word.capitalize! }
#   words.join(' ')
# end

# Question 9
# def ageism(age)
#   case age
#   when (0..17)
#     'kid'
#   when (18..64)
#     'adult'
#   else
#     'senior'
#   end
# end
#
# munsters.each_value do |info|
#   info["age_group"] = ageism(info["age"])
# end
