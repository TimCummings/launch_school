# easy_2.rb

# Question 1
#   1) ages.any? { |key, _| key == "Spot" }
#   2) ages.assoc("Spot")
#   3) ages.fetch("Spot")

# Question 2
# years = 0
# ages.each_value { |value| years += value }

# Question 3
# ages.delete_if { |_, value| value >= 100 }

# Question 4
#   1) munsters_description[4] = 'm'
#   2) munsters_description.swapcase!
#   3) munsters_description.downcase!
#   4) munsters_description.capitalize!

# Question 5
# ages.merge!(additional_ages)

# Question 6
# ages.values.sort[0]

# Question 7
# advice.include?("Dino")

# Question 8
# flintstones.find_index { |value| value =~ /\ABe/ }

# Question 9
# flintstones.map! { |name| name.slice(0, 3) }

# Question 10
# flintstones.map! { |name| name.slice(0, 3) }
