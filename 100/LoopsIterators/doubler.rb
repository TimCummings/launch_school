# doubler.rb

def doubler(start)
  puts start
  if start < 10
    doubler(start * 2)
  end
end

doubler(gets.chomp.to_i)
