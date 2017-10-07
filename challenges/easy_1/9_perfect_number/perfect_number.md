
[comment]: # (perfect_number.md)

# Easy 1-9: Perfect Number - 10/6/2017

---
## Perfect Number

The Greek mathematician Nicomachus devised a classification scheme for natural numbers, identifying each as belonging uniquely to the categories of abundant, perfect, or deficient. A perfect number equals the sum of its positive divisors — the pairs of numbers whose product yields the target number, excluding the number itself. This sum is known as the Aliquot sum.

Perfect: Sum of factors = number
Abundant: Sum of factors > number
Deficient: Sum of factors < number
Examples:

6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 + 3.
28 is a perfect number because 28 = 1 + 2 + 4 + 7 + 14.
Prime numbers 7, 13, etc are deficient by the Nicomachus classification.
Write a program that can tell if a number is perfect, abundant or deficient.

Test suite:
``` ruby
require 'minitest/autorun'
require_relative 'perfect_number'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises RuntimeError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end
```

### Solution
* input: positive integer
* output: string representing classification of input: 'deficient', 'perfect', or 'abundant'
* edge cases:
  - input not integer -> raise InputError
  - input not positive -> raise RuntimeError


* Pseudocode
  - validate input
    + raise InputError unless input is an Integer
    + raise RuntimeError unless input is positive
  - determine number's divisors (start with array pre-loaded with integer 1)
    + iterate from 2 to number's square root
    + add current item and it's pair factor to divisor array if number is evenly divisible by it
  - reduce the divisors by summing
    + return 'deficient' if sum is less than number
    + return 'perfect' if sum is equal to number
    + return 'abundant' if sum is greater than number


* Solution: [perfect_number.rb](perfect_number.rb)
