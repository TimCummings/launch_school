# medium_2.rb

# Question 1
# sum = 0
# munsters.each_value do |info|
#   sum += info["age"] if info["gender"] == "male"
# end
# sum

# Question 2
# munsters.each do |member, info|
#   puts "#{member} is a #{info["age"]} year old #{info["gender"]}."
# end

# Question 3
# At the very least, the method needs to be either destructive or non-destructive - not both for different arguments; a separate destructive or non-destructive method could be created. It should also be re-named something sensical based on what it is doing. It would also be a good idea to simplify the method by having it modify and/or return just a_string_param or an_array_param, not both.

# def rutarize_string(a_string_param)
#   a_string_param += "rutabaga"
# end
#
# def rutarize_string!(a_string_param)
#   a_string_param << "rutabaga"
# end
#
# def rutarize_array(an_array_param)
#   an_array_param += ["rutabaga"]
# end
#
# def rutarize_array!(an_array_param)
#   an_array_param << "rutabaga"
# end

# Question 4
# words = sentence.split
# if words.last =~ /[[:punct:]]\Z/
#   words.first << words.last.slice!(words.last.length - 1)
# end
# words.last.capitalize!
# words.reverse.join(' ')

# Question 5
# 34

# Question 6
# The data did indeed get ransacked.

# Question 7
# paper

# Question 8
# no
