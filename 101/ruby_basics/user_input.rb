# user_input.rb

# # Repeat after me
# puts "Please enter something:"
# input = gets.chomp
# puts "You entered: #{input}"



# # Your Age in Months
# puts "How old are you in years?"
#
# years = gets.chomp.to_i
#
# puts "You are #{years * 12} months old."



# # Print Something (Part 1)
# puts "Shall I print 'something'?"
#
# puts "something" if gets.chomp == 'y'
#
# # Further Exploration
# puts "Shall I print 'something'?"
#
# puts "something" if gets.chomp.downcase == 'y'



# # Print Something (Part 2)
# puts "Shall I print 'something'? (y/n)"
#
# selection = gets.chomp.downcase
#
# until selection == 'y' || selection == 'n'
#   puts "That is not a valid input. Please try again."
#   selection = gets.chomp.downcase
# end
#
# puts 'something' if selection == 'y'



# # Launch School Printer (Part 1)
# times = 0
#
# loop do
#   puts "How many lines shall I print? (It must be greater than or equal to 3)"
#   times = gets.to_i
#   break if times >= 3
#   puts "That is not enough lines. Please try again."
# end
#
# times.times { puts "Launch School is the best!" }



# # Passwords
# PASSWORD = 'password'
#
# loop do
#   puts "Please enter your password:"
#   break if gets.chomp == PASSWORD
#   puts "Incorrect password. Please try again."
# end
#
# puts "Correct!"



# # User Name and Password
# USERS =
#   {'Joe' => 'Chicago23', 'Hannah' => 'Sagitar1u5',
#    'Default' => 'password' }
#
# def authenticated?(user, password)
#   USERS.keys.include?(user) && USERS[user] == password
# end
#
# loop do
#   puts "Please enter your username:"
#   user = gets.chomp
#   puts "Please enter your password:"
#   password = gets.chomp
#
#   break if authenticated?(user, password)
#   puts "Your username or password do not match. Please try again."
# end
#
# puts "User authenticated."



# # Dividing Numbers
# def valid_number?(number_string)
#   number_string.to_i.to_s == number_string
# end
#
# def retrieve_number(denominator=false)
#   position = denominator ? 'denominator' : 'numerator'
#   loop do
#     puts "Please enter the #{position}:"
#     number = gets.chomp
#
#     if denominator
#       return number if valid_number?(number) && !number.to_i.zero?
#     else
#       return number if valid_number?(number)
#     end
#
#     puts "Invalid input - only integers are allowed; denominators cannot be zero."
#   end
# end
#
# numerator = retrieve_number
# denominator = retrieve_number(true)
#
# puts "#{numerator} / #{denominator} is #{numerator.to_i / denominator.to_i}"



# # Launch School Printer (Part 2)
# loop do
#   times = 0
#
#   loop do
#     puts "How many lines shall I print? (It must be greater than or equal to 3)"
#     times = gets.chomp.downcase
#     break if times.to_i >= 3 || times == 'q'
#     puts "That is not enough lines. Please try again."
#   end
#
#   break if times == 'q'
#   times.to_i.times { puts "Launch School is the best!" }
# end
#
# puts "Goodbye!"



# Opposites Attract
def valid_number?(number_string)
  number_string.to_i.to_s == number_string && number_string.to_i != 0
end

def retrieve_number
  loop do
    puts "Please enter a positive or negative integer:"
    number = gets.chomp
    return number.to_i if valid_number?(number)
    puts "Invalid input - only non-zero integers are allowed."
  end
end

def opposites?(num_1, num_2)
  return true if num_1.positive? && num_2.negative?
  return true if num_1.negative? && num_2.positive?
  false
end

int_1 = nil
int_2 = nil

loop do
  puts "You will be asked to enter two integers: one positive and one negative."

  int_1 = retrieve_number
  int_2 = retrieve_number

  break if opposites?(int_1, int_2)
  puts "Error: one integer must be positive and the other integer must be negative. Please try again."
end

puts "#{int_1} + #{int_2} = #{int_1 + int_2}"
