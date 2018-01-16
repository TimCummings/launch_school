# day_03-2.rb

class SpiralSquare
  attr_reader :sequence, :x, :y, :value

  def initialize(sequence, x, y, value = nil)
    @sequence = sequence
    @x = x
    @y = y
    @value = value
  end

  def shortest_path(other = SpiralSquare.new(1, 0, 0))
    (x - other.x).abs + (y - other.y).abs
  end

  def adjacent?(other)
    shortest_path(other) == 1 ||
    shortest_path(other) == 2 && x != other.x && y != other.y
  end
end

class Spiraler
  DIRECTIONS = [:right, :up, :left, :down]

  attr_reader :requested, :direction, :sequence, :line_length, :x, :y, :squares

  def initialize(requested)
    @requested = requested
    @direction = 0
    @sequence = 1
    @line_length = 1
    @x = 0
    @y = 0
    @squares = [SpiralSquare.new(sequence, x, y, 1)]
  end

  def allocate_square(value = nil)
    @sequence += 1
    case DIRECTIONS[direction]
    when :right then @x += 1
    when :up    then @y += 1
    when :left  then @x -= 1
    when :down  then @y -= 1
    end
    squares << SpiralSquare.new(sequence, x, y, calculate_value)
  end

  def allocate_line
    line_length.times do
      allocate_square
      break if sequence >= requested || last.value > requested
    end
  end

  def allocate_all
    loop do
      allocate_line
      change_direction
      break if sequence >= requested || last.value > requested
    end
  end

  def change_direction
    @direction = (direction + 1) % DIRECTIONS.size
    # line_length increases when changing direction to right or left
    @line_length += 1 if direction.even?
  end

  def last
    squares.last
  end

  def calculate_value
    adjacent_squares = squares.select do |square|
      square.adjacent? SpiralSquare.new(sequence, x, y)
    end

    adjacent_squares.reduce(0) { |sum, square| sum + square.value }
  end
end

puzzle_input = 347991
puzzle = Spiraler.new(puzzle_input)
puzzle.allocate_all
puts puzzle.last.value

# Part 2 Answer: 349975
