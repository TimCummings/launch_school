# hashes.rb

# First Car
car = { type: 'sedan', color: 'blue', mileage: 80_000 }



# Adding the Year
car[:year] = 2003



# Broken Odometer
car.delete(:mileage)



# What Color?
puts car[:color]



# Labeled Numbers
numbers = {
  high:   100,
  medium: 50,
  low:    10
}

# numbers.each { |k, v| puts "A #{k} number is #{v}." }



# # Divided by Two
# half_numbers = numbers.map { |_, num| num / 2 }
# p half_numbers



# # Low, Medium, or High?
# low_numbers = numbers.select { |_, num| num < 25 }
# p low_numbers



# Low or Nothing
low_numbers = numbers.select! do |key, value|
                 value < 25
               end

p low_numbers
p numbers

# Further Exploration
# When using a destructive method, the assignment is unnecessary.



# Multiple Cars
vehicles = {
  car: {
    type:  'sedan',
    color: 'blue',
    year:  2003
  },

  truck: {
    type:  'pickup',
    color: 'red',
    year:  1998
  }
}



# Which Collection?
car = [[type:, 'sedan'], [color:, 'blue'], [year:, 2003]]
