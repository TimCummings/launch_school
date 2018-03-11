# medium_1.rb

require 'pry'

# # Rotation (Part 1)
# def rotate_array(array)
#   array[1..-1] << array.first
# end
#
# def rotate_string(string)
#   rotate_array(string.chars).join
# end
#
# def rotate_number(number)
#   rotate_string(number.to_s).to_i
# end



# # Rotation (Part 2)
# def rotate_rightmost_digits(number, digits)
#   string = number.to_s
#   return number if digits > string.length
#   to_rotate = string.slice!(-digits..-1)
#   (string + rotate_string(to_rotate)).to_i
# end



# # Rotation (Part 3)
# def max_rotation(number)
#   length = number.to_s.length
#   length.downto(2) { |itr| number = rotate_rightmost_digits(number, itr) }
#   number
# end
#
# # Without rotate_rightmost_digits or rotate_array
# def max_rotation(number)
#   digits = number.to_s.chars
#   result = []
#   0.upto(digits.size - 1) do
#     digits << digits.shift
#     result << digits.shift
#   end
#   result.join.to_i
# end
#
# # This is a more contained solution (and more succinct overall), but the process of solving this piece by piece and building on each method was easier to step through, mentally, and resulted in more methods, each suited to different specific situations



# # 1000 Lights
# TOTAL_LIGHTS = 1000
#
# def round_x(lights, x)
#   1.upto(x) do |itr|
#     multiple = itr
#     while multiple < TOTAL_LIGHTS + 1
#       lights[multiple - 1] = !lights[multiple - 1]
#       multiple += itr
#     end
#   end
#
#   lights
# end
#
# def lights_on(lights)
#   on = []
#   lights.each_with_index { |light, idx| on << (idx + 1) if light }
#   on
# end
#
# # helper method to help me visualize and understand the problem and troubleshoot my code
# def display_lights(lights)
#   lights.each_with_index do |light, idx|
#     puts "#{idx + 1}:".rjust(5) + " #{light ? 'ON' : 'OFF'}"
#   end
# end
#
# lights = []
# TOTAL_LIGHTS.times { |_| lights << false }
# lights = round_x(lights, TOTAL_LIGHTS)
# lights_on(lights)
#
# # Further Exploration
# # 1) Do you notice the pattern in our answer? Every light that is on is a perfect square. Why is that?
# # Any given light has a sequence number based on its occurance in the sequence of total lights; any given light is toggled each time the round number is a factor of that light's sequence number. Factors will always occur in pairs (by definition, one factor must be multiplied by another factor, always resulting in a pair). Thus, most lights will be toggled an even number of times, which (given the binary setting of on or off) will always return a light to its original setting (off).
# # Perfect squares are unique, as long as factors are counted uniquely. One pair of factors for a perfect square will always be the square root multiplied by itself. When counting factors uniquely, this results in a single factor (going by unique count) instead of a pair of factors. This brings the total number of unique factors to an odd number for a perfect square. With the binary setting, the odd number of toggles will always result in the final setting being the opposite of the original setting (on instead of off).
#
# # 2) An array of boolean values is how I approached my solution to this problem. The general approach was similar, but some parts were cleaner while others were clunkier: using booleans as values makes "toggling" the lights very simple with !; determining the status of a light is also slightly simpler (boolean comparison instead of string comparison); accessing a specific light by number is slightly more complex since the mental model deals with lights in sequence starting at #1, but the array starts at index 0 - this is not a major issue and only slightly increases the complexity of the code, but it could cause a programmer to stumble mentally or make a mistake, that could be very puzzling to troubleshoot, of not kept in mind.
#
# # 3) We could have a method that replicates the output from the description of this problem(i.e. "lights 2, 3, and 5 are now off; 1 and 4 are on.") How would we go about making that method?
#
# def lights_off(lights)
#   off = []
#   lights.each_with_index { |light, idx| off << (idx + 1) if !light }
#   off
# end
#
# def prep_for_display(which_lights)
#   array = which_lights.map(&:to_s)
#   array[-1] = "and #{which_lights.last}" if which_lights.size > 1
#   array
# end
#
# def prep_sentence(which_lights, status)
#   case which_lights.size
#   when 0 then "No lights are #{status}."
#   when 1 then "Light #{which_lights.first} is #{status}."
#   when 2 then "Lights #{which_lights.join(' ')} are #{status}."
#   else "Lights #{which_lights.join(', ')} are #{status}."
#   end
# end
#
# def display_lights(lights)
#   on = prep_for_display(lights_on(lights))
#   off = prep_for_display(lights_off(lights))
#
#   on = prep_sentence(on, "on")
#   off = prep_sentence(off, "off")
#
#   puts "#{on} #{off}"
# end



# # Diamonds!
# def diamond(x)
#   lines = []
#   lines << ''.center(x, '*')
#   itr = x - 2
#
#   while itr > 0
#     lines.unshift(('*' * itr).center(x))
#     lines.push(('*' * itr).center(x))
#     itr -= 2
#   end
#
#   puts lines
# end
#
# def prepare_line(chars_length, line_length)
#   if chars_length <= 1
#     return '*'.center(line_length)
#   else
#     return ('*' + ' ' * (chars_length - 2) + '*').center(line_length)
#   end
# end
#
# def diamond_outline(x)
#   lines = []
#   lines << prepare_line(x, x)
#   itr = x - 2
#
#   while itr > 0
#     lines.unshift(prepare_line(itr, x))
#     lines.push(prepare_line(itr, x))
#     itr -= 2
#   end
#
#   puts lines
# end



# # Stack Machine Interpretation
# def minilang(instructions)
#   stack = []
#   register = 0
#   error = nil
#   instructions = instructions.split
#
#   instructions.each do |instruction|
#     error =
#       case instruction
#       when /[0-9]+/
#         register = instruction.to_i
#       when 'PRINT'
#         puts register
#       when 'PUSH'
#         stack.push(register)
#       when 'ADD'
#         stack.empty? ? "Error: empty stack." : register += stack.pop
#       when 'SUB'
#         stack.empty? ? "Error: empty stack." : register -= stack.pop
#       when 'MULT'
#         stack.empty? ? "Error: empty stack." : register *= stack.pop
#       when 'DIV'
#         stack.empty? ? "Error: empty stack." : register /= stack.pop
#       when 'MOD'
#         stack.empty? ? "Error: empty stack." : register %= stack.pop
#       when 'POP'
#         stack.empty? ? "Error: empty stack." : register = stack.pop
#       else "Error: invalid token."
#       end
#   end
#
#   if error.is_a?(String)
#     p error
#   else
#     return nil
#   end
# end
#
# # Try writing a minilang program to evaluate and print the result of this expression:
# # (3 + (4 * 5) - 7) / (5 % 3)
# # '3 PUSH 5 MOD PUSH 7 PUSH 5 PUSH 4 MULT PUSH 3 ADD SUB DIV PRINT'



# Word to Digit
# my first solution
def word_to_digit(words)
  result = words.gsub(/zero[:punct:]*/i, '0')
  result = result.gsub(/one[:punct:]*/i, '1')
  result = result.gsub(/two[:punct:]*/i, '2')
  result = result.gsub(/three[:punct:]*/i, '3')
  result = result.gsub(/four[:punct:]*/i, '4')
  result = result.gsub(/five[:punct:]*/i, '5')
  result = result.gsub(/six[:punct:]*/i, '6')
  result = result.gsub(/seven[:punct:]*/i, '7')
  result = result.gsub(/eight[:punct:]*/i, '8')
  result = result.gsub(/nine[:punct:]*/i, '9')
end

# my second solution after seeing the provided solution - intregrates hash for a more compact method

DIGIT_WORDS = { 'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3',
                'four' => '4', 'five' => '5', 'six' => '6', 'seven' => '7',
                'eight' => '8', 'nine' => '9' }.freeze

def word_to_digit(words)
  DIGIT_WORDS.keys.each do |word|
    words = words.gsub(/\b#{word}\b/i, DIGIT_WORDS[word])
  end
  words
end


# Further Exploration
# 1) What if certain words that represent numbers can be uppercase, lowercase, or capitalized.
# Case can be considered by adding an 'i' at the end of our match pattern to ignore case: /\b#{word}\b/i

# 2) Can you modify this so that spaces between the inserted numbers are eliminated? If the sentence already contains 2 or more space separated numbers (not words), don't delete the space between them: only the spaces between the converted number words should be eliminated.

# 3) What about dealing with phone numbers? Is there any easy way to format our string to account for phone numbers? For our purposes, assume that any 10 digit number is a phone number, and that the proper format should be "(123) 456-7890".

regex = /
  \b(?<dig0>\d)([:punct:]|[:space:])*
  (?<dig1>\d)([:punct:]|[:space:])*
  (?<dig2>\d)([:punct:]|[:space:])*
  (?<dig3>\d)([:punct:]|[:space:])*
  (?<dig4>\d)([:punct:]|[:space:])*
  (?<dig5>\d)([:punct:]|[:space:])*
  (?<dig6>\d)([:punct:]|[:space:])*
  (?<dig7>\d)([:punct:]|[:space:])*
  (?<dig8>\d)([:punct:]|[:space:])*
  (?<dig9>\d)\b
/x

words = words.gsub(regex,
  "(#{:dig0}#{:dig1}#{:dig2}) #{:dig3}#{:dig4}#{:dig5}-#{:dig6}#{:dig7}#{:dig8}#{:dig9}")



# Fibonacci Numbers (Recursion)
def fibonacci(n)
  return 1 if n <= 2
  fibonacci(n - 1) + fibonacci(n - 2)
end



# Fibonacci Numbers (Procedural)
def fibonacci(n)
  return 1 if n <= 2

  l, m, result = 1, 1, 0
  3.upto(n) do |_|
    result = l + m
    l = m
    m = result
  end

  result
end



# Fibonacci Numbers (Last Digit)
def fibonacci_last(n)
  return 0 if n == 0
  first, last = [1, 1]
  3.upto(n) do
    first, last = [last, first + last]
    last %= 10 if last > 9
  end

  last
end

# last Fibonacci digit of any number:
def any_fibonacci_last(n)
  fibonacci_last(n % 60)
end

# The last digit of the Fibonacci sequence repeats in a pattern every 60 numbers.
