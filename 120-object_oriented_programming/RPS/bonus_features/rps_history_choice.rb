# rps_history_choice.rb

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

class Player
  SCORE_TO_WIN = 10

  attr_accessor :name, :move, :score, :round, :history

  def initialize
    set_name
    set_score
    @round = {}
    @history = []
  end

  def set_score
    self.score = 0
  end

  def increment_score
    self.score += 1
  end

  def win?
    self.score >= SCORE_TO_WIN
  end

  def tally_round(result)
    increment_score if result == :win
    round[:result] = result
    history << round
    self.round = {}
  end

  def display_history
    display_history_heading
    display_history_data
  end

  def display_history_heading
    puts "\nHistory for #{name}:"
    puts "=============================================="
    puts "Round".ljust(15) + "Move".ljust(15) + "Result"
    puts "----------------------------------------------"
  end

  def display_history_data
    history.each_with_index do |hash, idx|
      col1 = (idx + 1).to_s.ljust(15)
      col2 = (hash[:move]).to_s.ljust(15)
      col3 = (hash[:result]).to_s
      puts col1 + col2 + col3
    end
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
    round[:move] = move
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie Sonny Number\ 5].sample
  end

  def choose
    winning_rounds = history.select { |round| round[:result] == :win }
    if won_with_all_moves?(winning_rounds)
      choose_weighted(winning_rounds)
    else
      choose_unweighted
    end
  end

  # sample randomly until computer wins at least once with each move
  def won_with_all_moves?(winning_rounds)
    winning_rounds.any? { |round| round[:move].rock? } &&
      winning_rounds.any? { |round| round[:move].paper? } &&
      winning_rounds.any? { |round| round[:move].scissors? }
  end

  def choose_unweighted
    puts "\nComputer choosing unweighted - 1/3 chance of any move..."
    self.move = Move.new(Move::VALUES.sample)
    round[:move] = move
  end

  # moves that win more frequently are now more likely to be selected
  def choose_weighted(winning_rounds)
    puts "\nComputer choosing weighted - get ready to statistically lose!"
    self.move = winning_rounds.sample[:move]
    round[:move] = move
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
    puts "\nThanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_round
    display_moves
    if human.move > computer.move
      record_human_winner
    elsif human.move < computer.move
      record_computer_winner
    else
      record_tie
    end
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def record_human_winner
    puts "\n#{human.name} won!"
    human.tally_round(:win)
    computer.tally_round(:lose)
  end

  def record_computer_winner
    puts "\n#{computer.name} won!"
    computer.tally_round(:win)
    human.tally_round(:lose)
  end

  def record_tie
    puts "\nIt's a tie!"
    human.tally_round(:tie)
    computer.tally_round(:tie)
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
      human.display_history
      computer.display_history
      display_scores
      break if human.win? || computer.win?
    end
    display_winner
  end

  def play_game
    display_welcome_message
    loop do
      play_round
      break unless play_again?
      human.set_score
      computer.set_score
    end
    display_goodbye_message
  end
end

RPSGame.new.play_game

# rubocop:disable Metrics/LineLength

# Adjust computer choice based on history
# Once the computer has won at least once with each move, the computer will then use a different method for selecting moves that, instead of sampling from a simple list of all possible `Move` values, samples from a list of winning moves - moves that have won more often are more likely to be sampled.