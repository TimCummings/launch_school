# exercise5.rb

def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

# This gives us an ArgumentError because the method, as it is written, expects a non-block argument but is given a block instead. To be used in this way, the first line of the method definition needs an & before block:
# def execute(&block)
