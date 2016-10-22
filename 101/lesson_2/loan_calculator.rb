# loan_calculator.rb

require 'bigdecimal'

puts 'Welcome to Loan Payment Calculator!'
puts '-----------------------------------'

loop do # main loop #
  puts 'What is the TOTAL amount of the loan?'

  loan_amount = ''
  loop do
    loan_amount = gets.chomp
    loan_amount.delete! "$,"
    loan_amount = BigDecimal.new(loan_amount)

    if loan_amount.zero? || loan_amount < 0
      puts "That is not a valid amount. Please try again."
    else
      break
    end
  end

  puts 'Is the loan duration measured in months (M) or years (Y)?'

  period = ''
  loop do
    period = gets.chomp.downcase
    if period == 'm'
      period = 'MONTHS'
      break
    elsif period == 'y'
      period = 'YEARS'
      break
    else
      puts "I don't understand. Please enter M for months or Y for years."
    end
  end

  puts "What is the loan duration in #{period}?"

  duration = ''
  loop do
    duration = BigDecimal.new(gets)
    if duration.zero? || duration < 0
      puts "That is not a valid duration. Please try again."
    else
      break
    end
  end

  duration_months = if period == 'MONTHS'
    duration
  else
    duration * 12
  end

  puts "What is the loan's Annual Percentage Rate (APR)?"

  loan_apr = ''
  loop do
    loan_apr = gets.chomp
    loan_apr.delete! "%"
    loan_apr = BigDecimal.new(loan_apr)
    if loan_apr.zero? || loan_apr < 0
      puts "That is not a valid APR. Please try again."
    else
      loan_apr /= 100
      break
    end
  end

  loan_mpr = BigDecimal.new(loan_apr / 12)

  monthly_payment = loan_amount *
                    (loan_mpr /
                    (1 - (1 + loan_mpr)**-duration_months))

  puts "The monthly payment is $#{monthly_payment.round(2).to_f}."

  puts "Would you like to perform another loan payment calculation (Y or N)?"

  repeat_main_loop = gets.chomp

  break unless repeat_main_loop.downcase.start_with?('y')
end

puts "Thank you for using the Loan Payment Calculator!"
puts "Goodbye!"
