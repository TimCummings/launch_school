#methods.rb

# # Greeting Through Methods (Part 1)
# def hello
#   "Hello"
# end
#
# def world
#   "World"
# end
#
# puts hello + ' ' + world



# # Greeting Through Methods (Part 2)
# def greet
#   hello + ' ' + world
# end
#
# puts greet



# # Make and Model
# def car(make, model)
#   puts "#{make} #{model}"
# end
#
# car('Toyota', 'Corolla')
#
# # Further Exploration
# def car(make, model)
#   "#{make} #{model}"
# end
#
# puts car('Toyota', 'Corolla')

# The first car method returns nil, since puts is the last line and puts returns nil. The second car method returns the string: "#{make} #{model}" (in this case: "Toyota Corolla")



# # Day or Night?
# def time_of_day(bool)
#   if bool
#     puts "It's daytime!"
#   else
#     puts "It's nighttime!"
#   end
# end
#
# daylight = [true, false].sample
# time_of_day(daylight)



# # Naming Animals
# def dog(name)
#   return name
# end
#
# def cat(name)
#   return name
# end
#
# puts "The dog's name is #{dog('Spot')}."
# puts "The cat's name is #{cat('Ginger')}."



# # Name Not Found
# def assign_name(name='Bob')
#   name
# end
#
# puts assign_name == 'Bob'
# puts assign_name('Kevin') == 'Kevin'



# # Multiply the Sum
# def add(num_1, num_2)
#   num_1 + num_2
# end
#
# def multiply(num_1, num_2)
#   num_1 * num_2
# end
#
# puts add(2, 2) == 4
# puts add(5, 4) == 9
# puts multiply(add(2, 2), add(5, 4)) == 36



# # Random Sentence
# def name(names)
#   names.sample
# end
#
# def activity(activities)
#   activities.sample
# end
#
# def sentence(name, activity)
#   "#{name} went #{activity} today!"
# end
#
# names = ['Dave', 'Sally', 'George', 'Jessica']
# activities = ['walking', 'running', 'cycling']
#
# puts sentence(name(names), activity(activities))



# # Print Me (Part 1)
# def print_me
#   puts "I'm printing within the method!"
# end
#
# print_me



# Print Me (Part 2)
def print_me
  "I'm printing the return value!"
end

puts print_me
