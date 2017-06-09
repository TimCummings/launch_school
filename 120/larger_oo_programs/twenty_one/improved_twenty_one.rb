# improved_twenty_one.rb

class Card
  SUITS = [:spades, :hearts, :clubs, :diamonds]
  VALUES = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

  attr_reader :value, :suit

  def initialize(value, suit = nil)
    @value = value
    @suit = suit
  end

  # take advantage of value's string length to determine points
  def points
    case value.length
    when 1..2 then value.to_i
    when 3 then 11
    else 10
    end
  end

  def to_s
    "#{value} of #{suit.capitalize}"
  end

  def ==(other)
    value == other.value
  end
end

class Deck
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        @cards << Card.new(value, suit)
      end
    end
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end
end

class Player
  DEFAULT_NAMES = %w[Human One-Eyed\ Jack CardShark Joker Lucky]

  attr_reader :name, :hand, :score

  def initialize
    @score = 0
    reset
  end

  def reset
    @hand = []
    @points = 0
  end

  def set_name
    puts 'Please enter your name.'
    puts "Otherwise, I'll have to come up with something to call you - "
    entry = gets.chomp
    @name = if entry.empty?
              DEFAULT_NAMES.sample
            else
              entry
            end
  end

  def hit(card)
    @hand << card
  end

  def points
    @points = hand.map(&:points).reduce(:+)
    check_aces if busted?
    @points
  end

  def check_aces
    hand.count(Card.new('Ace')).times do
      @points -= 10
      break unless busted?
    end
  end

  def busted?
    @points > TwentyOneGame::BUST_OVER
  end

  def to_s
    name
  end

  def joinor(array, delim = ', ', conj = 'or')
    case array.size
    when 0..1 then array.first.to_s
    when 2 then "#{array.first} #{conj} #{array.last}"
    else array[0..-2].join(delim) + "#{delim}#{conj} #{array.last}"
    end
  end

  def display_hand
    puts "  Cards: #{joinor(hand, ', ', 'and')}"
    puts "  Points: #{points}"
    puts
  end

  def increment_score
    @score += 1
  end
end

class Dealer < Player
  DEFAULT_NAMES = %w[R2D2 Hal Chappie Sonny Number\ 5]

  def set_name
    @name = DEFAULT_NAMES.sample
  end

  def display_flop
    puts "  Cards: #{hand.first} and <HIDDEN!>"
    puts
  end
end

module Printable
  def clear
    system('clear') || system('cls')
  end

  def invalid_choice
    puts 'Invalid choice, please try again.'
  end

  def display_greeting
    clear
    puts 'Welcome to Twenty One. Enjoy the game!'
    puts
  end

  def introduce_players
    puts "Grab a seat, #{human}."
    puts "#{dealer} is joining the table as the dealer."
    puts
    puts 'Please press Enter when you are ready to start the game.'
    gets
  end

  def display_hands(last_card_hidden: false)
    clear
    puts "#{human}:"
    puts '--------------------'
    human.display_hand

    puts "#{dealer}:"
    puts '--------------------'
    if last_card_hidden
      dealer.display_flop
    else
      dealer.display_hand
    end
    puts
  end

  def display_game_results
    puts
    puts 'Games won:'
    puts "#{human}: #{human.score}"
    puts "#{dealer}: #{dealer.score}"
    puts
  end

  def display_goodbye
    puts
    puts 'Thanks for playing Twenty One. Goodbye!'
  end
end

class TwentyOneGame
  include Printable

  BUST_OVER = 21
  DEALER_STAYS = 17

  attr_reader :human, :dealer, :deck

  def initialize
    @human = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def reset
    human.reset
    dealer.reset
    @deck = Deck.new
  end

  def introductions
    display_greeting
    human.set_name
    dealer.set_name
    introduce_players
  end

  def deal_initial_hands
    2.times do
      human.hit(deck.deal)
      dealer.hit(deck.deal)
    end
  end

  def hit_or_stay
    choice = ''
    loop do
      puts '(H)it or (S)tay?'
      choice = gets.chr.downcase
      break if %w[h s].include? choice
      invalid_choice
    end

    choice
  end

  def human_turn
    loop do
      break if hit_or_stay == 's'
      human.hit(deck.deal)
      display_hands(last_card_hidden: true)
      break if human.busted?
    end
  end

  def dealer_turn
    dealer.hit(deck.deal) while dealer.points < DEALER_STAYS
  end

  def display_round_results
    if human.busted? || dealer.busted?
      display_busted
    else
      compare_points
    end
  end

  def display_busted
    if human.busted?
      dealer.increment_score
      puts "#{human} busted, #{dealer} wins!"
    elsif dealer.busted?
      human.increment_score
      puts "#{dealer} busted, #{human} wins!"
    end
    puts
  end

  def compare_points
    if human.points > dealer.points
      human.increment_score
      puts 'Human wins!'
    elsif dealer.points > human.points
      dealer.increment_score
      puts 'Dealer wins!'
    else
      puts 'Push! Human and Dealer tie!'
    end
  end

  def play_again?
    puts 'Would you like to play again? (y/n)'
    entry = ''
    loop do
      entry = gets.chr.downcase
      break if %w[y n].include? entry
      invalid_choice
    end
    entry == 'y'
  end

  def play
    introductions
    loop do
      play_round
      display_game_results
      break unless play_again?
      reset
    end
    display_goodbye
  end

  def play_round
    deal_initial_hands
    display_hands(last_card_hidden: true)
    human_turn
    dealer_turn unless human.busted?
    display_hands
    display_round_results
  end
end

game = TwentyOneGame.new
game.play
