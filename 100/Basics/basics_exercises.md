## Basics - Exercises


### Exercise 1
Add two strings together that, when concatenated, return your first and last name as your full name in one string.

``` ruby
puts "Exercise 1: "
puts "Tim " + "Cummings"
```


### Exercise 2
Use the modulo operator, division, or a combination of both to take a 4 digit number and find the digit in the:
  1. thousands place
  2. hundreds place
  3. tens place
  4. ones place

``` ruby
number = 1234

puts number / 1000

puts (number % 1000) / 100

puts (number % 100) / 10

puts (number % 10)
```


### Exercise 3
Write a program that uses a hash to store a list of movie titles with the year they came out. Then use the `puts` command to make your program print out the year of each movie to the screen. The output for your program should look something like this:
```
1975
2004
2013
2001
1981
```

#### Solution:
``` ruby
movies = { :Robocop => '1987',
           :Jurassic_Park => '1993',
           :It => '1990',
           :Zombieland => '2009',
           :Equilibrium => '2002' }

puts movies[:Robocop]

puts movies[:Jurassic_Park]

puts movies[:It]

puts movies[:Zombieland]

puts movies[:Equilibrium]
```


### Exercise 4
Use the dates from the previous example and store them in an array. Then make your program output the same thing as exercise 3.

``` ruby
movies = [1987, 1990, 1993, 2002, 2009]

puts movies[0]

puts movies[2]

puts movies[1]

puts movies[4]

puts movies[3]
```


### Exercise 5
Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

``` ruby
fact = 5 * 4 * 3 * 2 * 1

puts fact

puts fact * 6

puts fact * 6 * 7

puts fact * 6 * 7 * 8
```


### Exercise 6
Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.

``` ruby
puts 4.38 ** 2

puts 89.71 ** 2

puts 2349.87 ** 2
```


### Exercise 7
What does the following error message tell you?

```
SyntaxError: (irb):2: syntax error, unexpected ')', expecting '}'
  from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
```

#### Solution:
Ruby was expecting a `}` that is missing (probably expected to close a `{`). This could be due to a block or a hash that was not closed.
