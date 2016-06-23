# Flow Control
# exercises.rb

# Exercise 1
# 1. (32 * 4) >= 129
# false - correct

# 2. false != !true
# false - correct

# 3. true == 4
# true - wrong

# 4. false == (847 == '874')
# true - correct

# 5. (!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false
# true - correct

# Exercise 2

def upper(a_string)
  if a_string.length > 10
    a_string.upcase
  end
end

puts "Please enter a string:"
puts upper gets.chomp



# Exercise 3
puts "Please enter a number between 0 and 100:"

number = gets.chomp.to_i

if((number >= 0) && (number <= 50))
  puts "The number is between 0 and 50."
elsif((number >= 51) && (number <= 100))
  puts "The number is between 51 and 100."
elsif number > 100
  puts "The number is more than 100."
else
  puts "Out of bounds."
end



# Exercise 4
# 1. "FALSE"                  - correct
# 2. "Did you get it right?"  - correct
# 3. "Alright now!"           - correct



# Exercise 5
# exercise 3 in a method
def range
  puts "Please enter a number between 0 and 100:"

  number = gets.chomp.to_i

  if((number >= 0) && (number <= 50))
    puts "The number is between 0 and 50."
  elsif((number >= 51) && (number <= 100))
    puts "The number is between 51 and 100."
  elsif number > 100
    puts "The number is more than 100."
  else
    puts "Out of bounds."
  end
end

# case version
def range_case
  puts "Please enter a number between 0 and 100:"
  number = gets.chomp.to_i
end

def compare(number)
  case
    when((number >= 0) && (number <= 50))
      puts "#{number} is between 0 and 50."
    when((number >= 51) && (number <= 100))
      puts "#{number} is between 51 and 100."
    when number > 100
      puts "#{number} is more than 100."
    else
      puts "#{number} is out of bounds."
  end
end

range
compare(range_case)



# Exercise 6
# This error is generated because the code is missing an "end": there is one end for the if statement, but the def also needs an end before it is called. This can be fixed with:

def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
  end
end # This second "end" resolves the error

equal_to_four(5)
