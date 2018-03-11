# Rock, Paper, Scissors - Preparations

## 1. Textual Description
Rock, Paper, Scissors is a two-player game where, after a countdown, both players will simultaneously select a "move", using a specific hand gesture, from a pre-determined set (usually just rock, paper, or scissors). Each "move" has a different "move" that it beats and another "move" that beats it. The winner is determined by seeing which moves the two players have chosen and comparing them to the following interactions:

* rock beats scissors
* paper beats rock
* scissors beats paper
* if the moves are the same, the players tie


## 2. Extract Major Nouns & Verbs

* Nouns
  + player
  + move
  + result


* Verbs
  + select/choose
  + beats
  + beaten by
  + tie
  + determine winner


## 3. Organize & Associate Verbs with Nouns

* player
  + select/choose


* move
  + beats
  + beaten by
  + tie


* result
  + determine winner
  + tie


## 4. Classes & Methods
```ruby
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    # display greeting
    human.select_move
    computer.select_move
    # determine winner
    # display end message
  end
end

class Player
  def initialize
  end

  def select_move
  end
end

class Move
  def initialize
  end

  def beats
  end

  def beaten_by
  end

  def tie
  end
end

class Result
  def initialize
  end

  def determine_winner
  end

  def tie
  end
end
```



# Lesson Questions


## OO RPS Design Choice 1

#### Is this design, with Human and Computer sub-classes, better? Why, or why not?
I believe this is a better design for two reasons: first, this design flows quite naturally from what our code is trying to represent; it is a good fit to have `Human` and `Computer` as two separate subclasses that inherit from `Player`, with the same methods but slightly different implementations of those methods. Second, this design removes the need for a jumble of conditional logic in the middle of each of our `Player` methods, creating the same discinction (`Human` vs `Computer`) much more intuitively with subclasses.

#### What is the primary improvement of this new design?
By removing unnecessary conditional logic from multiple methods, this code is much easier to read and should be easier to maintain and extend in the future.

#### What is the primary drawback of this new design?
We have doubled our total number of classes. This program is tiny so there will be no impact in this case, but in larger programs, unnecessarily creating additional classes could lead to overhead that may start to affect performance and also increases the chance of namespace collision.


## OO RPS Design Choice 2

#### What is the primary improvement of this new design?
Similarly to the previous refactoring, this new design's primary improvement is that it has eliminated some messy nested conditional logic with another class provides the same functionality in a simpler, more encapsulated fashion.

#### What is the primary drawback of this new design?
The drawback of this design is that we have yet another class with its associated overhead, and our program is now not very accessible in a procedural sense - we have moved away from using core data structures to custom classes.
