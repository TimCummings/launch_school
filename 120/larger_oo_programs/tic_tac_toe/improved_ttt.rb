# improved_ttt.rb

require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :winning_marker

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won_round?
    detect_winning_marker
    winning_marker
  end

  # returns round winning marker or nil
  def detect_winning_marker
    WINNING_LINES.each do |line|
      target = @squares.values_at(*line)
      next if target.any?(&:unmarked?)
      if target.uniq(&:marker).size == 1
        @winning_marker = target.first.marker
      end
    end
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
    @winning_marker = nil
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize

  def immediate_threat?(threat_marker)
    !!immediate_threat_defense(threat_marker)
  end

  # returns key of square to defend immediate threat, or nil
  def immediate_threat_defense(threat_marker)
    WINNING_LINES.each do |line|
      target = @squares.values_at(*line)
      next unless target.any?(&:unmarked?)
      if target.map(&:marker).count(threat_marker) == 2
        return line.find { |key| @squares[key].unmarked? }
      end
    end
    nil
  end

  def middle_unmarked?
    @squares[5].unmarked?
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :name, :marker, :score

  def initialize
    @score = 0
  end

  def increment_score
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

class Human < Player
  def set_name
    puts 'What is your name?'
    puts "I can accept a name up to #{TTTGame::MAX_NAME_LENGTH} characters."
    puts 'If no name is provided, you\'ll be assigned a default name.'
    puts 'Please enter your name now...'
    name = gets.chomp.slice(0..TTTGame::MAX_NAME_LENGTH)
    puts
    @name = if name.empty?
              TTTGame::DEFAULT_HUMAN_NAME
            else
              name
            end
  end

  def set_marker
    puts 'What marker would you like to use?'
    puts 'Markers can only be a single character.'
    puts 'If no marker is provided, you\'ll be assigned a default marker.'
    puts 'Please enter your marker now...'
    marker = gets.chomp.chr
    puts
    @marker = if marker.empty?
                TTTGame::DEFAULT_HUMAN_MARKER
              else
                marker
              end
  end
end

class Computer < Player
  def set_name
    @name = %w[R2D2 Hal Chappie Sonny Number\ 5].sample
  end

  # rubocop:disable Style/AccessorMethodName
  def set_marker(taken_marker)
    @marker = %w[X O # $ % & * ~].reject { |mk| mk == taken_marker }.sample
  end
  # rubocop:enable Style/AccessorMethodName
end

class TTTGame
  private

  MAX_NAME_LENGTH = 16
  DEFAULT_HUMAN_NAME = 'Human'
  DEFAULT_HUMAN_MARKER = 'X'
  DEFAULT_COMPUTER_MARKER = 'O'

  attr_reader :score_to_win, :board, :human, :computer

  def initialize
    @score_to_win = 5
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def setup_game
    human.set_name
    human.set_marker
    computer.set_name
    computer.set_marker(human.marker)
    @first_to_move = human.marker
    @current_marker = @first_to_move
    clear
  end

  def display_welcome_message
    clear
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts "\nThanks for playing Tic Tac Toe!"
    puts
  end

  def display_board
    display_score
    board.draw
    puts ''
  end

  # rubocop:disable Metrics/LineLength
  def display_score
    puts '      Player      | Marker | Score'
    puts '------------------|--------|-------'
    puts human_player_info
    puts computer_player_info
    puts
  end

  def human_player_info
    "#{human.name.center(18)}|#{human.marker.center(8)}|   #{human.score}"
  end

  def computer_player_info
    "#{computer.name.center(18)}|#{computer.marker.center(8)}|   #{computer.score}"
  end
  # rubocop:enable Metrics/LineLength

  def clear_screen_and_display_board
    clear
    display_board
  end

  def joinor(array, delim = ', ', conj = 'or')
    case array.size
    when 0..1 then array.first.to_s
    when 2 then "#{array.first} #{conj} #{array.last}"
    else array[0..-2].join(delim) + "#{delim}#{conj} #{array.last}"
    end
  end

  def human_moves
    puts "Choose a square: #{joinor(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.immediate_threat?(computer.marker)
      computer_offensive_move
    elsif board.immediate_threat?(human.marker)
      computer_defensive_move
    elsif board.middle_unmarked?
      computer_strategic_move
    else
      computer_random_move
    end
  end

  def computer_offensive_move
    board[board.immediate_threat_defense(computer.marker)] = computer.marker
  end

  def computer_defensive_move
    board[board.immediate_threat_defense(human.marker)] = computer.marker
  end

  def computer_strategic_move
    board[5] = computer.marker
  end

  def computer_random_move
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_round_result
    message = ''
    case board.winning_marker
    when human.marker
      human.increment_score
      message = 'You won this round!'
    when computer.marker
      computer.increment_score
      message = 'Computer won this round!'
    else
      message = "This round is a tie!"
    end

    clear_screen_and_display_board
    puts "\n#{message}"
    puts "\nPress [Enter] to continue..."
    gets
  end

  def display_game_result
    clear_screen_and_display_board

    if detect_game_winner == human.marker
      puts 'You won the game!'
    else
      puts 'Computer won the game!'
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again?'
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts "Sorry, must be 'y' or 'n'."
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset_round
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def reset_game
    reset_round
    human.reset_score
    computer.reset_score
  end

  def display_play_again_message
    puts "\nLet's play again!"
    puts
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def someone_won_game?
    !!detect_game_winner
  end

  # returns game winning marker or nil
  def detect_game_winner
    if human.score >= score_to_win
      human.marker
    elsif computer.score >= score_to_win
      computer.marker
    end
  end

  def play_round
    display_board

    loop do
      current_player_moves
      break if board.someone_won_round? || board.full?
      clear_screen_and_display_board if human_turn?
    end
    display_round_result
  end

  public

  def play
    display_welcome_message
    setup_game

    loop do
      loop do
        play_round
        break if someone_won_game?
        reset_round
      end

      display_game_result
      break unless play_again?
      reset_game
      display_play_again_message
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play

# rubocop:disable Metrics/LineLength
# Question 7: If we are keeping the `Board#get_square_at` method, then it is the appropriate way to get squares in `Board#draw`. However, by moving the responsibility of displaying the board into the `Board` class, we have eliminated our need for `Board#get_square_at`; we could remove it and access `@squares` directly (unless we anticipate a future need for the current interface.)
