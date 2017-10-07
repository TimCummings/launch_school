
[comment]: # (word_count.md)

# Easy 1-8: Word Count - 9/30/2017

---
## Word Count

Write a program that, given a phrase, can count the occurrences of each word in that phrase.

For example, if we count the words for the input "olly olly in come free", we should get:
```
olly: 2
in: 1
come: 1
free: 1
```

Test suite:
``` ruby
require 'minitest/autorun'
require_relative 'word_count'

# Test data version:

class PhraseTest < Minitest::Test
  def test_count_one_word
    phrase = Phrase.new('word')
    counts = { 'word' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_one_of_each
    skip
    phrase = Phrase.new('one of each')
    counts = { 'one' => 1, 'of' => 1, 'each' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_multiple_occurrences
    skip
    phrase = Phrase.new('one fish two fish red fish blue fish')
    counts = { 'one' => 1, 'fish' => 4, 'two' => 1, 'red' => 1, 'blue' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_everything_just_once
    skip
    phrase = Phrase.new('all the kings horses and all the kings men')
    phrase.word_count # count it an extra time
    counts = {
      'all' => 2, 'the' => 2, 'kings' => 2,
      'horses' => 1, 'and' => 1, 'men' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_ignore_punctuation
    skip
    phrase = Phrase.new('car : carpet as java : javascript!!&@$%^&')
    counts = {
      'car' => 1, 'carpet' => 1, 'as' => 1,
      'java' => 1, 'javascript' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_handles_cramped_lists
    skip
    phrase = Phrase.new('one,two,three')
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_handles_expanded_lists
    skip
    phrase = Phrase.new("one,\ntwo,\nthree")
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_include_numbers
    skip
    phrase = Phrase.new('testing, 1, 2 testing')
    counts = { 'testing' => 2, '1' => 1, '2' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_normalize_case
    skip
    phrase = Phrase.new('go Go GO')
    counts = { 'go' => 3 }
    assert_equal counts, phrase.word_count
  end


  def test_with_apostrophes
    skip
    phrase = Phrase.new("First: don't laugh. Then: don't cry.")
    counts = {
      'first' => 1, "don't" => 2, 'laugh' => 1,
      'then' => 1, 'cry' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_with_quotations
    skip
    phrase = Phrase.new("Joe can't tell between 'large' and large.")
    counts = {
      'joe' => 1, "can't" => 1, 'tell' => 1,
      'between' => 1, 'large' => 2, 'and' => 1
    }
    assert_equal counts, phrase.word_count
  end
end
```


### Solution
* input: string representing a phrase
* output: hash representing word counts: keys are strings representing words, values are integers representing how many times the word appears in the phrase
* edge cases:
  - no argument -> automatically raises ArgumentError
  - input not a string -> raise ArgumentError


* Pseudocode
  - strip invalid characters from the phrase, replacing with whitespace; valid characters:
    + a-z
    + A-Z
    + 0-9
    + single quote if used as contraction (don't) or possession (John's)
    + whitespace
  - create a results hash with integer 0 as the default value
  - split the phrase into an array of words (split at whitespace)
  - iterate the word array
    + using the current word as a key (ignoring case), increment the associated value in the results hash
  - return the results hash


* Solution: [word_count.rb](word_count.rb)
