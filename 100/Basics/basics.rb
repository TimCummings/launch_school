# Exercise 1
puts "Exercise 1: "
puts "Tim " + "Cummings"



# Exercise 2
puts "\nExercise 2: "

number = 1234

puts number / 1000

puts (number % 1000) / 100

puts (number % 100) / 10

puts (number % 10)



# Exercise 3
puts "\nExercise 3: "
movies = {:Robocop => '1987',
          :Jurassic_Park => '1993',
          :It => '1990',
          :Zombieland => '2009',
          :Equilibrium => '2002'}

puts movies[:Robocop]

puts movies[:Jurassic_Park]

puts movies[:It]

puts movies[:Zombieland]

puts movies[:Equilibrium]



# Exercise 4
puts "\nExercise 4: "

movies = [1987, 1990, 1993, 2002, 2009]

puts movies[0]

puts movies[2]

puts movies[1]

puts movies[4]

puts movies[3]



# Exercise 5
puts "\nExercise 5: "

fact = 5 * 4 * 3 * 2 * 1

puts fact

puts fact * 6

puts fact * 6 * 7

puts fact * 6 * 7 * 8



# Exercise 6
puts "\nExercise 6: "

puts 4.38**2

puts 89.71**2

puts 2349.87**2

# Exercise 7
# Ruby was expecting a '}' that is missing (probably expected to close a '{'). This could be due to a block or a hash that was not closed.
