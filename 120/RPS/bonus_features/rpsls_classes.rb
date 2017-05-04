# rpsls_classes.rb

class Move
  VALUES = %w[rock paper scissors lizard spock].freeze

  def to_s
    self.class.to_s
  end
end

class Rock < Move
  def <(other)
    (other.is_a? Paper) || (other.is_a? Spock)
  end

  def >(other)
    (other.is_a? Scissors) || (other.is_a? Lizard)
  end
end

class Paper < Move
  def <(other)
    (other.is_a? Scissors) || (other.is_a? Lizard)
  end

  def >(other)
    (other.is_a? Rock) || (other.is_a? Spock)
  end
end

class Scissors < Move
  def <(other)
    (other.is_a? Rock) || (other.is_a? Spock)
  end

  def >(other)
    (other.is_a? Paper) || (other.is_a? Lizard)
  end
end

class Lizard < Move
  def <(other)
    (other.is_a? Rock) || (other.is_a? Scissors)
  end

  def >(other)
    (other.is_a? Paper) || (other.is_a? Spock)
  end
end

class Spock < Move
  def <(other)
    (other.is_a? Paper) || (other.is_a? Lizard)
  end

  def >(other)
    (other.is_a? Rock) || (other.is_a? Scissors)
  end
end

class Player
  SCORE_TO_WIN = 10

  attr_accessor :name, :move, :score

  def initialize
    set_name
    reset_score
  end

  def move_selector(value)
    case value
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
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
    self.move = move_selector(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie Sonny Number\ 5].sample
  end

  def choose
    self.move = move_selector(Move::VALUES.sample)
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

# rubocop:disable Metrics/LineLength

# How would the code change?
# There are more classes and I had to add a `move_selector` method to the `Player` class, but the comparison logic has now been distributed to the new classes and greatly simplified.

# Can you make it work?
# I was able to make this work, but not quite like I had initially wanted to.
# I had hoped to be able to make some kind of factory method in the `Move` class to allow a call to `Move.new` to return the appropriate sub-class; I was not able to get this specific implementation to work, but it also was not necessarily the wisest plan (having one class's constructor returning an object of a different class could be confusing for others or even myself in the future, and Ruby seems to be programmed in a way that a superclass does not have much knowledge about its subclasses).
# Instead, I moved the class selection logic to the `Player` class, which leaves the `Move` class almost empty, but achieved the desired result.

# Can you talk about whether this was a good design decision? What are the pros/cons?
# I think this is a solidly mediocre decision: the pros and cons are pretty even.
# The biggest pro to this decision is that the comparison logic (e.g. whether a `Rock` is "greater than" a `Paper`) is distributed to the new classes which allows it to be greatly simplified. Instead of a five line logic statement full of nested `and`/`or`'s, each comparison method now has a single, one-line `or` statement.
# One con is that the process of initializing the appropriate move class (e.g. `Rock`, `Paper`, etc.) is a bit messy. Previously, the player made his/her/its decision and the `Move` class handled everything else; this functionality was well encapsulated. But now there is a new intermediate selector method in the `Player` class, which feels sloppy and redundant.
# Another con is that the additional classes are too fine-grained, and the `Move` class is now almost empty. The single `Move` class in the previous implementation was not overly complicated or overburdened with unnecessary features; it had a single instance variable for use with comparisons, which is about as simple as it can get. There was not really any *need* to drill down the class hierarchy any further (aside from the comparison logic.)
# For this specific program, I would not use the additional classes and instead keep the single `Move` class. If the subject of this program were less ubiquitous and/or more complicated (than Rock, Paper, Scissors, Lizard, Spock), then the benefit of the simplified comparison logic might be valuable enough to warrant the change.
