# tictactoe.rb

require 'pry'

# Constants
OPEN_SQUARE = ' '
PLAYER_SQUARE = 'X'
COMPUTER_SQUARE = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # Rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # Columns
                [[1, 5, 9], [3, 5, 7]]              # Diagonals

# Methods
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = OPEN_SQUARE }
  new_board
end

def update_board!(board, square, user)
  board[square] = user
  board
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You are: #{PLAYER_SQUARE}"
  puts "Computer is: #{COMPUTER_SQUARE}"
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
  puts "     |     |\n"
end
# rubocop:enable Metrics/AbcSize

def open_squares(board)
  board.keys.select { |key| board[key] == OPEN_SQUARE }
end

def players_turn(board)
  loop do
    puts "Pick a square: #{joinor(open_squares(board))}"
    choice = gets.chomp.to_i
    if open_squares(board).include?(choice)
      return board = update_board!(board, choice, PLAYER_SQUARE)
    else
      puts "That is not a valid choice."
    end
  end
end

def computers_turn(board)
  update_board!(board, open_squares(board).sample, COMPUTER_SQUARE)
end

def tie?(board)
  open_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board[line[0]] == PLAYER_SQUARE &&
       board[line[1]] == PLAYER_SQUARE &&
       board[line[2]] == PLAYER_SQUARE
      return 'Player'
    elsif board[line[0]] == COMPUTER_SQUARE &&
          board[line[1]] == COMPUTER_SQUARE &&
          board[line[2]] == COMPUTER_SQUARE
      return 'Computer'
    end
  end
  nil
end

def joinor(array, delim=', ', conjunction='or')
  return array.first.to_s if array.size < 2
  array_copy = array
  conjunction += ' ' + array_copy.pop.to_s

  if array_copy.size == 1
    array_copy.first.to_s + conjunction
  else
    array_copy.join(delim) + delim + conjunction
  end
end

# Main
loop do
  board = initialize_board

  joinor(open_squares(board))

  loop do
    display_board(board)

    board = players_turn(board)
    break if someone_won?(board) || tie?(board)

    board = computers_turn(board)
    break if someone_won?(board) || tie?(board)
  end

  display_board(board)

  if someone_won?(board)
    puts "#{detect_winner(board)} wins!"
  else
    puts "This game is a tie!"
  end

  puts "Would you like to play again? (Y or N)"
  repeat_game_loop = gets.chomp
  break unless repeat_game_loop.downcase.start_with?('y')
end

puts "\nThanks for playing Tic Tac Toe! Goodbye!"
