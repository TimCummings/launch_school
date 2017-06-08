
[comment]: # (prep.md)

# OO Twenty-One

### 1. Write a textual description of the problem or exercise.
In Twenty-One, a player plays against a dealer and tries to get a higher score than the dealer, without exceeding 21 points. If the player or the dealer *busts* (exceeds 21 points), that player immediately loses. Points are determined using a standard 52 card deck with four suites, each with thirteen unique cards. Suite does not affect the point value of a card; values are as follows:
* Numeric cards (2-10): worth the number on the card, e.g. a three of hearts is worth 3 points.
* Face cards (Jack, Queen, King): worth 10 points.
* Aces: worth 1 or 11 points. An Ace is worth 11 points by default, unless the player's total score is greater than 21; if the player's score ever exceeds 21, an Ace's value changes from 11 points to just 1 point (this applies retroactively if the player already has an Ace and a different card pushes the player's score above 21). In the case of multiple Aces, each Ace's point value will be assessed, one at a time: an Ace's value will be reduced from 11 to 1 until the player's score is 21 or less.
  - Ex: Three Aces will be worth 11 + 1 + 1 = 13 points

The dealer alternates dealing one card at a time to each player (ending with the dealer) until all players have two cards. The dealer's first card is hidden but the second card is visible; the player's cards are all visible. Once each player has two cards, it is the player's turn: the player must decide whether to *hit* (get another random card from the deck) or *stay* (keep his/her current cards and total point value). This continues until the player *stays* or *busts*. If the player *busts*, he/she loses.

Once the player stays, it is the dealer's turn. The dealer must follow specific rules:
* If the dealer's score is less than 17, the dealer **must** *hit*.
* If the dealer's score is 17 or higher (and the dealer has not *busted*), the dealer **must** *stay*.

Once the dealer *stays*, scores are compared:
* The player with the higher score wins.
* If the player and the dealer have the same score, they *push* (tie).

### 2. Extract the major nouns and verbs from the description.
* Nouns:
  - player
  - dealer
  - score
  - deck
  - cards
  - suite
  - point value
  - Ace
  -rules


* Verbs:
  - play
  - win/lose
  - bust
  - deal
  - hit
  - stay
  - compare
  - push/tie


### 3. Organize and associate the verbs with the nouns.
* player
  - hit
  - stay
  - bust/lose
  - win
  - push/tie


* dealer
  - deal
  - hit
  - stay
  - bust/lose
  - win
  - push/tie


* score
  - compare


* deck


* cards
