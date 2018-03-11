# medium_2.rb

# # Longest Sentence
# def longest_sentence(filename)
#   text = File.read(filename)
#   sentences = text.split(/[\.!\?]/)
#   sentences.map! { |sentence| sentence.split }
#
#   words = 0
#   index = 0
#   sentences.each_with_index do |sentence, idx|
#     if words < sentence.size
#       words = sentence.size
#       index = idx
#     end
#   end
#
#   puts "The longest sentence with #{words} words is:"
#   puts sentences[index].join(' ')
# end
#
# # Further Exploration
# # 1) longest paragraph (assuming still based on number of words)
# def longest_paragraph(filename)
#   text = File.read(filename)
#   paragraphs = text.split(/\n\n/)
#   longest_paragraph = paragraphs.max_by { |paragraph| paragraph.split.size }
#   puts "The longest paragraph with #{longest_paragraph.split.size} words is:"
#   puts longest_paragraph
# end
#
# # 2) longest word
# def longest_word(filename)
#   text = File.read(filename)
#   words = text.split(/\b/)
#   longest_word = words.max_by { |word| word.size }
#   puts "The longest word with #{longest_word.size} characters is:"
#   puts longest_word
# end



# Now I Know My ABCs
def block_word?(word)
  blocks = %w(B:O X:K D:Q C:P N:A G:T R:E F:S J:W H:U V:I L:Y Z:M)
  word.upcase.chars.each do |letter|
    if blocks.join.include?(letter)
      blocks.select! { |block| !block.include?(letter) }
    else
      return false
    end
  end

    true
end

# Further Exploration
# I used an almost identical data structure for the blocks: an array of strings. My strings were three characters simply because I did not remove the ":". My method for checking for block/letter repetition was more fine grained than it needed to be (compared to the provided solution): instead of checking explicitly if a block was used more than once, I actually manipulated my data structure in the checking process, removing blocks as they were used and then checking if the word's remaining characters were not included in the reduced collection of blocks.



# # Lettercase Percentage Ratio
# def letter_case_count(string)
#   result = {}
#   result[:lowercase] = string.count('a-z')
#   result[:uppercase] = string.count('A-Z')
#   result[:neither] = string.size - result[:lowercase] - result[:uppercase]
#   result
# end
#
# def letter_percentages(string)
#   counts = letter_case_count(string)
#   percentages = {}
#   counts.each { |k, v| percentages[k] = (v.to_f / string.size * 100).round(2) }
#   percentages
# end



# # Matching Parentheses?
# def balanced?(string)
#   paren = 0
#   string.chars.each do |char|
#     paren += 1 if char == '('
#     paren -= 1 if char == ')'
#     return false if paren.negative?
#   end
#   paren.zero? ? true : false
# end
#
# # Further Exploration
# def tally(matched, char)
#   case char
#   when '(' then matched['()'] += 1
#   when ')' then matched['()'] -= 1
#   when '[' then matched['[]'] += 1
#   when ']' then matched['[]'] -= 1
#   when '{' then matched['{}'] += 1
#   when '}' then matched['{}'] -= 1
#   when "'" then matched["'"] += 1
#   when '"' then matched['"'] += 1
#   end
# end
#
# def matched?(matched)
#   return false if matched['()'] != 0
#   return false if matched['[]'] != 0
#   return false if matched['{}'] != 0
#   return false if matched["'"].odd?
#   return false if matched['"'].odd?
#   true
# end
#
# def balanced?(string)
#   matched = { '()' => 0, '[]' => 0, '{}' => 0, "'" => 0, '"' => 0 }
#   string.chars.each do |char|
#     tally(matched, char) if matched.keys.join.include?(char)
#     break if matched.values.include?(-1)
#   end
#
#   matched?(matched)
# end



# # Triangle Sides
# def triangle?(*sides)
#   if sides.all?(&:positive?)
#     sides.sort!
#     sides[0] + sides[1] > sides[2]
#   else
#     false
#   end
# end
#
# def triangle(side_1, side_2, side_3)
#   if triangle?(side_1, side_2, side_3)
#     case [side_1, side_2, side_3].uniq.size
#     when 1 then :equilateral
#     when 2 then :isosceles
#     else :scalene
#     end
#   else
#     :invalid
#   end
# end



# # Tri-Angles
# def triangle?(angles)
#   angles.all?(&:positive?) && angles.reduce(:+) == 180
# end
#
# def triangle(angle_1, angle_2, angle_3)
#   angles = [angle_1, angle_2, angle_3]
#   if triangle?(angles)
#     case
#     when angles.any? { |angle| angle == 90 } then :right
#     when angles.any? { |angle| angle > 90 } then :obtuse
#     else :acute
#     end
#   else
#     :invalid
#   end
# end



# # Unlucky Days
# require 'date'
#
# def friday_13th?(year)
#   dates = []
#   1.upto(12) { |itr| dates << Date.new(year, itr, 13) }
#   dates.select { |date| date.friday? }.size
# end
#
# # Further Exploration
# # 1) What about finding each lucky day of the month (7th of the month).
# def friday_7th?(year)
#   dates = []
#   1.upto(12) { |itr| dates << Date.new(year, itr, 7) }
#   dates.select { |date| date.friday? }.size
# end
#
# # 2) We could also try and find the 2nd to last day of the month. For this last case, we would need to account for leap years.
# def friday_2nd_to_last?(year)
#   dates = []
#   date = Date.new(year, 2, 1)
#   12.times do |_|
#     dates << date.prev_day.prev_day
#     date = date.next_month
#   end
#
#   dates.select { |date| date.friday? }.size
# end



# # Next Featured Number Higher than a Given Value
# def featured(num)
#   result = 7
#   result += 7 until result > num
#
#   until result > 9_876_543_210
#     if result.odd? && result.to_s.size == result.to_s.chars.uniq.size
#       return result
#     else
#       result += 7
#     end
#   end
#
#   p "Error: number is too large - no larger featured number possible."
# end



# # Bubble Sort
# def bubble_sort!(array)
#   ceiling = array.size - 1
#   loop do
#     last_swap = 0
#     1.upto(ceiling) do |idx|
#       if array[idx - 1] > array[idx]
#         array[idx - 1], array[idx] = array[idx], array[idx - 1]
#         last_swap = idx
#       end
#     end
#
#     ceiling = last_swap
#     break if ceiling.zero?
#   end
# end



# Sum Square - Square Sum
def sum_square_difference(num)
  sum_square = (1..num).to_a.map { |x| x ** 2 }.reduce(:+)
  square_sum = (1..num).to_a.reduce(:+) ** 2
  square_sum - sum_square
end
