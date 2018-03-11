# easy_8.rb

# # Sum of Sums
# def sum_of_sums(numbers)
#   result = 0
#   numbers.each_with_index do |num, idx|
#     result += (num * (numbers.size - idx))
#   end
#
#   result
# end



# # Madlibs
# def madlibs
#   puts "Please enter a noun: "
#   noun = gets.chomp
#
#   puts "Please enter a verb: "
#   verb = gets.chomp
#
#   puts "Please enter an adjective: "
#   adjective = gets.chomp
#
#   puts "Please enter an adverb: "
#   adverb = gets.chomp
#
#   puts "Do you #{verb} your #{adjective} #{noun} #{adverb}? That's hilarious!"
# end



# # Leading Substrings
# # Modified in #5 to ignore case and non alphabetic characters
# def substrings_at_start(string)
#   sanitized_string = string.downcase.gsub(/[^a-z]/, '')
#   substrings = []
#   1.upto(string.size) do |sub_length|
#     substrings.push(sanitized_string.slice(0, sub_length))
#   end
#
#   substrings
# end



# # All Substrings
# def substrings(string)
#   all_substrings = []
#   0.upto(string.size - 1) do |sub_start|
#     all_substrings.push(substrings_at_start(string[sub_start..-1]))
#   end
#
#   all_substrings.flatten
# end



# # Palindromic Substrings
# def palindrome?(string)
#   (string.length > 1) && (string == string.reverse)
# end
#
# def palindromes(string)
#   result = substrings(string)
#   result.select { |substring| palindrome?(substring) }
# end



# # fizzbuzz
# FIZZ = 3
# BUZZ = 5
#
# def div_by?(number, x = 3)
#   number % x == 0
# end
#
# def fizzbuzz(start, finish)
#   output = []
#   start.upto(finish) do |num|
#     if div_by?(num, FIZZ) && div_by?(num, BUZZ)
#       output.push('FizzBuzz')
#     elsif div_by?(num, FIZZ)
#       output.push('Fizz')
#     elsif div_by?(num, BUZZ)
#       output.push('Buzz')
#     else
#       output.push(num)
#     end
#   end
#
#   puts output.join(', ')
# end



# # Double Char (Part 1)
# def repeater(string)
#   string.chars.map { |char| char + char }.join
# end


# # Double Char (Part 2)
# CONSONANTS = %w(b c d f g h j k l m n p q r s t v w x y z)
#
# def double_consonants(string)
#   result = []
#   string.chars.each do |char|
#     result << char
#     result << char if CONSONANTS.include?(char.downcase)
#   end
#
#   result.join
# end



# # Convert number to reversed array of digits
# def reversed_number(num)
#   digits = num.to_s.chars.reverse.join.to_i
# end



# Get The Middle Character
def center_of(string)
  middle_idx = (string.size / 2)
  if string.size.even?
    string[(middle_idx - 1), 2]
  else
    string[middle_idx]
  end
end
