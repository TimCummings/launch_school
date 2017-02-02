# easy_6.rb

# # Cute angles
# MINUTES_PER_DEGREE = 60
# SECONDS_PER_MINUTE = 60
#
# def dms(angle)
#   sign = ''
#   if angle.negative?
#     angle = angle.abs
#     sign << '-'
#   end
#
#   degrees, minutes_ratio = angle.divmod(1)
#   minutes, seconds_ratio = (minutes_ratio * MINUTES_PER_DEGREE).divmod(1)
#   seconds = (seconds_ratio * SECONDS_PER_MINUTE).round
#
#   if seconds == 60
#     minutes += 1
#     seconds = 0
#   end
#
#   format("#{sign}%d°%02d'%02d\"", degrees, minutes, seconds)
# end



# # Delete vowels
# def remove_vowels(strings)
#   strings.map { |string| string.delete"AEIOUaieou" }
# end



# # Fibonacci Number Location by Length
# def find_fibonacci_index_by_length(digits)
#   last_fib = 1
#   this_fib = 1
#   index = 2
#
#   while this_fib.to_s.length < digits
#     index += 1
#     next_fib = this_fib + last_fib
#     last_fib = this_fib
#     this_fib = next_fib
#   end
#
#   index
# end



# # Reversed Arrays (Part 1)
# def reverse!(array)
#   temp_array = []
#   temp_array.push(array.pop) while !array.empty?
#   array.push(temp_array.shift) while !temp_array.empty?
#   array
# end



# # Reversed Arrays (Part 2)
# def reverse(array)
#   result = []
#   index = array.size - 1
#
#   while index >= 0
#     result.push(array[index])
#     index -= 1
#   end
#
#   result
# end
#
# # shorter reverse using inject
# def reverse(array)
#   array.inject([]) { |result, item| result.unshift(item) }
# end



# # Combining Arrays
# def merge(array_1, array_2)
#   (array_1 + array_2).uniq
# end



# # Halvsies
# def halvsies(array)
#   first_half = []
#   idx = 0
#   midpoint = (array.size.to_f / 2).round
#
#   while idx < midpoint
#     first_half << array[idx]
#     idx += 1
#   end
#
#   second_half = array.drop(midpoint)
#   [first_half, second_half]
# end

# array.size is divided by 2.0 instead of 2 to ensure that first_half contains an extra item in the case of an array with an odd number of items. With integer division (using 2 instead of 2.0) the result would be an integer and #ceil would not increment it. The end result would be (in the case of an array with an odd number of items) a first_half with one less item and a second_half with one more item, which is the reverse of what the problems specifies.

# My solution was very similar in overall approach but used slightly different methods of achieving the same result (#<< and #drop instead of #slice).



# # Find the Duplicate
# def find_dup(array)
#   array.each { |item| return item if array.count(item) > 1 }
# end



# # Does My List Include This?
# def include?(list, query)
#   list.any? { |item| item == query }
# end



# # Right Triangles
# CHARACTER = '*'
#
# def triangle(stars)
#   if stars > 0
#     1..stars.times do |itor|
#       puts (CHARACTER * (itor + 1)).rjust(stars)
#     end
#   end
# end
#
# # upside down
# def inverted_triangle(stars)
#   if stars > 0
#     itor = stars
#     while itor > 0
#       puts (CHARACTER * itor).rjust(stars)
#       itor -= 1
#     end
#   end
# end
#
# def reverse_triangle(stars)
#   if stars > 0
#     1..stars.times do |itor|
#       puts (CHARACTER * (itor + 1)).ljust(stars)
#     end
#   end
# end
#
# def inverted_reverse_triangle(stars)
#   if stars > 0
#     itor = stars
#     while itor > 0
#       puts (CHARACTER * itor).ljust(stars)
#       itor -= 1
#     end
#   end
# end
#
# # right angle in any corner
#
#
# def place_triangle(stars, position = '+-')
#   case position
#   when '-+'
#     inverted_reverse_triangle(stars)
#   when '++'
#     inverted_triangle(stars)
#   when '--'
#     reverse_triangle(stars)
#   when '+-'
#     triangle(stars)
#   end
# end
