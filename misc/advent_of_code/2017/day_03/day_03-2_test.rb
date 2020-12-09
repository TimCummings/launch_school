# day_03-2_test.rb

require 'minitest/autorun'
require_relative 'day_03-2'

class SpiralSquareTest < Minitest::Test

  def setup
    @seq_1 = SpiralSquare.new(1, 0, 0)
    @seq_2 = SpiralSquare.new(2, 1, 0)
    @seq_3 = SpiralSquare.new(3, 1, 1)
    @seq_4 = SpiralSquare.new(4, 0, 1)
    @seq_5 = SpiralSquare.new(5, -1, 1)
    @seq_6 = SpiralSquare.new(6, -1, 0)
    @seq_7 = SpiralSquare.new(7, -1, -1)
    @seq_8 = SpiralSquare.new(8, 0, -1)
    @seq_9 = SpiralSquare.new(9, 1, -1)
    @seq_11 = SpiralSquare.new(11, 2, 0)
    @seq_25 = SpiralSquare.new(25, 2, -2)
    @seq_1024 = SpiralSquare.new(1024, -15, 16)
  end

  def test_shortest_path_to_origin
    assert_equal 0, @seq_1.shortest_path
    assert_equal 1, @seq_2.shortest_path
    assert_equal 2, @seq_3.shortest_path
    assert_equal 1, @seq_4.shortest_path
    assert_equal 2, @seq_5.shortest_path
    assert_equal 1, @seq_6.shortest_path
    assert_equal 2, @seq_7.shortest_path
    assert_equal 1, @seq_8.shortest_path
    assert_equal 2, @seq_9.shortest_path
    assert_equal 4, @seq_25.shortest_path
    assert_equal 31, @seq_1024.shortest_path
  end

  def test_shortest_path_to_other
    assert_equal 35, @seq_25.shortest_path(@seq_1024)
    assert_equal 35, @seq_1024.shortest_path(@seq_25)
  end

  def test_adjacent?
    assert_equal false, @seq_1.adjacent?(@seq_1)
    assert_equal true, @seq_1.adjacent?(@seq_2)
    assert_equal true, @seq_1.adjacent?(@seq_3)
    assert_equal true, @seq_1.adjacent?(@seq_4)
    assert_equal true, @seq_1.adjacent?(@seq_5)
    assert_equal true, @seq_1.adjacent?(@seq_6)
    assert_equal true, @seq_1.adjacent?(@seq_7)
    assert_equal true, @seq_1.adjacent?(@seq_8)
    assert_equal true, @seq_1.adjacent?(@seq_9)
    assert_equal true, @seq_9.adjacent?(@seq_25)
    assert_equal false, @seq_1.adjacent?(@seq_11)
    assert_equal false, @seq_1.adjacent?(@seq_25)
    assert_equal false, @seq_25.adjacent?(@seq_1024)
  end
end

class SpiralerTest < Minitest::Test
  def test_last_square
    seq_1 = Spiraler.new(1)
    seq_1.allocate_all
    assert_equal 0, seq_1.last.x
    assert_equal 0, seq_1.last.y

    seq_25 = Spiraler.new(25)
    seq_25.allocate_all
    assert_equal 2, seq_25.last.x
    assert_equal -2, seq_25.last.y

    seq_1024 = Spiraler.new(1024)
    seq_1024.allocate_all
    assert_equal -15, seq_1024.last.x
    assert_equal 16, seq_1024.last.y
  end
end
