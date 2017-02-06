# loops_2.rb

# # Even or Odd?
# count = 1

# loop do
#   puts "#{count} is odd!" if count.odd?
#   puts "#{count} is even!" if count.even?
#   count += 1
#   break if count > 5
# end



# # Catch the Number
# loop do
#   number = rand(100)
#   puts number
#   break if number > 0 && number < 10
# end



# # Conditional Loop
# loop do
#   process_the_loop = [true, false].sample

#   if process_the_loop
#     puts "The loop was processed!"
#     break
#   else
#     puts "The loop wasn't processed!"
#   end
# end



# # Get the Sum
# loop do
#   puts 'What does 2 + 2 equal?'
#   answer = gets.chomp.to_i
  
#   if answer == 4
#     puts "That's correct!"
#     break
#   else
#     puts "Wrong answer. Try again!"
#   end
# end



# # Insert Numbers
# numbers = []

# loop do
#   puts 'Enter any number:'
#   numbers << gets.chomp.to_i
#   break if numbers.size >= 5
# end

# puts numbers



# # Empty the Array
# names = ['Sally', 'Joe', 'Lisa', 'Henry']

# loop do
#   break if names.empty?
#   puts names.pop
# end

# # Further Exploration
# # use Array#pop instead of Array#shift



# # Stop Counting
# 5.times do |index|
#   puts "The current number is: #{index}"
#   break if index == 2
# end

# # Further Exploration
# # Five values will be printed: 0..4
# # Only one value will be printed: 0



# # Only Even
# number = 0

# until number == 10
#   number += 1
#   next unless number.even?
#   puts number
# end

# # Further Exploration
# # If next were placed before the incrementation of number, this would be an infinite loop; if next were placed after puts, all the numbers would be printed.



# # First to Five
# number_a = 0
# number_b = 0

# loop do
#   number_a += rand(2)
#   number_b += rand(2)

#   next unless number_a == 5 || number_b == 5

#   puts "5 was reached!"
#   break
# end

# # Further Exploration
# # if number_a == 5 || number_b == 5
# #   puts "5 was reached!"
# #   break
# # end



# Greeting
def greeting
  puts 'Hello!'
end

number_of_greetings = 2
count = 0

while count < number_of_greetings
  greeting
  count += 1
end