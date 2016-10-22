# rock_paper_scisoors.rb

VALID_CHOICES = %w(rock paper scissors lizard Spock)
POINTS_TO_WIN = 5

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_game_status(round, player_score, computer_score)
  prompt("===== Round #{round} =====")
  prompt("Score:")
  prompt(" - Player: #{player_score}")
  prompt(" - Computer: #{computer_score}")
end

def valid_choice?(user_input)
  if user_input.length == 1
    VALID_CHOICES.each do |word|
      return true if word.start_with?(user_input)
    end
    return false
  else
    VALID_CHOICES.include?(user_input)
  end
end

def translate_choice(user_input)
  VALID_CHOICES.each do |word|
    return word if word.start_with?(user_input)
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

def display_results(player, computer)
  if win?(player, computer)
    "You won this round!"
  elsif win?(computer, player)
    "Computer won this round!"
  else
    "This round is a tie!"
  end
end

# my attempt to reduce method complexity:
# simplest case is a tie - check for that first
# def display_results(player, computer)
#   if player == computer
#     "it's a tie!"
#   elsif (player == 'rock'     && computer == 'scissors') ||
#         (player == 'paper'    && computer == 'rock')     ||
#         (player == 'scissors' && computer == 'paper')
#     "You won!"
#   else
#     "Computer won!"
#   end
# end

prompt("Welcome to #{VALID_CHOICES.join(', ')}!")
prompt("The first player to #{POINTS_TO_WIN} points wins.")

round = 1
player_score = 0
computer_score = 0

while player_score < POINTS_TO_WIN && computer_score < POINTS_TO_WIN do
  display_game_status(round, player_score, computer_score)

  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("You may type just the first letter (Spock is case-sensitive!)")
    choice = Kernel.gets().chomp()

    if valid_choice?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  choice = translate_choice(choice) if choice.length == 1

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

  prompt(display_results(choice, computer_choice))

end

display_game_status()

if player_score == 5
  prompt("Player won the game!")
else
  prompt("Computer won the game!")
end
