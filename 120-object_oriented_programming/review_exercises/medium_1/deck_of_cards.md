
[comment]: # (deck_of_cards.md)

### Deck of Cards - 6/3/2017

#### Using the Card class from the previous exercise, create a Deck class that contains all of the standard 52 playing cards. Use the following code to start your work:

``` ruby
class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
end
```

#### The Deck class should provide a `#draw` method to draw one card at random. If the deck runs out of cards, the deck should reset itself by generating a new set of 52 cards.

#### Examples:

``` ruby
deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
drawn != drawn2 # Almost always.
```

#### Note that the last line should almost always be true; if you shuffle the deck 1000 times a second, you will be very, very, very old before you see two consecutive shuffles produce the same results. If you get a false result, you almost certainly have something wrong.

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
```
