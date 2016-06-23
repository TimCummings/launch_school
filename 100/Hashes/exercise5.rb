# exercise5.rb

# To find out if a hash contains a specific value, I would use the value? method.

president = { first_name: "Abraham", last_name: "Lincoln", height: "6ft 4in" }

puts "Does this hash contain 'Lincoln'?"
puts president.value?("Lincoln")

puts "Does this hash contain 3.14?"
puts president.value?(3.14)
