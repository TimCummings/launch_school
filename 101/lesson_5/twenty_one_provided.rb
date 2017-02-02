# twenty_one_provided.rb

# rubocop:disable Metrics/LineLength
# This file uses the provided possible solution to practice implementing the bonus features.

# Bonus Questions

# 1) When using a local variable to cache an expensive calculation, we must make sure to re-calculate the local variable as needed to make sure the calculation remains accurate.

# 2) The last call of play_again? occurs at the end of the game's main do loop and does not need to use a tertiary conditional to branch to the next iteration of the loop (since it is the very last line of code in the loop)

# rubocop:enable Metrics/LineLength

SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q',
          'K', 'A'].freeze
LIMIT = 21
DEALER_STAYS = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i.zero? # J, Q, K
             10
           else
             value.to_i
           end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > LIMIT
  end

  sum
end

def busted?(score)
  score > LIMIT
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_total, player_total)
  if player_total > LIMIT
    :player_busted
  elsif dealer_total > LIMIT
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

# rubocop:disable Metrics/MethodLength
def display_result(dealer_cards, player_cards, dealer_total, player_total)
  result = detect_result(dealer_total, player_total)

  puts "=============="
  prompt "Dealer has #{dealer_cards}, for a total of: #{dealer_total}"
  prompt "Player has #{player_cards}, for a total of: #{player_total}"
  puts "=============="

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end
# rubocop:enable Metrics/MethodLength

def display_scores(dealer_score, player_score)
  puts "=============="
  prompt "Dealer score: #{dealer_score}"
  prompt "Player score: #{player_score}"
  puts "=============="
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

loop do
  prompt "Welcome to Twenty-One!"
  dealer_score = 0
  player_score = 0

  loop do
    break if dealer_score >= 5 || player_score >= 5

    # initialize vars
    deck = initialize_deck
    player_cards = []
    dealer_cards = []
    player_total = 0
    dealer_total = 0

    # initial deal
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    player_total = total(player_cards)
    dealer_total = total(dealer_cards)
    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have: #{player_cards[0]} and #{player_cards[1]},
      for a total of #{player_total}."

    # player turn
    loop do
      player_turn = nil
      loop do
        prompt "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        player_total = total(player_cards)
        prompt "You chose to hit!"
        prompt "Your cards are now: #{player_cards}"
        prompt "Your total is now: #{player_total}"
      end

      break if player_turn == 's' || busted?(player_total)
    end

    if busted?(player_total)
      dealer_score += 1
      display_result(dealer_cards, player_cards, dealer_total, player_total)
      display_scores(dealer_score, player_score)
      next
    else
      prompt "You stayed at #{player_total}"
    end

    # dealer turn
    prompt "Dealer turn..."

    loop do
      break if busted?(dealer_total) || dealer_total >= DEALER_STAYS

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      dealer_total = total(dealer_cards)
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    if busted?(dealer_total)
      player_score += 1
      prompt "Dealer total is now: #{dealer_total}"
      display_result(dealer_cards, player_cards, dealer_total, player_total)
      display_scores(dealer_score, player_score)
      next
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    winner = detect_result(dealer_total, player_total)
    if winner == :player
      player_score += 1
    elsif winner == :dealer
      dealer_score += 1
    end

    display_result(dealer_cards, player_cards, dealer_total, player_total)
    display_scores(dealer_score, player_score)
  end

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"
