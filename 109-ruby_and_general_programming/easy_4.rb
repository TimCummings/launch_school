# easy_4.rb

# # Short Long Short
# def short_long_short(string1, string2)
#   string1.length < string2.length ?
#   string1 + string2 + string1 :
#   string2 + string1 + string2
# end



# # What Century is That?
# def century(year)
#   quotient = year / 100
#   remainder = year % 100

#   cent = 0
#   if remainder == 0
#     cent = quotient
#   else
#     cent = quotient + 1
#   end

#   case cent = cent.to_s
#   when /1[123]\z/
#     cent + 'th'
#   when /1\z/
#     cent + 'st'
#   when /2\z/
#     cent + 'nd'
#   when /3\z/
#     cent + 'rd'
#   else
#     cent + 'th'
#   end
# end



# # Leap Years (Part 1)
# def leap_year?(year)
#   if year % 400 == 0
#     true
#   elsif year % 100 == 0
#     false
#   elsif year % 4 == 0
#     true
#   else
#     false
#   end
# end

# # The code provided will incorrectly return false for years evenly divisible by 400 (since that condition is checked after 100).

# # Re-ordered to 4, then 100, then 400:
# def leap_year?(year)
#   if year % 4 == 0
#     if year % 100 == 0
#       if year % 400 == 0
#         true
#       else
#         false
#       end
#     else
#       true
#     end
#   else
#     false
#   end
# end

# # This solution is more complicated (requires nested conditionals) and harder to read.



# # Leap Years (Part 2)
# def leap_year?(year)
#   if year < 1752
#     year % 4 == 0
#   else
#     (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
#   end
# end



# # Multiples of 3 and 5
# def multisum(number)
#   multiples = []
#   three_max = number / 3
#   1.upto(three_max) { |x| multiples.push(3 * x) }
#
#   five_max = number / 5
#   1.upto(five_max) { |x| multiples.push(5 * x) }
#
#   multiples.uniq!
#   multiples.inject(0, :+)
# end



# # Running Totals
# def running_total(array)
#   sum = 0
#   totals = []
#   array.each do |num|
#     sum += num
#     totals.push(sum)
#   end
#   totals
# end



# # Convert a String to a Number!
# def translate(char)
#   case char
#   when '0' then 0
#   when '1' then 1
#   when '2' then 2
#   when '3' then 3
#   when '4' then 4
#   when '5' then 5
#   when '6' then 6
#   when '7' then 7
#   when '8' then 8
#   when '9' then 9
#   end
# end
#
# def string_to_integer(string)
#   number = 0
#   position = string.length - 1
#
#   string.chars.each do |digit|
#     number += (translate(digit) * (10 ** position))
#     position -= 1
#   end
#   number
# end



# # Convert a String to a Signed Number!
# def string_to_integer(string)
#   sign = nil
#   if string.start_with?('+', '-')
#     sign = string.slice!(0)
#   end
#
#   number = 0
#   position = string.length - 1
#
#   string.chars.each do |digit|
#     number += (translate(digit) * (10 ** position))
#     position -= 1
#   end
#
#   if sign == '-'
#     number *= -1
#   else
#     number
#   end
# end



# Convert a Number to a String!
TRANSLATE = %w(0 1 2 3 4 5 6 7 8 9)

def integer_to_string(number)
  digits = []
  loop do
    number, digit = number.divmod(10)
    digits.unshift(digit)
    break if number == 0
  end

  digits.map! { |digit| TRANSLATE[digit] }
  digits.inject(:+)
end



# Convert a Signed Number to a String!
def signed_integer_to_string(number)
  sign = ''
  if number < 0
    sign = '-'
    number *= -1
  elsif number > 0
    sign = '+'
  end

  sign + integer_to_string(number)
end
