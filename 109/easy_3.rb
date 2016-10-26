# easy_3.rb

# # Searching 101
# numbers = []
#
# 6.times do |n|
#   puts "Enter number #{n + 1}: "
#   numbers[n] = gets.to_i
# end
#
# last = numbers.pop
#
# if numbers.include?(last)
#   puts "#{last} appears in #{numbers.inspect}"
# else
#   puts "#{last} does not appear in #{numbers.inspect}"
# end



# # Arithmetic Integer
# puts "Enter the first number: "
# number_1 = gets.to_i
#
# puts "Enter the second number: "
# number_2 = gets.to_i
#
# puts "#{number_1} + #{number_2} = #{number_1 + number_2}"
# puts "#{number_1} - #{number_2} = #{number_1 - number_2}"
# puts "#{number_1} * #{number_2} = #{number_1 * number_2}"
# puts "#{number_1} / #{number_2} = #{number_1 / number_2}"
# puts "#{number_1} % #{number_2} = #{number_1 % number_2}"
# puts "#{number_1} ** #{number_2} = #{number_1 ** number_2}"



# # Counting the Number of Characters
# puts "Please enter one or more words: "
# words = gets.chomp
#
# chars = words.gsub(/\s/, '')
#
# puts "There are #{chars.length} characters in #{words}."



# # Multiplying Two Numbers
# def multiply(num_1, num_2)
#   num_1 * num_2
# end
#
# # puts multiply(5, 3) == 15



# # Squaring an Argument
# def square(number)
#   multiply(number, number)
# end
#
# puts square(5)
# puts square(-8)



# # Exclusive Or
# def xor?(op_1, op_2)
#   if op_1
#     if op_2
#       return false
#     else
#       return true
#     end
#   else
#     if op_2
#       return true
#     else
#       false
#     end
#   end
# end
#
# # more readable solution provided:
# def xor?(bool_1, bool_2)
#   return true if bool_1 && !bool_2
#   return true if bool_2 && !bool_1
#   false
# end

# Other uses for xor:
#   - custom shopping cart with mutually exclusive options
#   - modeling circuits (xor gates)

# Xor is not a short circuit operator; both operands must be evalauted, since the operands must not equal each other for the xor to return true.



# # Odd Lists
# def oddities(array)
#   array.select.each_with_index { |_, idx| idx.even? }
# end
#
# # same but 2nd, 4th, 6th, etc returned:
# def eventies(array)
#   array.select.each_with_index { |_, idx| idx.odd? }
# end
#
# # same but 3rd, 6th, 9th, etc returned:
# def thirdsies(array)
#   array.select.each_with_index { |_, idx| (idx + 1) % 3 == 0 }
# end



# Palindromic Strings (Part 1)
def palindrome?(string)
  string == string.reverse
end
