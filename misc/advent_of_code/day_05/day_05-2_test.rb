# day_05-2_test.rb

require 'minitest/autorun'
require_relative 'day_05-2'

class JumperTest < Minitest::Test
  def setup
    @test_jumper = Jumper.new('day_05_test_input.txt')
  end

  def test_initialize
    assert_equal [0, 3, 0, 1, -3], @test_jumper.offsets
  end

  def test_find_exit
    assert_equal 10, @test_jumper.find_exit
  end
end
