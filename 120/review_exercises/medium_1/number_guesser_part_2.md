
[comment]: # (number_guesser_part_2.md)

### Number Guesser Part 2 - 5/31/2017

#### In the previous exercise, you wrote a number guessing game that determines a secret number between 1 and 100, and gives the user 7 opportunities to guess the number.

#### Update your solution to accept a low and high value when you create a GuessingGame object, and use those values to compute a secret number for the game. You should also change the number of guesses allowed so the user can always win if she uses a good strategy. You can compute the number of guesses with:

``` ruby
Math.log2(size_of_range).to_i + 1
```

#### Examples:

``` ruby
game = GuessingGame.new(501, 1500)
game.play

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
You win!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low

You are out of guesses. You lose.
```

#### Note that a game object should start a new game with a new number to guess with each call to `#play`.

---

### Solution:

``` ruby
class GuessingGame
  def initialize(min = 1, max = 100)
    @range = min..max
    @max_guesses = Math.log2(@range.size).to_i + 1
    reset
  end

  def play
    play_round while @guesses > 0
    display_game_result
    reset
  end

  private

  def reset
    @the_number = rand(@range)
    @guesses = @max_guesses
    @guess = ''
  end

  def play_round
    display_round
    player_guesses
    evaluate_guess
  end

  def display_round
    puts "You have #{@guesses} guesses remaining."
    puts "Enter a number between #{@range.min} and #{@range.max}: "
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
      entry = gets.chomp.to_i
      break if @range.include?(entry)
      puts "Invalid entry. Enter a number between #{@range.min} and #{@range.max}:"
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
end
```
