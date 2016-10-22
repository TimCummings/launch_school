# twenty_one.rb

require 'pry'

# Constants
SUITES = ['Spades', 'Hearts', 'Clubs', 'Diamonds'].freeze
FACES = ['Jack', 'Queen', 'King'].freeze
BASIC_MOVES = ['hit', 'stay'].freeze
LIMIT = 21
DEALER_STAYS = 17

# Methods
def joinor(array, delim=', ', conjunction='or')
  return array.first.to_s if array.size < 2
  array_copy = array.dup
  conjunction += ' ' + array_copy.pop.to_s

  if array_copy.size == 1
    array_copy.first.to_s + ' ' + conjunction
  else
    array_copy.join(delim) + delim + conjunction
  end
end

def initialize_deck
  new_deck = []
  SUITES.each do |suite|
    (2..10).each do |num|
      new_deck.push("name" => num, "suite" => suite, "value" => num)
    end
    FACES.each do |face|
      new_deck.push("name" => face, "suite" => suite, "value" => 10)
    end
    new_deck.push("name" => 'Ace', "suite" => suite, "value" => 11)
  end
  new_deck.shuffle
end

def deal!(deck, hand)
  hand.push(deck.pop)
end

def display_hand(hand, owner, hide_cards=false)
  if hide_cards
    puts "#{owner} has: #{hand.first['name']} and unknown card"
  else
    cards = []
    hand.each { |card| cards.push(card['name']) }
    puts "#{owner} has: #{joinor(cards, ', ', 'and')}"
    puts "#{owner} score: #{score_hand(hand)}"
  end
end

def score_hand(hand)
  values = []
  hand.each { |card| values.push(card['value']) }
  score = values.inject(0) { |sum, value| sum + value }

  if score > LIMIT && values.include?(11)
    process_aces(hand, values)
    return score_hand(hand)
  else
    score
  end
end

def process_aces(hand, values)
  ace = values.index(11)
  values[ace] = 1
  hand[ace]['value'] = 1
end

def bust?(hand)
  score_hand(hand) > LIMIT
end

def player_turn!(deck, hand)
  loop do
    move = input_move
    deal!(deck, hand) if move == 'hit'
    break if move == 'stay' || bust?(hand)
    display_hand(hand, 'Player')
  end
end

def dealer_turn!(deck, hand)
  loop do
    deal!(deck, hand) if score_hand(hand) < DEALER_STAYS
    break if score_hand(hand) >= DEALER_STAYS || bust?(hand)
    display_hand(hand, 'Dealer')
  end
end

def input_move
  loop do
    puts "Your move: #{joinor(BASIC_MOVES)}?"
    move = gets.chomp

    if BASIC_MOVES.include?(move)
      return move
    else
      puts "That is not a valid choice."
    end
  end
end

def determine_winner(dealer_hand, player_hand)
  if score_hand(dealer_hand) > score_hand(player_hand)
    'Dealer'
  elsif score_hand(dealer_hand) < score_hand(player_hand)
    'Player'
  else
    'Push!'
  end
end

def display_winner(winner)
  if winner == 'Push!'
    puts winner
  else
    puts "#{winner} wins!"
  end
end

# Main
puts "Welcome to Twenty-One!"

loop do
  loop do
    deck = initialize_deck
    player_hand = []
    dealer_hand = []

    2.times do
      deal!(deck, player_hand)
      deal!(deck, dealer_hand)
    end

    display_hand(dealer_hand, 'Dealer', true)
    display_hand(player_hand, 'Player')

    player_turn!(deck, player_hand)
    if bust?(player_hand)
      display_hand(player_hand, 'Player')
      puts "You busted! Dealer wins!"
      break
    end

    dealer_turn!(deck, dealer_hand)
    if bust?(dealer_hand)
      display_hand(dealer_hand, 'Dealer')
      puts "Dealer busted! You win!"
      break
    end

    display_hand(dealer_hand, 'Dealer')
    display_hand(player_hand, 'Player')
    display_winner(determine_winner(dealer_hand, player_hand))
    break
  end

  puts "Would you like to play again? (Y or N)"
  repeat_game_loop = gets.chomp
  break unless repeat_game_loop.downcase.start_with?('y')
end

puts "Thanks for playing Twenty-One!"
