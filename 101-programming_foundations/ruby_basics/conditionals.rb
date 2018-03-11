# conditionals.rb

# Unpredictable Weather (Part 1)
# sun = ['visible', 'hidden'].sample

# puts "The sun is so bright!" if sun == 'visible'



# Unpredictable Weather (Part 2)
# puts "The clouds are blocking the sun!" unless sun == 'visible'



# Unpredictable Weather (Part 3)
# puts "The sun is so bright!" if sun == 'visible'
# puts "The clouds are blocking the sun!" unless sun == 'visible'



# True or False
# boolean = [true, false].sample
#
# puts boolean == true ? "I'm true!" : "I'm false!"



# Truthy Number
# My favorite number is 7.



# Stoplight (Part 1)
# stoplight = ['green', 'yellow', 'red'].sample
#
# case stoplight
# when 'green'  then puts "Go!"
# when 'yellow' then puts "Slow down!"
# when 'red'    then puts "Stop!"
# end



# Stoplight (Part 2)
# if stoplight == 'green'
#   puts "Go!"
# elsif stoplight == 'yellow'
#   puts "Slow down!"
# else
#   puts "Stop!"
# end



# # Sleep Alert
# status = ['awake', 'tired'].sample
#
# to_do =
#   if status == 'awake'
#     "Be productive!"
#   else
#     "Go to sleep!"
#   end
#
# puts to_do



# # Cool Numbers
# number = rand(10)
#
# if number == 5
#   puts '5 is a cool number!'
# else
#   puts 'Other numbers are cool too!'
# end



# Stoplight (Part 3)
stoplight = ['green', 'yellow', 'red'].sample

case stoplight
when 'green'  then puts 'Go!'
when 'yellow' then puts 'Slow down!'
else               puts 'Stop!'
end
