# odd_words_test.rb

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative 'odd_words'

# # tests for standard solution
# class OddWordsTest < Minitest::Test
#   def test_given_example
#     odd_words = OddWords.new("whats the matter with kansas.")
#     assert_equal "whats eht matter htiw kansas.", odd_words.process
#   end
#
#   def test_given_example_with_multiple_spaces
#     odd_words = OddWords.new("whats   the matter  with    kansas.")
#     assert_equal "whats eht matter htiw kansas.", odd_words.process
#   end
#
#   def test_given_example_with_multiple_ending_spaces
#     odd_words = OddWords.new("whats the matter with kansas   .")
#     assert_equal "whats eht matter htiw kansas.", odd_words.process
#   end
#
#   def test_one_word_sentence
#     odd_words = OddWords.new("whats.")
#     assert_equal "whats.", odd_words.process
#   end
#
#   def test_one_word_sentence_with_multiple_spaces
#     odd_words = OddWords.new("whats   .")
#     assert_equal "whats.", odd_words.process
#   end
#
#   def test_odd_word_ending
#     odd_words = OddWords.new("hello   world.")
#     assert_equal "hello dlrow.", odd_words.process
#   end
# end

# tests for bonus solution
class OddWordsTest < Minitest::Test
  def test_given_example
    iosim_in = StringIO.new("whats the matter with kansas.")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "whats eht matter htiw kansas.", iosim_out.string
  end

  def test_given_example_with_multiple_spaces
    iosim_in = StringIO.new("whats   the matter  with    kansas.")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "whats eht matter htiw kansas.", iosim_out.string
  end

  def test_given_example_with_multiple_ending_spaces
    iosim_in = StringIO.new("whats the matter with kansas   .")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "whats eht matter htiw kansas.", iosim_out.string
  end

  def test_one_word_sentence
    iosim_in = StringIO.new("whats.")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "whats.", iosim_out.string
  end

  def test_one_word_sentence_with_multiple_spaces
    iosim_in = StringIO.new("whats   .")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "whats.", iosim_out.string
  end

  def test_odd_word_ending
    iosim_in = StringIO.new("hello   world.")
    iosim_out = StringIO.new
    odd_words = OddWords.new(input: iosim_in, output: iosim_out)
    odd_words.process
    assert_equal "hello dlrow.", iosim_out.string
  end
end
