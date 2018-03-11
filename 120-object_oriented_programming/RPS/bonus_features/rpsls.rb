# rpsls.rb

class Move
  VALUES = %w[rock paper scissors lizard spock].freeze

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

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def <(other)
    rock_loses?(other) ||
      paper_loses?(other) ||
      scissors_loses?(other) ||
      lizard_loses?(other) ||
      spock_loses?(other)
  end

  def rock_loses?(other)
    rock? && (other.paper? || other.spock?)
  end

  def paper_loses?(other)
    paper? && (other.scissors? || other.lizard?)
  end

  def scissors_loses?(other)
    scissors? && (other.rock? || other.spock?)
  end

  def lizard_loses?(other)
    lizard? && (other.rock? || other.scissors?)
  end

  def spock_loses?(other)
    spock? && (other.paper? || other.lizard?)
  end

  def >(other)
    rock_wins?(other) ||
      paper_wins?(other) ||
      scissors_wins?(other) ||
      lizard_wins?(other) ||
      spock_wins?(other)
  end

  def rock_wins?(other)
    rock? && (other.scissors? || other.lizard?)
  end

  def paper_wins?(other)
    paper? && (other.rock? || other.spock?)
  end

  def scissors_wins?(other)
    scissors? && (other.paper? || other.lizard?)
  end

  def lizard_wins?(other)
    lizard? && (other.paper? || other.spock?)
  end

  def spock_wins?(other)
    spock? && (other.rock? || other.scissors?)
  end

  def to_s
    @value
  end
end

class Player
  SCORE_TO_WIN = 10

  attr_accessor :name, :move, :score

  def initialize
    set_name
    reset_score
  end

  def reset_score
    self.score = 0
  end

  def increment_score
    self.score += 1
  end

  def win?
    self.score >= SCORE_TO_WIN
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
      puts "\nPlease choose one: #{Move::VALUES.join(', ')} -"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie Sonny 'Number 5'].sample
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
    puts "\nWelcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "\nThanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
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
    human.increment_score
  end

  def record_computer_winner
    puts "\n#{computer.name} won!"
    computer.increment_score
  end

  def display_scores
    puts "\n_______________"
    puts "Scores:"
    puts "-------"
    puts "#{human.name} - #{human.score}"
    puts "#{computer.name} - #{computer.score}"
    puts "==============="
  end

  def display_winner
    puts "\n#{human.name} won!" if human.win?
    puts "\n#{computer.name} won!" if computer.win?
  end

  def play_again?
    answer = nil
    loop do
      puts "\nWould you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "\nSorry, must be y or n."
    end

    return true if answer.downcase == 'y'
    false
  end

  def play_round
    loop do
      human.choose
      computer.choose
      display_round
      break if human.win? || computer.win?
    end
    display_winner
  end

  def play_game
    display_welcome_message
    loop do
      play_round
      break unless play_again?
      human.reset_score
      computer.reset_score
    end
    display_goodbye_message
  end
end

RPSGame.new.play_game
