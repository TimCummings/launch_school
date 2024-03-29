
[comment]: # (scrabble_score.md)

## Easy 2-2: Scrabble Score - 10/9/2017

Write a program that, given a word, computes the scrabble score for that word.

##### Letter Values
You'll need these:
```
Letter                           Value
A, E, I, O, U, L, N, R, S, T       1
D, G                               2
B, C, M, P                         3
F, H, V, W, Y                      4
K                                  5
J, X                               8
Q, Z                               10
```

##### Examples

"cabbage" should be scored as worth 14 points:
* 3 points for C
* 1 point for A, twice
* 3 points for B, twice
* 2 points for G
* 1 point for E


And to total:
* 3 + 2*1 + 2*3 + 2 + 1
* = 3 + 2 + 6 + 3
* = 5 + 9
* = 14


##### Test Suite
``` ruby
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative 'scrabble_score'

class ScrabbleTest < Minitest::Test
  def test_empty_word_scores_zero
    assert_equal 0, Scrabble.new('').score
  end

  def test_whitespace_scores_zero
    skip
    assert_equal 0, Scrabble.new(" \t\n").score
  end

  def test_nil_scores_zero
    skip
    assert_equal 0, Scrabble.new(nil).score
  end

  def test_scores_very_short_word
    skip
    assert_equal 1, Scrabble.new('a').score
  end

  def test_scores_other_very_short_word
    skip
    assert_equal 4, Scrabble.new('f').score
  end

  def test_simple_word_scores_the_number_of_letters
    skip
    assert_equal 6, Scrabble.new('street').score
  end

  def test_complicated_word_scores_more
    skip
    assert_equal 22, Scrabble.new('quirky').score
  end

  def test_scores_are_case_insensitive
    skip
    assert_equal 41, Scrabble.new('OXYPHENBUTAZONE').score
  end

  def test_convenient_scoring
    skip
    assert_equal 13, Scrabble.score('alacrity')
  end
end
```

---
### Solution
* input: string representing scrabble word
* output: integer representing scrabble score for input
* edge cases:
  - empty string, whitespace, or nil -> 0
  - invalid characters? -> raise RuntimeError
* Notes:
  - case insensitive
  - last test case is a class method


* Pseudocode
  - handle edge cases
    + return 0 if input is empty string, whitespace string, or nil
    + raise RuntimeError if invalid characters are present
  - split input string into array of characters
  - map this character array, replacing each character with the appropriate score (using a hash to lookup scores)
  - reduce the array of scores by summing


* Solution: [scrabble_score.rb](scrabble_score.rb)
