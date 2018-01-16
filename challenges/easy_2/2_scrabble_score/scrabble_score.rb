# scrabble_score.rb

class Scrabble
  LETTER_SCORES = { a: 1, e: 1, i: 1, o: 1, u: 1, l: 1, n: 1, r: 1, s: 1, t: 1,
                    d: 2, g: 2,
                    b: 3, c: 3, m: 3, p: 3,
                    f: 4, h: 4, v: 4, w: 4, y: 4,
                    k: 5,
                    j: 8, x: 8,
                    q: 10, z: 10 }

  def self.score(word)
    return 0 if word.nil? || word =~ /\A\s*\z/
    raise RuntimeError, 'Invalid characters!' if word =~ /[^a-zA-z]/

    word.chars.map { |char| LETTER_SCORES[char.downcase.to_sym] }.reduce(:+)
  end

  def initialize(word)
    @word = word
  end

  def score
    self.class.score(@word)
  end
end
