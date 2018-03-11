# easy_1.rb

# # Repeat Yourself
# def repeat(string, number)
#   number.times { puts string }
# end

# # repeat("hello", 3)



# # Odd
# def is_odd?(num)
#   num % 2 != 0 && num == num.to_i
# end

# # better solution (provided):
# num % 2 == 1

# puts is_odd?(2)    # => false
# puts is_odd?(5)    # => true
# puts is_odd?(-17)  # => true
# puts is_odd?(-8)   # => false
# puts is_odd?(7.1)  # => false
# puts is_odd?(-5.0) # => true



# # List of Digits
# def digit_list(num)
#   num.to_s.chars.map { |digit| digit.to_i }
# end

# puts digit_list(12345) == [1, 2, 3, 4, 5]
# puts digit_list(7) == [7]
# puts digit_list(375290) == [3, 7, 5, 2, 9, 0]
# puts digit_list(444) == [4, 4, 4]



# # How Many?
# def count_occurrences(arr)
#   occurrences = Hash.new

#   arr.each do |item|
#     if occurrences[item] == nil
#       occurrences[item] = 1
#     else
#       occurrences[item] += 1
#     end
#   end

#   occurrences.each { |key, value| puts "#{key} => #{value}" }
# end

# vehicles = ['car', 'car', 'truck', 'car', 'SUV', 'truck', 'motorcycle', 'motorcycle', 'car', 'truck']

# count_occurrences(vehicles)



# # Reverse It (Part 1)
# def reverse_sentence(sentence)
#   words = sentence.split
#   ecnetnes = []
#   words.each { |word| ecnetnes.unshift(word) }
#   ecnetnes.join(' ')
# end
#
# # better solution (provided):
# def reverse_sentence(string)
#   string.split.reverse.join(' ')
# end
#
# puts reverse_sentence('') == ''
# puts reverse_sentence('Hello World') == 'World Hello'
# puts reverse_sentence('Reverse these words') == 'words these Reverse'



# # Reverse It (Part 2)
# def reverse_words(string)
#   string = string.split.map do |word|
#     if word.size > 4
#       word.reverse
#     else
#       word
#     end
#   end
#
#   string.join(' ')
# end
#
# puts reverse_words('Professional')          # => lanoisseforP
# puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
# puts reverse_words('Launch School')         # => hcnuaL loohcS



# # Stringy Strings
# def stringy(num, first = 1)
#   if first == 0
#     remainder = 1
#   else
#     remainder = 0
#   end
#
#   string = ""
#   num.times { |x| string.concat x % 2 == remainder ? '1' : '0' }
#   string
# end
#
# puts stringy(6) == '101010'
# puts stringy(9) == '101010101'
# puts stringy(4) == '1010'
# puts stringy(7) == '1010101'
#
# puts stringy(6, 0) == '010101'
# puts stringy(9, 0) == '010101010'
# puts stringy(4, 0) == '0101'
# puts stringy(7, 0) == '0101010'



# # Array Average
# def average(numbers)
#   sum = 0
#   numbers.each { |num| sum += num }
#   sum.to_f / numbers.size
# end
#
# puts average([1, 5, 87, 45, 8, 8]) == 25
# puts average([9, 47, 23, 95, 16, 52]) == 40



# # Sum of Digits
# def sum(num)
#   digits = num.to_s.chars
#   sum = 0
#   digits.each { |x| sum += x.to_i }
#   sum
# end
#
# puts sum(23) == 5
# puts sum(496) == 19
# puts sum(123_456_789) == 45



# What's my Bonus?
def calculate_bonus(salary, bonus)
  bonus ? salary / 2 : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000
