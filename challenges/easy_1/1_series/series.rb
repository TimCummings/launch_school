# series.rb

# Solution #1: working with arrays
# class Series
#   attr_reader :digits
#
#   def initialize(string_of_digits)
#     @digits = string_of_digits.chars.map(&:to_i)
#   end
#
#   def slices(sub_length)
#     raise ArgumentError, "Slice size is too big!" if sub_length > @digits.length
#
#     idx = 0
#     results = []
#
#     while idx + sub_length <= @digits.size
#       sub_end = idx + sub_length - 1
#       results << @digits[idx..sub_end]
#       idx += 1
#     end
#
#     results
#   end
# end



# Solution #2: working with strings
# class Series
#   def initialize(string_of_digits)
#     @digits = string_of_digits
#   end
#
#   def slices(sub_length)
#     unless sub_length <= @digits.length
#       raise(ArgumentError, "Slice size is too big!")
#     end
#
#     index = 0
#     results = []
#
#     while index + sub_length <= @digits.length
#       results << @digits.slice(index, sub_length)
#       index += 1
#     end
#
#     results.map { |ary| ary.chars.map(&:to_i) }
#   end
# end



# Refactor with Array#slice and more idiomatic iteration
class Series
  attr_reader :digits

  def initialize(string_of_digits)
    @digits = string_of_digits.chars.map(&:to_i)
  end

  def slices(sub_length)
    raise ArgumentError, "Slice size is too big!" if sub_length > @digits.length

    @digits.each_index.with_object([]) do |index, results|
      break results if index > @digits.size - sub_length
      results << @digits.slice(index, sub_length)
    end
  end
end
