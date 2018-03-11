# calculator3.rb

LANGUAGE = 'es'

require 'yaml'
MESSAGES = YAML.load_file('.calculator_config.yml')

def messages(message, lang = LANGUAGE)
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

# validates integers and floats
def valid_number?(num)
  # if num contains any character other than -, ., or 0-9, return false
  /[^0-9.\-]/ !~ num
end

def operation_to_message(op)
  answer = case op
           when '1'
             'adding'
           when '2'
             'subtracting'
           when '3'
             'multiplying'
           when '4'
             'dividing'
           end

  # some other code

  return answer
end

prompt(messages(:request_name))

name = ''
loop do
  name = Kernel.gets.chomp

  if name.empty?()
    prompt(messages(:complain_name))
  else
    break
  end
end

prompt(messages(:greeting) % { :name => name })

loop do # main loop
  number1 = ''
  loop do
    prompt(messages(:request_number1))
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt(messages(:complain_number))
    end
  end

  number2 = ''
  loop do
    prompt(messages(:request_number2))
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt(messages(:complain_number))
    end
  end

  prompt(messages(:request_operator))

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages(:complain_operator))
    end
  end

  prompt messages(operation_to_message(operator))

  result = case operator
           when '1'
             number1.to_i() + number2.to_i()
           when '2'
             number1.to_i() - number2.to_i()
           when '3'
             number1.to_i() * number2.to_i()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt messages(:result) % { :result => result }

  prompt(messages(:main_loop))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
