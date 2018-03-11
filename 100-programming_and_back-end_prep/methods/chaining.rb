# chaining.rb

def add_three(n)
  new_value = n + 3
  puts new_value
  new_value
end

add_three(5).times {puts 'Will this work?'}
