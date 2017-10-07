# sieve.rb

# class Sieve
#   def initialize(ceiling)
#     raise ArgumentError, "Input must be a number." unless ceiling.is_a? Numeric
#     @ceiling = ceiling
#     @primes = (2..ceiling).to_a
#   end
#
#   def primes
#     return @primes if @primes.empty?
#
#     index = 0
#     loop do
#       break if @primes[index] > Math.sqrt(@ceiling).to_i
#       shake(@primes[index])
#       index += 1
#     end
#
#     @primes
#   end
#
#   def shake(factor)
#     @primes.delete_if do |number|
#       next if number == factor
#       number % factor == 0
#     end
#   end
# end



# refactor: no need to explicit iterate by index, modifying in place while iterating works as expected in this case
class Sieve
  def initialize(ceiling)
    raise ArgumentError, "Input must be a number." unless ceiling.is_a? Numeric
    @primes = (2..ceiling).to_a
  end

  def primes
    @primes.each do |factor|
      @primes.delete_if { |number| number != factor && number % factor == 0 }
    end

    @primes
  end
end
