# trinary.rb

class Trinary
  def initialize(trinary_string)
    @trinary_string = trinary_string
  end

  def to_decimal
    return 0 if @trinary_string =~ /[^012]/
    digits = @trinary_string.chars.reverse
    digits.map.with_index { |x, idx| x.to_i * 3 ** idx }.reduce(:+)
  end
end
