y = 0
3.times do
  y += 1
  x = y
end
puts x

# x does not print to the screen

# This program does give an error: exercise5b.rb:6:in `<main>': undefined local variable or method `x' for main:Object (NameError)

# This program generates an error and the first program does not because of variable declaration and scope. In the first program, x is declared outside of the do block, so it is usable both inside the do block and outside of the do block. In the second program, x is declared inside the do block and is therefore not accessible outside of the do block. Consequently, trying to puts x outside of the do block (where x was declared) results in the error above.
