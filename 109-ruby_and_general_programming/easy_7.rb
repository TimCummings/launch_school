# easy_7.rb

# # Combine Two Lists
# def interleave(array_1, array_2)
#   combination = []
#   array_1.each_index do |idx|
#     combination.push(array_1[idx])
#     combination.push(array_2[idx])
#   end
#   combination
# end
#
# # using Array#zip
# def interleave(array_1, array_2)
#   array_1.zip(array_2).flatten
# end



# # Lettercase Counter
# def letter_case_count(string)
#   result = {}
#   result[:lowercase] = string.count('a-z')
#   result[:uppercase] = string.count('A-Z')
#   result[:neither] = string.size - result[:lowercase] - result[:uppercase]
#   result
# end



# # Capitalize Words
# def word_cap(string)
#   words = string.split
#   words.map { |word| word.capitalize }.join ' '
# end
#
# # without String#capitalize
# def word_cap(string)
#   result = []
#   words = string.split
#
#   words.each do |word|
#     result.push(ordinal_capitalize(word))
#   end
#
#   result.join ' '
# end
#
# def ordinal_capitalize(word)
#   characters = word.chars
#   if characters.first.ord > 96 && characters.first.ord < 123
#     first_letter = characters.shift
#     first_letter = (first_letter.ord - 32).chr
#     characters.unshift(first_letter)
#   end
#
#   characters.join
# end



# # Swapcase
# def swapcase(string)
#   characters = string.chars
#
#   characters.map do |character|
#     if lowercase?(character)
#       character.upcase!
#     elsif uppercase?(character)
#       character.downcase!
#     end
#   end
#
#   characters.join
# end
#
# def lowercase?(letter)
#   letter.ord > 96 && letter.ord < 123
# end
#
# def uppercase?(letter)
#   letter.ord > 64 && letter.ord < 91
# end



# # Staggered Caps (Part 1)
#   # uses lowercase? and uppercase? methods from previous exercise
# def staggered_case(string)
#   result = string.chars.map.with_index do |char, idx|
#     if idx.even? && lowercase?(char)
#       char.upcase!
#     elsif idx.odd? && uppercase?(char)
#       char.downcase!
#     else
#       char
#     end
#   end
#
#   result.join
# end
#
# # Modified so caller can choose whether first character is upper or lower case
# def staggered_case(string, first_char_uppercase: true)
#   result = string.chars.map do |char|
#     if first_char_uppercase
#       char.upcase!
#     else
#       char.downcase!
#     end
#
#     first_char_uppercase = !first_char_uppercase
#     char
#   end
#
#   result.join
# end



# # Staggered Caps (Part 2)
# def staggered_case(string, first_char_uppercase: true)
#   result = string.chars.map do |char|
#     if char.ord > 64 && char.ord < 123
#       if first_char_uppercase
#         char.upcase!
#       else
#         char.downcase!
#       end
#
#       first_char_uppercase = !first_char_uppercase
#     end
#
#     char
#   end
#
#   result.join
# end
#
# # optionally include or exclude non-alphabetic characters
# def staggered_case(string,
#                    first_char_uppercase: true,
#                    ignore_non_alphas: true)
#   need_uppercase = first_char_uppercase
#
#   result = string.chars.map do |char|
#     if !ignore_non_alphas || (char.ord > 64 && char.ord < 123)
#       if need_uppercase
#         char.upcase!
#       else
#         char.downcase!
#       end
#
#       need_uppercase = !need_uppercase
#     end
#
#     char
#   end
#
#   result.join
# end



# # Multiplicative Average
# def show_multiplicative_average(integers)
#   mult_avg = integers.inject(:*) / integers.size.to_f
#   puts "The result is: " + format("%.3f", mult_avg)
# end
#
# # if #to_f is omitted, the result is stored as an integer and then displayed by #format with three decimal places which are all 0



# # Multiply Lists
# def multiply_list(array_1, array_2)
#   array_1.map.with_index { |num, idx| num * array_2[idx] }
# end
#
# # Multiply All Pairs
# def multiply_all_pairs(array_1, array_2)
#   products = array_1.product(array_2)
#   products.map! { |pair| pair[0] * pair[1] }.sort
# end
#
# # My solution is very similar to the more compact solution provided. I had noticed the Array#product method a few times working on the previous problem and immediately thought of it when I started this problem. It would put the pairs together for me and I just needed to perform the multiplication and the sorting.



# # The End is Near But Not Here
# def penultimate(string)
#   words = string.split
#   words.pop
#   words.last
# end
#
# # Similar middle word method edge cases:
# #  - empty string: return nil
# #  - string with one word: return the only word
# #  - string with even number of words: return the word preceding the middle
# #  - string with odd number of words: return the middle word
#
# def middle_word(string)
#   words = string.split
#   case
#   when words.size < 2 then words[0]
#   when words.size.even? then words[words.size / 2 - 1]
#   else words[words.size / 2 ]
#   end
# end
