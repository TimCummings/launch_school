# exercises_additional_practice

# # Exercise 1
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# flintstones_hash = {}

# flintstones.each_with_index do |name, idx|
#   flintstones_hash[name] = idx
# end



# # Exercise 2
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# ages.values.reduce(:+)



# # Exercise 3
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# ages.delete_if { |_, age| age >= 100 }



# # Exercise 4
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# # initial solution without method hunting
# ages.values.sort.first

# # more fitting/clear solution after checking documentation
# ages.values.min



# # Exercise 5
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# # initial solution without method hunting
# first = nil

# flintstones.each_with_index do |name, idx|
#   if name.start_with?('Be')
#     first = idx
#     break
#   end
# end

# first

# # more fitting/clear solution after checking documentation
# flintstones.index { |name| name.start_with?('Be') }



# # Exercise 6
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones.map! { |name| name[0..2] }



# # Exercise 7
# statement = "The Flintstones Rock"

# # char_count = Hash.new(0)
# # statement.chars.each { |char| char_count[char] += 1 }

# # if whitespace needs to be excluded:
# input = statement.split.join

# char_count = Hash.new(0)
# input.chars.each { |char| char_count[char] += 1 }



# Exercise 8
# Bad things. It causes the iteration to get off track, possibly skipping elements, accessing the same element multiple times, or attempting to access beyond the bounds of the array (this should just throw exceptions in Ruby - in languages like C++, it can modify memory beyond the array and cause serious problems.)

# 1
# 3

# 1
# 2



# # Exercise 9
# def titleize(string)
#   words = string.split
#   words.map! { |word| word.capitalize }
#   words.join(' ')
# end



# Exercise 10
munsters = {
  "Herman"  => { "age" => 32,  "gender" => "male" },
  "Lily"    => { "age" => 30,  "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie"   => { "age" => 10,  "gender" => "male" },
  "Marilyn" => { "age" => 23,  "gender" => "female" }
}

def which_age_group(age)
  case age
  when (0..17)  then 'kid'
  when (18..64) then 'adult'
  else               'senior'
  end
end

munsters.each do |name, info|
  info['age_group'] = which_age_group(info['age'])
end
