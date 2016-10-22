# hard_1.rb

# Question 1
# undefined local variable error
  # WRONG - greeting is nil here, and no "undefined method or local variable" exception is thrown. Typically, when you reference an uninitialized variable, Ruby will raise an exception, stating that it’s undefined. However, when you initialize a local variable within an if block, even if that if block doesn’t get executed, the local variable is initialized to nil.

# Question 2
# { a => 'hi there' }

# Question 3
  # A)  one is: one
  #     two is: two
  #     three is: three

  # B)  one is: one
  #     two is: two
  #     three is: three

  # C)  one is: two
  #     two is: three
  #     three is: one

# Question 4
# def generate_UUID()
#   hex_chars = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
#   UUID = ''
#   8.times { |_| UUID << hex_chars.sample }
#   UUID << '-'
#   4.times { |_| UUID << hex_chars.sample }
#   UUID << '-'
#   4.times { |_| UUID << hex_chars.sample }
#   UUID << '-'
#   4.times { |_| UUID << hex_chars.sample }
#   UUID << '-'
#   12.times { |_| UUID << hex_chars.sample }
#   UUID
# end

# Question 5
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   return false if dot_separated_words.size != 4
#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     return false if !is_an_ip_number?(word)
#   end
#   return true
# end
