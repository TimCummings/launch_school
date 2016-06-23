# mutate.rb
# Example of a method that modifies its argument permanently

a = [1, 2, 3]

def mutate(array)
  array.pop
end

p "Before mutate method: #{a}"
p mutate(a)
p "After mutate method: #{a}"



# Example of a method that does not mutate the caller

b = [1, 2, 3]

def no_mutate(array)
  array.last
end

p "Before no_mutate method: #{b}"
p no_mutate(b)
p "After no_mutate method: #{b}"
