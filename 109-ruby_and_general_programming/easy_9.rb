# easy_9.rb

# # Welcome Stranger
# def greetings(name, info)
#   puts "Hello, #{name.join(' ')}! Nice to have a #{info[:title]} " +
#        "#{info[:occupation]} around."
# end



# # Double Doubles
# def double?(number)
#   string = number.to_s
#   return false if string.size.odd?
#   midpoint = (string.size / 2) - 1
#   string[0..midpoint] == string[(midpoint + 1)..-1]
# end
#
# def twice(number)
#   case
#   when double?(number) then number
#   else number * 2
#   end
# end



# # Always Return Negative
# def negative(number)
#   -(number.abs)
# end



# # Counting Up
# def sequence(integer)
#   (1..integer).to_a
# end
#
# # modified to account for negative numbers:
# def sequence(integer)
#   integer.positive? ? (1..integer).to_a : (integer..-1).to_a
# end



# # Uppercase Check
# def uppercase?(string)
#   string == string.upcase
# end
#
# # I think it makes sense to leave the functionality as-is and return true for an empty string. But there is logic to the argument that an empty string has no uppercase letters and should consequently return false. This could easily be accounted for by adding as the first line of the method:
# return false if string.empty?
#
# # This same issue is apparent for most other non-alphabetic characters: numbers, punctuation, etc. are all considered uppercase. All non-alphabetic characters could be ignored with the regex added as the first line:
# string = string.gsub(/[^[:alpha:]]/, '')



# # How long are you?
# def word_lengths(string)
#   words_lengths = string.split
#   words_lengths.map { |word| word + " #{word.length}"}
# end



# # Name Swapping
# def swap_name(name)
#   full_name = name.split
#   "#{full_name[-1]}, #{full_name[0]}"
# end



# # Sequence Count
# def sequence(count, multiple)
#   result = []
#   1.upto(count) { |itr| result << multiple * itr }
#   result
# end



# # Grade Book
# LETTER_GRADES = { A: 90..100, B: 80..89, C: 70..79, D: 60..69, F: 0..59 }
#
# def get_grade(score_1, score_2, score_3)
#   mean = (score_1 + score_2 + score_3) / 3
#   LETTER_GRADES.each { |k, v| return k.to_s if v.include?(mean) }
# end
#
# # How to handle "extra credit" (scores above 100):
# # I'm not sure exactly how safe this is or how much overhead is involved, but you can maintain the existing ranges by replacing 100 with Infinity: either with the provided constant (Float::INFINITY) or by making your own (Infinity = 1 / 0.0)
# # Alternatively (and probably more safely), you could simply add an extra check before the case statement for grades above 100: return 'A' if result > 100



# # Grocery List
# def buy_fruit(array)
#   result = []
#   array.each do |item|
#     item[1].times { result << item[0] }
#   end
#
#   result
# end
