# pig_latin.rb

class PigLatin
  def self.translate(phrase)
    raise ArgumentError unless phrase.is_a? String
    puts "Discarding invalid characters." if phrase.gsub!(/[^a-zA-Z ]/, '')

    phrase.downcase.split(' ').map do |word|
      case word
      when /\A([xy][^aeiou]|[aeiou])/ then translate_vowel_sound(word)
      when /\A([xy][aeiou]|[^aeiou])/ then translate_consonant_sound(word)
      end
    end.join(' ')
  end

  def self.translate_vowel_sound(word)
    word << 'ay'
  end

  def self.translate_consonant_sound(word)
    first_sound = slice_first_sound(word)
    word + first_sound + 'ay'
  end

  def self.slice_first_sound(word)
    # starts with 'qu' or a consonant then 'qu' or one or more consonants
    word.slice!(/\A(qu|[^aeiou]qu|[^aeiou]+)/)
  end
end
