
[comment]: # (number_guesser_part_1.md)

### Number Guesser Part 1 - 5/31/2017

#### Create an object-oriented number guessing class for numbers in the range 1 to 100, with a limit of 7 guesses per game. The game should play like this:

``` ruby
game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
You win!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low
You are out of guesses. You lose.
```

#### Note that a game object should start a new game with a new number to guess with each call to `#play`.

---

### Solution:

``` ruby
class GuessingGame
  GUESSES_PER_GAME = 7
  MAX = 100
  MIN = 1

  def play
    reset
    play_round while @guesses > 0
    display_game_result
  end

  private

  def reset
    @the_number = (MIN..MAX).to_a.sample
    @guesses = GUESSES_PER_GAME
    @guess = ''
  end

  def play_round
    display_round
    player_guesses
    evaluate_guess
  end

  def display_round
    puts "You have #{@guesses} guesses remaining."
    puts "Enter a number between #{MIN} and #{MAX}: "
  end

  def display_round_result
    puts 'Your guess is too low.' if @guess < @the_number
    puts 'Your guess is too high.'if @guess > @the_number
  end

  def display_game_result
    if player_won?
      puts 'You win!'
    else
      puts 'You are out of guesses. You lose.'
    end
  end

  def player_guesses
    entry = ''
    loop do
      entry = gets.chomp
      break if valid?(entry)
      puts "Invalid entry. Enter a number between #{MIN} and #{MAX}:"
    end

    @guess = entry.to_i
    @guesses -= 1
  end

  def evaluate_guess
    if player_won?
      @guesses = 0
    else
      display_round_result
    end
  end

  def player_won?
    @guess == @the_number
  end

  def valid?(entry)
    number?(entry) && in_range?(entry)
  end

  def number?(entry)
    entry.to_i.to_s == entry
  end

  def in_range?(entry)
    (MIN..MAX).include?(entry.to_i)
  end
end
```

---

### Further Exploration

#### We took a straightforward approach here and implemented a single class. Do you think it's a good idea to have a Player class? What methods and data should be part of it? How many Player objects do you need? Should you use inheritance, a mix-in module, or a collaborative object?

This game is so simple that a Player class is not necessary.
