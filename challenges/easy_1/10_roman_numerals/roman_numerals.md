
[comment]: # (roman_numerals.md)

# Easy 1-10: Roman Numerals - 10/6/2017

---
## Roman Numerals

The Romans were a clever bunch. They conquered most of Europe and ruled it for hundreds of years. They invented concrete and straight roads and even bikinis. One thing they never discovered though was the number zero. This made writing and dating extensive histories of their exploits slightly more challenging, but the system of numbers they came up with is still in use today. For example the BBC uses Roman numerals to date their programmes.

The Romans wrote numbers using letters - I, V, X, L, C, D, M. (notice these letters have lots of straight lines and are hence easy to hack into stone tablets).
```
 1  => I
10  => X
 7  => VII
 ```
There is no need to be able to convert numbers larger than about 3000. (The Romans themselves didn't tend to go any higher)

Wikipedia says: Modern Roman numerals ... are written by expressing each digit separately starting with the left most digit and skipping any digit with a value of zero.

To see this in practice, consider the example of 1990. In Roman numerals 1990 is MCMXC:

1000=M
900=CM
90=XC
2008 is written as MMVIII:

2000=MM
8=VIII
See also: [http://www.novaroma.org/via_romana/numbers.html](http://www.novaroma.org/via_romana/numbers.html)

Test Suite
``` ruby
require 'minitest/autorun'
require_relative 'roman_numerals'

class RomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', 1.to_roman
  end

  def test_2
    skip
    assert_equal 'II', 2.to_roman
  end

  def test_3
    skip
    assert_equal 'III', 3.to_roman
  end

  def test_4
    skip
    assert_equal 'IV', 4.to_roman
  end

  def test_5
    skip
    assert_equal 'V', 5.to_roman
  end

  def test_6
    skip
    assert_equal 'VI', 6.to_roman
  end

  def test_9
    skip
    assert_equal 'IX', 9.to_roman
  end

  def test_27
    skip
    assert_equal 'XXVII', 27.to_roman
  end

  def test_48
    skip
    assert_equal 'XLVIII', 48.to_roman
  end

  def test_59
    skip
    assert_equal 'LIX', 59.to_roman
  end

  def test_93
    skip
    assert_equal 'XCIII', 93.to_roman
  end

  def test_141
    skip
    assert_equal 'CXLI', 141.to_roman
  end

  def test_163
    skip
    assert_equal 'CLXIII', 163.to_roman
  end

  def test_402
    skip
    assert_equal 'CDII', 402.to_roman
  end

  def test_575
    skip
    assert_equal 'DLXXV', 575.to_roman
  end

  def test_911
    skip
    assert_equal 'CMXI', 911.to_roman
  end

  def test_1024
    skip
    assert_equal 'MXXIV', 1024.to_roman
  end

  def test_3000
    skip
    assert_equal 'MMM', 3000.to_roman
  end
end
```

---
### Solution
* input: integer calling object (Add to core class? I thought we weren't supposed to....)
* output: string representing integer in Roman numerals
* edge cases:
  - ignoring edge cases for now since `#to_roman` will be called directly on integers


* Pseudocode
  - separate integer into array of digits
  - map this digit array, replacing each digit with its Roman numeral pattern by referencing an array of patterns using the digit as an index
    + each resulting pattern is an array of symbols
  - map the resulting patterns array, replacing a pattern with the appropriate Roman numeral characters by referencing an array of hashes
    + since the digits array is reversed (first digit is ones place-value), the digit index will reference the appropriate hash from the array of hashes
    + map each pattern, replacing symbols with the appropriate Roman numeral characters (using the symbols as hash keys)
  - reverse the resulting array of arrays of numerals and join the numerals together for the final result


* Solution: [roman_numerals.rb](roman_numerals.rb)
