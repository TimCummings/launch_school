# day_04-1.rb

def valid_phrase?(phrase)
  valid_words = Hash.new(0)
  words = phrase.split
  words.each do |word|
    return false unless valid_word?(word)
    valid_words[sort_letters(word)] += 1
  end
  valid_words.values.none? { |occurrence| occurrence > 1 }
end

def valid_word?(word)
  !word.match?(/[^a-z]/)
end

def sort_letters(word)
  word.chars.sort.to_s
end

valid_phrases = 0

File.open('day_04_input.txt').each do |phrase|
  valid_phrases += 1 if valid_phrase?(phrase.chomp)
end

puts valid_phrases

# Part 1 Answer: 
