# word_count.rb

# class Phrase
#   def initialize(phrase)
#     raise ArgumentError, 'Input must be a string.' unless phrase.is_a? String
#     @phrase = phrase.gsub(/[^\w\s']|\s'|'\s/, ' ')
#   end
#
#   def word_count
#     @phrase.split.each_with_object(Hash.new(0)) do |word, results|
#       results[word.downcase] += 1
#     end
#   end
# end

# refactor to make better use of regex
class Phrase
  def initialize(text)
    @words = text.scan(/\w+'\w+|\w+/)
  end

  def word_count
    @words.each_with_object(Hash.new(0)) do |word, results|
      results[word.downcase] += 1
    end
  end
end
