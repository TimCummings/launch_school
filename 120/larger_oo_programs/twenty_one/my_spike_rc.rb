# my_spike_rc.rb

class Card
  SUITS = [:spades, :hearts, :clubs, :diamonds]
  VALUES = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

  attr_reader :value, :suit

  def initialize(value, suit = nil)
    @value = value
    @suit = suit
  end

  def score
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
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def hit(card)
    @hand << card
  end

  def score
    hand_score = hand.map(&:score).reduce(:+)
    if hand_score > TwentyOneGame::BUST_OVER && hand.include?(Card.new('Ace'))
      hand.count(Card.new('Ace')).times do
        hand_score -= 10
        break unless hand_score > TwentyOneGame::BUST_OVER
      end
    end
    hand_score
  end

  def busted?
    score > TwentyOneGame::BUST_OVER
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

  def display_flop
    puts "  Cards: #{hand.first} and <HIDDEN!>"
    puts
  end

  def display_hand
    puts "  Cards: #{joinor(hand, ', ', 'and')}"
    puts "  Score: #{score}"
    puts
  end
end

class TwentyOneGame
  BUST_OVER = 21
  DEALER_STAYS = 17

  attr_reader :human, :dealer, :deck

  def initialize
    @human = Player.new('Human')
    @dealer = Player.new('Dealer')
    @deck = Deck.new
  end

  def clear
    system 'clear'
  end

  def display_greeting
    clear
    puts 'Welcome to Twenty One. Enjoy the game!'
    puts
  end

  def display_hands(last_card_hidden = false)
    clear
    puts 'Human:'
    puts '--------------------'
    human.display_hand

    puts 'Dealer:'
    puts '--------------------'
    if last_card_hidden
      dealer.display_flop
    else
      dealer.display_hand
    end
    puts
  end

  def deal_initial_hands
    2.times do |_|
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
      puts 'Invalid choice, please try again.'
    end

    choice
  end

  def human_turn
    loop do
      break if hit_or_stay == 's'
      human.hit(deck.deal)
      display_hands(true)
      break if human.busted?
    end
  end

  def dealer_turn
    while dealer.score < DEALER_STAYS
      dealer.hit(deck.deal)
    end
  end

  def display_results
    if human.busted? || dealer.busted?
      display_busted
    else
      compare_scores
    end
  end

  def display_busted
    if human.busted?
      puts 'Human busted, Dealer wins!'
    elsif dealer.busted?
      puts 'Dealer busted, Human wins!'
    end
    puts
  end

  def compare_scores
    if human.score > dealer.score
      puts 'Human wins!'
    elsif dealer.score > human.score
      puts 'Dealer wins!'
    else
      puts 'Push! Human and Dealer tie!'
    end
    puts
  end

  def play
    display_greeting
    deal_initial_hands
    display_hands(true)
    human_turn
    dealer_turn unless human.busted?
    display_hands
    display_results
  end
end

game = TwentyOneGame.new
game.play
