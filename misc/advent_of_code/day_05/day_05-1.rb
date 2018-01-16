# day_05-1.rb

class Jumper
  attr_reader :offsets

  def initialize(filename)
    @steps = 0
    @cur_idx = 0
    # @jump = 0
    @offsets = Array.new

    File.open(filename).each { |x| @offsets << x.to_i }
  end

  def find_exit
    loop do
      @jump = @offsets[@cur_idx]
      break if @jump.nil?
      @offsets[@cur_idx] += 1
      @cur_idx += @jump
      @steps += 1
      break if @cur_idx.negative?
    end

    @steps
  end
end

j1 = Jumper.new('day_05_input.txt')
puts j1.find_exit

# Part 1 Answer: 381680
