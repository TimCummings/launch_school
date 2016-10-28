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



# Multiples of 3 and 5
def multisum(number)
  three_sum = 0
  three_max = number / 3
  1.upto(three_max) { |x| three_sum += 3 * x }
  
  five_sum = 0
  five_max = number / 5
  1.upto(five_max) { |x| five_sum += 5 * x }
  
  three_sum + five_sum
end