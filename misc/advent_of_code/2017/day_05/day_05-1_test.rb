# day_05-1_test.rb

require 'minitest/autorun'
require_relative 'day_05-1'

class JumperTest < Minitest::Test
  def setup
    @test_jumper = Jumper.new('day_05_test_input.txt')
  end

  def test_initialize
    assert_equal [0, 3, 0, 1, -3], @test_jumper.offsets
  end

  def test_find_exit
    assert_equal 5, @test_jumper.find_exit
  end
end
