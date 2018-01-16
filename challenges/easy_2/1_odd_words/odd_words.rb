# odd_words.rb

# standard (non-bonus) solution
class OddWords
  def initialize(text)
    raise TypeError, 'Input must be a string.' unless text.is_a? String
    sanitize(text)

    @words = text.split(/\s+/)
    if @words.any? { |word| word.length > 20 }
      warn 'WARNING: Input contains oversized word(s)!'
    end
  end

  def sanitize(text)
    if text =~ /[^a-zA-Z .]/
      warn 'WARNING: Input contains invalid characters! Valid characters are limited to letters, spaces, and an ending period.'
      text.gsub! /[^a-zA-Z .]/, ''
    end

    unless text[-1] == '.'
      warn 'WARNING: Input is missing ending period!'
      text << '.'
    end

    if text.scan(/\./).size > 1
      warn 'WARNING: Input contains multiple periods - text after the first period will be ignored!'
      idx = (text =~ /\./) + 1
      text.slice!(idx..-1)
    end
  end

  def process
    @words << @words.last.slice!(-1) unless @words.last == '.'

    @words[0..-2].map.with_index do |word, idx|
      idx.odd? ? word.reverse : word
    end.join(' ') + @words.last
  end
end



# bonus solution
# class OddWords
#   def initialize(input: $stdin, output: $stdout)
#     @input = input
#     @output = output
#   end
#
#   def print_buffer(string)
#     string.each_char { |char| @output.print char }
#   end
#
#   def process
#     word_counter = 0
#     odd_word = ''
#     prev_char = ''
#
#     characters = @input.each_char
#     characters.each do |char|
#       case char
#       when ' '
#         if prev_char == ' '
#           next
#         else
#           if word_counter.odd?
#             print_buffer(odd_word.reverse)
#             odd_word = ''
#           end
#           word_counter += 1
#           prev_char = char
#         end
#       when '.'
#         print_buffer(odd_word.reverse) unless odd_word.empty?
#         @output.print(char)
#       else
#         if word_counter.odd?
#           odd_word << char
#           @output.print prev_char if prev_char == ' '
#           prev_char = char
#         else
#           @output.print prev_char if prev_char == ' '
#           @output.print char
#           prev_char = char
#         end
#       end
#     end
#   end
# end
