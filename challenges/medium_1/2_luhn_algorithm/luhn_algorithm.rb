# luhn_algorithm.rb

# class Luhn
#   def self.create(partial_number)
#     raise TypeError, 'Must provide an integer.' unless partial_number.is_a? Integer
#     partial_luhn = Luhn.new(partial_number * 10)
#     check_digit = 10 - partial_luhn.checksum % 10
#     check_digit = 0 if check_digit == 10
#     partial_number * 10 + check_digit
#   end
#
#   def initialize(full_number)
#     raise TypeError, 'Must provide an integer.' unless full_number.is_a? Integer
#     @digits = full_number.digits
#   end
#
#   def addends
#     @digits.map.with_index do |digit, idx|
#       test_digit(digit, idx)
#     end.reverse
#   end
#
#   def checksum
#     addends.reduce(:+)
#   end
#
#   def valid?
#     checksum % 10 == 0
#   end
#
#   def test_digit(digit, idx)
#     digit *= 2 if idx.odd?
#     digit -= 9 if digit > 9
#     digit
#   end
# end



# Palindrome exercise

# * input: string representing palindrome
# * output: boolean representing whether the input string is a palindrome or not
# * edge cases:
#   - no input -> automatically raises ArgumentError
#   - input not a string -> raise TypeError
#   - string is empty -> return false
#   - string contains non letter characters -> ignore them
#   - case insensitive

# * Pseudocode:
#   - guard against edge cases
#     + raise TypeError unless input is a string
#     + invalid characters:
#       * split string into array of characters; select only valid characters (letters)
#       * map validated character array ensuring all letters are lowercase
#     + return false if string is empty
#   - reverse string (not allowed to use Ruby's built in)
#     + create a new array for the reversed string
#     + iterate over the valid, lowercased character array from back to front (using the last index down to zero)
#     + push the current character into the new array
#   - compare the two arrays

def palindrome?(word)
  raise TypeError, 'Input must be a string.' unless word.is_a? String
  validated_chars = word.chars.select { |char| valid_char? char }
  validated_chars = validated_chars.map { |char| char.downcase }
  return false if validated_chars.empty?

  reversed_chars = []
  (validated_chars.size - 1).downto(0) do |idx|
    reversed_chars << validated_chars[idx]
  end

  validated_chars == reversed_chars
end

def valid_char?(char)
  ('a'..'z').include?(char) || ('A'..'Z').include?(char)
end



# only iterating a single time
def palindrome?(word)
  chars = word.chars
  fwd_idx = 0
  rev_idx = chars.size - 1

  while fwd_idx < rev_idx do
    fwd_idx += 1 unless valid_char?(chars[fwd_idx])
    rev_idx -= 1 unless valid_char?(chars[rev_idx])
    return false unless chars[fwd_idx].downcase == chars[rev_idx].downcase
    fwd_idx += 1
    rev_idx -= 1
  end

  true
end

def valid_char?(char)
  ('a'..'z').include?(char) || ('A'..'Z').include?(char)
end
