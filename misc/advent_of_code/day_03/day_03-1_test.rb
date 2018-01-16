# day_03-1_test.rb

require 'minitest/autorun'
require_relative 'day_03-1'

class SpiralSquareTest < Minitest::Test
  def test_shortest_path
    seq_1 = SpiralSquare.new(1, 0, 0)
    assert_equal 0, seq_1.shortest_path

    seq_2 = SpiralSquare.new(2, 1, 0)
    assert_equal 1, seq_2.shortest_path

    seq_3 = SpiralSquare.new(3, 1, 1)
    assert_equal 2, seq_3.shortest_path

    seq_4 = SpiralSquare.new(4, 0, 1)
    assert_equal 1, seq_4.shortest_path

    seq_5 = SpiralSquare.new(5, -1, 1)
    assert_equal 2, seq_5.shortest_path

    seq_6 = SpiralSquare.new(6, -1, 0)
    assert_equal 1, seq_6.shortest_path

    seq_7 = SpiralSquare.new(7, -1, -1)
    assert_equal 2, seq_7.shortest_path

    seq_8 = SpiralSquare.new(8, 0, -1)
    assert_equal 1, seq_8.shortest_path

    seq_9 = SpiralSquare.new(9, 1, -1)
    assert_equal 2, seq_9.shortest_path

    seq_25 = SpiralSquare.new(25, 2, -2)
    assert_equal 4, seq_25.shortest_path

    seq_1024 = SpiralSquare.new(1024, -15, 16)
    assert_equal 31, seq_1024.shortest_path
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
