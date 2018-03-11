# rps_keeping_score_class.rb

class Move
  VALUES = %w[rock paper scissors].freeze

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def <(other)
    (rock? && other.paper?) ||
      (paper? && other.scissors?) ||
      (scissors? && other.rock?)
  end

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?)
  end

  def to_s
    @value
  end
end

class Score
  attr_accessor :score

  @to_win = 10

  def self.to_win
    @to_win
  end

  def initialize
    @score = 0
  end

  def increment
    @score += 1
  end

  def reset
    @score = 0
  end

  def win?
    score >= self.class.to_win
  end

  def to_s
    @score.to_s
  end
end

class Player
  attr_accessor :name, :move, :score

  def initialize
    set_name
    @score = Score.new
  end
end

class Human < Player
  def set_name
    entry = nil
    loop do
      puts 'Please enter your name:'
      entry = gets.chomp
      break unless entry.empty?
      puts 'Sorry, must enter a name.'
    end
    self.name = entry
  end

  def choose
    choice = nil
    loop do
      puts "\nPlease choose rock, paper, or scissors -"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie Sonny Number 5].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "\nWelcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_round
    display_moves
    if human.move > computer.move
      record_human_winner
    elsif human.move < computer.move
      record_computer_winner
    else
      puts "\nIt's a tie!"
    end
    display_scores
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def record_human_winner
    puts "\n#{human.name} won!"
    human.score.increment
  end

  def record_computer_winner
    puts "\n#{computer.name} won!"
    computer.score.increment
  end

  def display_scores
    puts "\n============"
    puts "Scores:"
    puts "------------"
    puts "#{human.name} - #{human.score}"
    puts "#{computer.name} - #{computer.score}"
  end

  def display_winner
    puts "\n#{human.name} wins!" if human.score.win?
    puts "\n#{computer.name} wins!" if computer.score.win?
  end

  def play_again?
    answer = nil
    loop do
      puts "\nWould you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts 'Sorry, must be y or n.'
    end

    return true if answer.downcase == 'y'
    false
  end

  def play_round
    loop do
      human.choose
      computer.choose
      display_round
      break if human.score.win? || computer.score.win?
    end
    display_winner
  end

  def play
    display_welcome_message
    loop do
      play_round
      break unless play_again?
      human.score.reset
      computer.score.reset
    end
    display_goodbye_message
  end
end

RPSGame.new.play
