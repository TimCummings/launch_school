# strings.rb

# # Create a String
# my_variable = String.new



# # Quote Confusion
# puts "It's now 12 o'clock."
#
# # Further Exploration
# puts %Q(She said, "He said, 'This statement contains lots of quotations!'")



# # Ignoring Case
# def compare(string_1, string_2)
#   if string_1.downcase == string_2.downcase
#     puts true
#   else
#     puts false
#   end
# end
#
# name = 'Roger'
#
# compare(name, 'RoGeR')
# compare(name, 'DAVE')



# # Dynamic String
# name = 'Elizabeth'
#
# puts "Hello, #{name}!"



# # Combining Names
# first_name = 'John'
# last_name = 'Doe'
#
# full_name = first_name + ' ' + last_name
# puts full_name
#
# Further Exploration
# full_name = first_name.concat(' ', last_name)
# puts full_name
#
# full_name = ''
# full_name.insert(-1, first_name)
# full_name.insert(-1, ' ')
# full_name.insert(-1, last_name)
# puts full_name



# # Tricky Formatting
# state = 'tExAs'
# state.capitalize!
# puts state



# # Goodbye, not Hello
# greeting = 'Hello!'
# greeting.replace "Goodbye!"
# puts greeting



# # Print the Alphabet
# alphabet = 'abcdefghijklmnopqrstuvwxyz'
# puts alphabet.chars



# # Pluralize
# words = 'car human elephant airplane'
#
# words_array = words.split
# words_array.each { |word| puts "#{word}s" }



# Are You There?
colors = 'blue pink yellow orange'

# colors_array = colors.split

puts colors.include?('yellow')
puts colors.include?('purple')

# Further Exploration
# The output will be true, because the colors string contains the substring 'boredom' which contains the substring 'red'.
