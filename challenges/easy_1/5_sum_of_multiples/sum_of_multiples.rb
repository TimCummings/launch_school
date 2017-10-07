# sum_of_multiples.rb

class SumOfMultiples
  @@default_factors = [3, 5]

  attr_accessor :factors

  def self.valid_input?(factor)
    factor.is_a?(Integer) && factor > 0
  end

  def self.multiple?(number)
    @@default_factors.any? { |factor| number % factor == 0 }
  end

  def self.to(ceiling)
    raise ArgumentError, "Input must be a positive integer." unless valid_input?(ceiling)
    (1...ceiling).select { |number| multiple?(number) }.reduce(0, :+)
  end

  def initialize(*factors)
    @factors = if factors.empty?
        @@default_factors
      else
        raise ArgumentError, "Input must be positive integers." unless factors.all? { |factor| valid_input?(factor) }
        factors
      end
  end

  def valid_input?(factor)
    factor.is_a?(Integer) && factor > 0
  end

  def multiple?(number)
    @factors.any? { |factor| number % factor == 0 }
  end

  def to(ceiling)
    raise ArgumentError, "Input must be a positive integer." unless valid_input?(ceiling)
    (1...ceiling).select { |number| multiple?(number) }.reduce(0, :+)
  end
end
