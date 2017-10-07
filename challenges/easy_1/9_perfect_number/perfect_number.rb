# perfect_number.rb

# class PerfectNumber
#   def self.classify(num)
#     raise InputError, "Must enter a positive integer." unless num.is_a? Integer
#     raise RuntimeError, "Integer must be positive." unless num.positive?
#
#     case divisors(num).reduce(:+) <=> num
#     when -1 then 'deficient'
#     when 0 then 'perfect'
#     else 'abundant'
#     end
#   end
#
#   def self.divisors(num)
#     return [1] if num == 1
#
#     2.upto(Math.sqrt(num).to_i).with_object([1]) do |factor, divisors|
#       if num % factor == 0
#         divisors << factor
#         divisors << num / factor
#       end
#     end
#   end
# end

# refactor for a simpler solution (but slower with large input)
# class PerfectNumber
#   def self.classify(num)
#     raise InputError, 'Must enter a positive integer.' unless num.is_a? Integer
#     raise RuntimeError, 'Integer must be positive.' unless num.positive?
#
#     divisors = (1...num).select { |x| num % x == 0 }
#     aliquot_sum = divisors.reduce(:+)
#
#     case
#     when aliquot_sum < num  then 'deficient'
#     when aliquot_sum == num then 'perfect'
#     else 'abundant'
#     end
#   end
# end

# compare speeds with:
# puts PerfectNumber.classify(123456789)
