# octal.rb

# class Octal
#   def initialize(octal_string)
#     @octal_string = octal_string
#   end
#
#   def to_decimal
#     return 0 if @octal_string =~ /\D/
#
#     digits = @octal_string.chars.reverse
#     digits.map!.with_index do |digit, idx|
#       return 0 if digit > '7'
#       digit.to_i * 8 ** idx
#     end
#     digits.reduce(:+)
#   end
# end



# refactor: already using regex to check for non-digit characters, might as well perform all edge case checking here (include checking for digits greater than 7)
class Octal
  def initialize(octal_string)
    @octal_string = octal_string
  end

  def to_decimal
    return 0 if @octal_string =~ /\D|[89]/

    digits = @octal_string.chars.reverse
    digits.map!.with_index { |digit, idx| digit.to_i * (8 ** idx) }
    digits.reduce(:+)
  end
end
