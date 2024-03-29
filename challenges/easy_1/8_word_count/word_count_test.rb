# word_count_test.rb

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative 'word_count'

# Test data version:

class PhraseTest < Minitest::Test
  def test_count_one_word
    phrase = Phrase.new('word')
    counts = { 'word' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_one_of_each
    phrase = Phrase.new('one of each')
    counts = { 'one' => 1, 'of' => 1, 'each' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_multiple_occurrences
    phrase = Phrase.new('one fish two fish red fish blue fish')
    counts = { 'one' => 1, 'fish' => 4, 'two' => 1, 'red' => 1, 'blue' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_count_everything_just_once
    phrase = Phrase.new('all the kings horses and all the kings men')
    phrase.word_count # count it an extra time
    counts = {
      'all' => 2, 'the' => 2, 'kings' => 2,
      'horses' => 1, 'and' => 1, 'men' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_ignore_punctuation
    phrase = Phrase.new('car : carpet as java : javascript!!&@$%^&')
    counts = {
      'car' => 1, 'carpet' => 1, 'as' => 1,
      'java' => 1, 'javascript' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_handles_cramped_lists
    phrase = Phrase.new('one,two,three')
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_handles_expanded_lists
    phrase = Phrase.new("one,\ntwo,\nthree")
    counts = { 'one' => 1, 'two' => 1, 'three' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_include_numbers
    phrase = Phrase.new('testing, 1, 2 testing')
    counts = { 'testing' => 2, '1' => 1, '2' => 1 }
    assert_equal counts, phrase.word_count
  end

  def test_normalize_case
    phrase = Phrase.new('go Go GO')
    counts = { 'go' => 3 }
    assert_equal counts, phrase.word_count
  end


  def test_with_apostrophes
    phrase = Phrase.new("First: don't laugh. Then: don't cry.")
    counts = {
      'first' => 1, "don't" => 2, 'laugh' => 1,
      'then' => 1, 'cry' => 1
    }
    assert_equal counts, phrase.word_count
  end

  def test_with_quotations
    phrase = Phrase.new("Joe can't tell between 'large' and large.")
    counts = {
      'joe' => 1, "can't" => 1, 'tell' => 1,
      'between' => 1, 'large' => 2, 'and' => 1
    }
    assert_equal counts, phrase.word_count
  end
end
