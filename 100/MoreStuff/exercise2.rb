# exercise2.rb

def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }

# This program does not print anything to the screen. It returns a Proc object.
