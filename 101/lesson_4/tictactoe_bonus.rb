# tictactoe.rb

require 'pry'

# Constants
OPEN_SQUARE = ' '.freeze
PLAYER_SQUARE = 'X'.freeze
COMPUTER_SQUARE = 'O'.freeze
FIRST_PLAYER = 'choose'.freeze
PLAYERS = ['computer', 'player']
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # Rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # Columns
                [[1, 5, 9], [3, 5, 7]]              # Diagonals

# Methods
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = OPEN_SQUARE }
  new_board
end

def initialize_scores
  { "Player" => 0, "Computer" => 0 }
end

def pick_first_player
  loop do
    puts "Who would you like to go first - player or computer?"
    choice = gets.chomp
    if PLAYERS.include?(choice)
      return choice
    else
      puts "That is not a valid choice."
    end
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You are: #{PLAYER_SQUARE}"
  puts "Computer is: #{COMPUTER_SQUARE}"
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def display_scores(scores)
  puts "\nScore -"
  puts "  Player: #{scores['Player']}"
  puts "  Computer: #{scores['Computer']}"
end

def open_squares(board)
  board.keys.select { |key| board[key] == OPEN_SQUARE }
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  else
    'player'
  end
end

def place_piece!(board, current_player)
  if current_player == 'player'
    players_turn!(board)
  else
    computers_turn!(board)
  end
end

def players_turn!(board)
  loop do
    puts "Pick a square: #{joinor(open_squares(board))}"
    choice = gets.chomp.to_i
    if open_squares(board).include?(choice)
      return board[choice] = PLAYER_SQUARE
    else
      puts "That is not a valid choice."
    end
  end
end

def computers_turn!(board)
  # Win if possible
  if at_risk_square?(board, COMPUTER_SQUARE)
    board[find_at_risk_square(board, COMPUTER_SQUARE)] = COMPUTER_SQUARE
  # Prevent losing if necessary
  elsif at_risk_square?(board, PLAYER_SQUARE)
    board[find_at_risk_square(board, PLAYER_SQUARE)] = COMPUTER_SQUARE
  # Pick square 5 if available
  elsif open_squares(board).include?(5)
    board[5] = COMPUTER_SQUARE
  # Pick a random square
  else
    board[open_squares(board).sample] = COMPUTER_SQUARE
  end
end

def tie?(board)
  open_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_SQUARE) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_SQUARE) == 3
      return 'Computer'
    end
  end
  nil
end

def at_risk_square?(board, marker)
  !!find_at_risk_square(board, marker)
end

def find_at_risk_square(board, marker)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(marker) == 2 &&
      board.values_at(*line).include?(OPEN_SQUARE)
      line.each do |key|
        return key if board[key] == OPEN_SQUARE
      end
    end
  end
  nil
end

def joinor(array, delim=', ', conjunction='or')
  return array.first.to_s if array.size < 2
  array_copy = array.clone
  conjunction += ' ' + array_copy.pop.to_s

  if array_copy.size == 1
    array_copy.first.to_s + ' ' + conjunction
  else
    array_copy.join(delim) + delim + conjunction
  end
end

# Main
loop do
  scores = initialize_scores

  if FIRST_PLAYER == 'choose'
    current_player = pick_first_player
  else
    current_player = FIRST_PLAYER
  end

  loop do
    board = initialize_board

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || tie?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      scores[winner] += 1
      puts "#{winner} wins!"
    else
      puts "This game is a tie!"
    end

    display_scores(scores)
    break if scores.value?(5)
    puts "\nPress enter to continue."
    gets
  end

  puts "Would you like to play again? (Y or N)"
  repeat_game_loop = gets.chomp
  break unless repeat_game_loop.downcase.start_with?('y')
end

puts "\nThanks for playing Tic Tac Toe! Goodbye!"
