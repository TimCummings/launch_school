# day_04-1_test.rb

require 'minitest/autorun'
require_relative 'day_04-1'

class TestPhraseValidator < Minitest::Test
  def test_valid_phrase?
    assert_equal true, valid_phrase?('aa bb cc dd ee')
    assert_equal false, valid_phrase?('aa bb cc dd aa')
    assert_equal true, valid_phrase?('aa bb cc dd aaa')
    assert_equal false, valid_phrase?('aa bb 1234 dd ee')
  end

  def test_valid_word?
    assert_equal true, valid_word?('aa')
    assert_equal false, valid_word?('ABC')
    assert_equal false, valid_word?('123')
    assert_equal true, valid_word?('abcdefghijklmnopqrstuvwxyz')
    assert_equal false, valid_word?('aBcD123eFg')
    assert_equal false, valid_word?('no!')
    assert_equal false, valid_word?('asdf lkjh')
  end
end
