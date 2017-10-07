
[comment]: # (anagrams.md)

# Easy 1-6: Anagrams - 9/29/2017

---
## Anagrams

Write a program that, given a word and a list of possible anagrams, selects the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like "enlists" "google" "inlets" "banana" the program should return a list containing "inlets". Please read the test suite for exact rules of anagrams.

Test suite:
``` ruby
require 'minitest/autorun'
require_relative 'anagram'

class AnagramTest < Minitest::Test
  def test_no_matches
    detector = Anagram.new('diaper')
    assert_equal [], detector.match(%w(hello world zombies pants))
  end

  def test_detect_simple_anagram
    skip
    detector = Anagram.new('ant')
    anagrams = detector.match(%w(tan stand at))
    assert_equal ['tan'], anagrams
  end

  def test_detect_multiple_anagrams
    skip
    detector = Anagram.new('master')
    anagrams = detector.match(%w(stream pigeon maters))
    assert_equal %w(maters stream), anagrams.sort
  end

  def test_does_not_confuse_different_duplicates
    skip
    detector = Anagram.new('galea')
    assert_equal [], detector.match(['eagle'])
  end

  def test_identical_word_is_not_anagram
    skip
    detector = Anagram.new('corn')
    anagrams = detector.match %w(corn dark Corn rank CORN cron park)
    assert_equal ['cron'], anagrams
  end

  def test_eliminate_anagrams_with_same_checksum
    skip
    detector = Anagram.new('mass')
    assert_equal [], detector.match(['last'])
  end

  def test_eliminate_anagram_subsets
    skip
    detector = Anagram.new('good')
    assert_equal [], detector.match(%w(dog goody))
  end

  def test_detect_anagram
    skip
    detector = Anagram.new('listen')
    anagrams = detector.match %w(enlists google inlets banana)
    assert_equal ['inlets'], anagrams
  end

  def test_multiple_anagrams
    skip
    detector = Anagram.new('allergy')
    anagrams =
      detector.match %w( gallery ballerina regally clergy largely leading)
    assert_equal %w(gallery largely regally), anagrams.sort
  end

  def test_anagrams_are_case_insensitive
    skip
    detector = Anagram.new('Orchestra')
    anagrams = detector.match %w(cashregister Carthorse radishes)
    assert_equal ['Carthorse'], anagrams
  end

  # I am adding this test to make sure subject case is accounted for correctly
  def test_identical_word_is_not_anagram_subject_case
    detector = Anagram.new('Corn')
    anagrams = detector.match %w(corn dark Corn rank CORN cron park)
    assert_equal ['cron'], anagrams
  end
end
```

### Solution
* input:
  - instantiation: string representing subject (word to be anagrammed)
  - `Anagram#match` call: array of one or more strings from which to select anagrams
* output:
  - array that is either empty or contains one or more input strings that `Anagram#match` verified as anagrams
* edge cases:
  - instantiation:
    + no argument: raise ArgumentError
    + empty string: `#match` call -> return empty array
  - `Anagram#match` call:
    + no argument: raise ArgumentError
    + argument isn't an array: raise ArgumentError
    + empty array: return empty array
    + array with non-string element: raise ArgumentError


* Pseudocode
  - guard against edge cases
    + instantiation: no argument: ArgumentError raised automatically
    + `Anagram#match` call:
      * no argument: ArgumentError raised automatically
      * argument isn't array: raise ArgumentError
      * array contains non-string element: raise ArgumentError during iteration
      * **missed a big one:** skip a candidate if it is the same word as the subject (ignoring case)
  - count characters of subject (ignoring case and whitespace)
    + extract to method that outputs hash with downcased characters as keys and integers as counts
    + initialize a new, empty hash (with integer 0 as default value)
    + iterate through the provided string (with whitespace stripped)
      * increment the current character's value in the hash
    + return the hash of character counts
  - iterate through the input array
    + raise ArgumentError if current element is not a string
    + go to the next iteration of the candidate is the same as subject (ignoring case)
    + compare subject's character count to current element's character count (ignoring case and whitespace), adding the current element to a results array if the counts are exactly the same
  - return the results array


* Solution: [anagram.rb](anagram.rb)
