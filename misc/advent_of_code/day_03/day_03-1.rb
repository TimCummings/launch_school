# day_03-1.rb

class SpiralSquare
  attr_reader :sequence, :x, :y

  def initialize(sequence, x, y)
    @sequence = sequence
    @x = x
    @y = y
  end

  def shortest_path
    x.abs + y.abs
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
    @squares = [SpiralSquare.new(sequence, x, y)]
  end

  def allocate_square
    @sequence += 1
    case DIRECTIONS[direction]
    when :right then @x += 1
    when :up    then @y += 1
    when :left  then @x -= 1
    when :down  then @y -= 1
    end
    squares << SpiralSquare.new(sequence, x, y)
  end

  def allocate_line
    line_length.times do
      allocate_square
      break unless sequence < requested
    end
  end

  def allocate_all
    while sequence < requested do
      allocate_line
      change_direction
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
end

puzzle_input = 347991
puzzle = Spiraler.new(puzzle_input)
puzzle.allocate_all
puts puzzle.last.shortest_path

# Part 1 Answer: 480
