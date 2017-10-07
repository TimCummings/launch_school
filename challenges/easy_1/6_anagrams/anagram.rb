# anagram.rb

# class Anagram
#   def initialize(subject)
#     @subject = subject
#     @subj_char_count = char_count(subject)
#   end
#
#   def char_count(string)
#     count = Hash.new(0)
#     string.chars.each do |char|
#       next if char =~ /\s/
#       count[char.downcase] += 1
#     end
#     count
#   end
#
#   def match(candidates)
#     raise ArgumentError, 'Input must be an array.' unless candidates.is_a? Array
#     results = []
#
#     candidates.each do |candidate|
#       raise ArgumentError, 'Input must be array of strings.' unless candidate.is_a? String
#       next if candidate.downcase == @subject.downcase
#       results << candidate if char_count(candidate) == @subj_char_count
#     end
#
#     results
#   end
# end



# refactor to use `Array#select` in `Anagram#match`
class Anagram
  def initialize(subject)
    @subject = subject
    @subj_char_count = char_count(subject)
  end

  def char_count(string)
    count = Hash.new(0)
    string.chars.each do |char|
      next if char =~ /\s/
      count[char.downcase] += 1
    end
    count
  end

  def match(candidates)
    raise ArgumentError, 'Input must be an array.' unless candidates.is_a? Array

    candidates.select do |candidate|
      raise ArgumentError, 'Input must be array of strings.' unless candidate.is_a? String
      next if candidate.downcase == @subject.downcase
      char_count(candidate) == @subj_char_count
    end
  end
end
