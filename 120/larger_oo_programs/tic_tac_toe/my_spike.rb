# my_spike.rb

class Player
  def initialize
    # ask for and store the player's name
    # track a unique marker
  end

  def mark_spot
    # select an available spot to place player's marker
  end
end

class Grid
  def initialize
    # a 3x3 grid could be easily expressed as an array of arrays, but
    # setup and display methods need to stay lean and modular to accomodate
    # larger boards in the future
    # Grid of collaborator object? Spots?
  end

  def set_board
    # set by row for further modularity?
  end

  def display
    # display by row for further modularity?
  end
end

# Game Orchestration Engine
class TTTGame
  def play
    board = Grid.new
    human = Player.new
    computer = Player.new

    display_greeting
    loop do
      display_board
      human.mark_spot
      # check for winner or full board
      computer.mark_spot
      # check for winner or full board
    end
    # computer result
    display_result
  end
end

game = TTTGame.new
game.play
