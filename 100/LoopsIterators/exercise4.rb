# exercise4.rb

def countdown(num)
  puts num
  if num > 0
    countdown(num - 1)
  end
end

puts "Enter a number to begin the countdown:"

countdown(gets.chomp.to_i)
