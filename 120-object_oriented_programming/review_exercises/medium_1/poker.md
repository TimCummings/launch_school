
[comment]: # (poker.md)

### Poker! - 6/3/2017

#### In the previous two exercises, you developed a Card class and a Deck class. You are now going to use those classes to create and evaluate poker hands. Create a class, PokerHand, that takes 5 cards from a Deck of Cards and evaluates those cards as a Poker hand.

#### You should build your class using the following code skeleton:

``` ruby
# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
  end

  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?

  end

  def straight_flush?
  end

  def four_of_a_kind?
  end

  def full_house?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def pair?
  end
end
```

#### Testing your class:

``` ruby
hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
```

#### Output:

```
5 of Clubs
7 of Diamonds
Ace of Hearts
7 of Clubs
5 of Spades
Two pair
true
true
true
true
true
true
true
true
true
true
true
true
```

#### The exact cards and the type of hand will vary with each run.

---

### Solution:

``` ruby
class Card
  FACE_WEIGHTS = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  include Comparable

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other)
    weight <=> other.weight
  end

  def weight
    FACE_WEIGHTS.fetch(rank, rank)
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    reset
  end

  def reset
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end

    @cards.shuffle!
  end

  def draw
    reset if @cards.empty?
    @cards.pop
  end
end

class PokerHand
  def initialize(deck)
    @hand = []
    5.times { |_| @hand << deck.draw }
  end

  def print
    @hand.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    return false unless flush?
    weights.sort == [10, 11, 12, 13, 14]
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    (@hand.count(@hand[0]) == 4) || (@hand.count(@hand[1]) == 4)
  end

  def full_house?
    ((@hand.count(@hand.max) == 3) && (@hand.count(@hand.min) == 2)) ||
    ((@hand.count(@hand.max) == 2) && (@hand.count(@hand.min) == 3))
  end

  def flush?
    uniq_suits == 1
  end

  def straight?
    (uniq_weights == 5) && (@hand.max.weight - @hand.min.weight == 4)
  end

  def three_of_a_kind?
    (@hand.count(@hand[0]) == 3) ||
    (@hand.count(@hand[1]) == 3) ||
    (@hand.count(@hand[2]) == 3)
  end

  def two_pair?
    counts = @hand.map { |card| @hand.count(card) }
    counts.select { |count| count == 2 }.size == 4
  end

  def pair?
    counts = @hand.map { |card| @hand.count(card) }
    counts.select { |count| count == 2 }.size == 2
  end

  def suits
    @hand.map(&:suit)
  end

  def weights
    @hand.map(&:weight)
  end

  def uniq_suits
    suits.uniq.size
  end

  def uniq_weights
    weights.uniq.size
  end
end
```
