# rock_paper_scissors2.rb

# Constants
VALID_CHOICES = %w(rock paper scissors lizard Spock)
POINTS_TO_WIN = 5

# Methods
def prompt(message)
  Kernel.puts("=> #{message}")
end

def update_round(round)
  round + 1
end

def display_round(round, player_score, computer_score, tie_score)
  prompt("===== Round #{round} =====")
  prompt("Score:")
  prompt(" - Player: #{player_score}")
  prompt(" - Computer: #{computer_score}")
  prompt(" - Ties: #{tie_score}")
end

def player_turn
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("You may type just the first letter (Spock is case-sensitive!)")
    choice = Kernel.gets().chomp()

    if valid_choice?(choice)
      return choice
    else
      prompt("That's not a valid choice.")
    end
  end
end

def valid_choice?(user_input)
  if user_input.length == 1
    VALID_CHOICES.each do |word|
      return true if word.start_with?(user_input)
    end
    return false
  elsif user_input.length > 1
    VALID_CHOICES.include?(user_input)
  else
    return false
  end
end

def translate_choice(user_input)
  return user_input if user_input.length > 1
  VALID_CHOICES.each do |word|
    return word if word.start_with?(user_input)
  end
end

def compute_round_winner(player_choice, computer_choice)
  if player_choice == computer_choice
    "tie"
  elsif win?(player_choice, computer_choice)
    "player"
  else
    "computer"
  end
end

def win?(first, second)
  (first == 'scissors' && second == 'paper') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'Spock') ||
    (first == 'Spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'Spock') ||
    (first == 'Spock' && second == 'rock') ||
    (first == 'rock' && second == 'scissors')
end

def display_game_results(round, player_score, computer_score, tie_score)
  prompt("========================================")
  prompt("  Game Results")
  prompt("========================================")
  prompt(" - Rounds: #{round}")
  prompt(" - Ties: #{tie_score}")
  prompt(" - Player: #{player_score}")
  prompt(" - Computer: #{computer_score}")

  if player_score - computer_score > 0
    prompt("Player wins!")
  else
    prompt("Computer wins!")
  end
end

# Main

# initializations
round = 0
player_score = 0
computer_score = 0
tie_score = 0

# greeting
prompt("Welcome to #{VALID_CHOICES.join(', ')}!")
prompt("The first player to #{POINTS_TO_WIN} points wins.")

# game loop
while player_score < POINTS_TO_WIN && computer_score < POINTS_TO_WIN
  round = update_round(round)

  player_choice = player_turn
  player_choice = translate_choice(player_choice)

  computer_choice = VALID_CHOICES.sample

  round_winner = compute_round_winner(player_choice, computer_choice)

  # update stats
  if round_winner == 'player'
    player_score += 1
  elsif round_winner == 'computer'
    computer_score += 1
  else
    tie_score += 1
  end

  prompt("You chose: #{player_choice}; Computer chose: #{computer_choice}")
  prompt("Round winner: #{round_winner}")

  display_round(round, player_score, computer_score, tie_score)
  prompt("\n")
end

display_game_results(round, player_score, computer_score, tie_score)
