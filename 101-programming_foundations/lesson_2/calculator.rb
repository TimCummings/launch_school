# calculator.rb

# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.gets()
# Kernel.puts(answer)

Kernel.puts("Welcome to Calculator!")

Kernel.puts("What's the first number?")
number1 = Kernel.gets().chomp()

Kernel.puts("What's the second number?")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i() + number2.to_i()
elsif operator == '2'
  result = number1.to_i() - number2.to_i()
elsif operator == '3'
  result = number1.to_i() * number2.to_i()
else
  result = number1.to_f() / number2.to_f()
end

Kernel.puts("The result is #{result}")


##################################################
# my attempt before watching the video:
##################################################
#
# puts "Please enter two numbers:"
#
# opd1 = gets.chomp.to_i
# opd2 = gets.chomp.to_i
#
# puts "Do you want to add, subtract, multiply, or divide these numbers?"
#
# while opr = gets.chomp
#   if opr == "add"
#     puts opd1 + opd2
#     break
#   elsif opr == "subtract"
#     puts opd1 - opd2
#     break
#   elsif opr == "multiply"
#     puts opd1 * opd2
#     break
#   elsif opr == "divide"
#     puts opd1 / opd2
#     break
#   else
#     puts "I don't understand; please try again."
#   end
# end
