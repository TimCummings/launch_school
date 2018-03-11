# loops_1.rb

# # Runaway Loop
# loop do
#   puts 'Just keep printing...'
#   break
# end



# # Loopception
# loop do
#   puts 'This is the outer loop.'

#   loop do
#     puts 'This is the inner loop.'
#     break
#   end
  
#   break
# end

# puts 'This is outside all loops.'



# # Control the Loop
# iterations = 1

# loop do
#   puts "Number of iterations = #{iterations}"
#   iterations += 1
#   break if iterations > 5
# end

# Further Exploration
# If the break statement is moved up one line so it runs before iterations is incremented, what would need to be changed?
# The "greater than" needs to become a "greater than or equal to":
# break if iterations >= 5



# # Loop on Command
# loop do
#   puts 'Should I stop looping?'
#   answer = gets.chomp
#   break if answer == 'yes'
# end



# # Say Hello
# say_hello = 0

# while say_hello < 5
#   puts 'Hello!'
#   say_hello += 1
# end



# # Print While
# numbers = (0..99).to_a
# counter = 0

# while counter < 5
#   puts numbers.sample
#   counter += 1
# end



# # Count Up
# count = 1

# until count == 11
#   puts count
#   count += 1
# end



# # Print Until
# numbers = [7, 9, 13, 25, 18]
# counter = 0

# until counter == numbers.size
#   puts numbers[counter]
#   counter += 1
# end



# # That's Odd
# for i in 1..100
#   puts i if i.odd?
# end



# # Greet Your Friends
# friends = ['Sarah', 'John', 'Hannah', 'Dave']

# for idx in 0...friends.size
#   puts "Hello, #{friends[idx]}!"
# end
