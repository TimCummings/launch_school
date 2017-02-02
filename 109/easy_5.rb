# easy_5.rb

# # ASCII String Value
# def ascii_value(string)
#   string.chars.inject(0) { |sum, value| sum += value.ord }
# end

# the mystery method is Integer#chr
# String#ord when called on a string with more than one character returns the ASCII string value of the first character in the string



# # After Midnight (Part 1)
# # without Date or Time classes
# def time_of_day(time)
#   hours = (time / 60) % 24
#   minutes = time % 60
#   if time.negative?
#     sprintf("%02d:%02d", (0 - hours).abs, (0 - minutes).abs)
#   else
#     sprintf("%02d:%02d", hours, minutes)
#   end
# end
#
# # with Date or Time classes
# SECONDS_PER_MINUTE = 60
#
# def time_of_day(delta_minutes)
#   default_time = Time.new(2016, 10, 30)
#   time = default_time + (delta_minutes * SECONDS_PER_MINUTE)
#   time.strftime("%H:%M")
# end
#
# # with Date or Time classes, considering day of the week
# SECONDS_PER_MINUTE = 60
# DAYS_OF_WEEK = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
#
# def time_of_day(delta_minutes)
#   default_time = Time.new(2016, 10, 30)
#   time = default_time + (delta_minutes * SECONDS_PER_MINUTE)
#   time.strftime("#{DAYS_OF_WEEK[time.wday]} %H:%M")
# end



# # After Midnight (Part 2)
# HOURS_PER_DAY = 24
# MINUTES_PER_HOUR = 60
# MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR
#
# def before_midnight(time)
#   hours, minutes = time.split(':').map {|string| string.to_i }
#   minutes += hours * MINUTES_PER_HOUR
#   (MINUTES_PER_DAY - minutes) % MINUTES_PER_DAY
# end
#
# def after_midnight(time)
#   hours, minutes = time.split(':').map {|string| string.to_i }
#   (minutes += hours * MINUTES_PER_HOUR) % MINUTES_PER_DAY
# end



# # Letter Swap
# def swap(string)
#   words = string.split(' ')
#   words = words.map do |word|
#     next word if word.size == 1
#
#     first = word.slice!(0)
#     last = word.slice!(-1)
#     last + word + first
#   end
#
#   words.join(' ')
# end
#
# # It would not work: as it is written, this returns an array



# # Clean up the words
#
# # with Regexp
# def cleanup(string)
#   string.gsub(/[^[:alpha:]]+/, '')
# end

# # without Regexp
# ALPHABETICS = ('a'..'z').to_a + ('A'..'Z').to_a
#
# def cleanup(string)
#   characters = string.chars
#   characters.map! { |char| ALPHABETICS.include?(char) ? char : ' ' }
#   characters.join.squeeze(' ')
# end



# # Letter Counter (Part 1)
# def word_sizes(string)
#   lengths = {}
#   words = string.split(' ')
#   words.each do |word|
#     lengths[word.size] = 0 unless lengths.include?(word.size)
#     lengths[word.size] += 1
#   end
#   lengths
# end



# # Letter Counter (Part 2)
# def word_sizes(string)
#   lengths = Hash.new(0)
#   words = string.split(' ')
#   words.each { |word| lengths[cleanup(word).size] += 1 }
#   lengths
# end



# # Alphabetical Numbers
#
# NUM_WORDS = %w(zero one two three four five six seven eight nine ten
#                eleven twelve thirteen fourteen fifteen sixteen seventeen
#                eighteen nineteen)
#
# def num_to_word(number)
#   NUM_WORDS[number]
# end
#
# def word_to_num(string)
#   NUM_WORDS.index(string)
# end
#
# def alphabetic_number_sort(num_array)
#   word_array = num_array.map { |num| num_to_word(num) }
#   word_array.sort!
#   word_array.map { |word| word_to_num(word) }
# end
#
# # Array#sort_by! is destructive and would mutate the argument array



# # ddaaiillyy ddoouubbllee
# def crunch(string)
#   crunched_string = ''
#   char_array = string.chars
#   char_array.each_with_index do |char, idx|
#     next if char == char_array[idx + 1]
#     crunched_string << char
#   end
#
#   crunched_string
# end
#
# # We continue iterating until index points past the end of the string because this is the most straight-forward algorithm for solving this problem and lets us depend on text[index + 1] being nil instead of having to create an extra step to detect and handle the last character manually.
#
# # If we stop iterating when index is equal to text.length - 1, the last character of the string will not be evaluated and will be left out of the result.
#
# # I did not use each_char or chars because they do not provide an index to be able to access the preceeding or subsequent characters in the string for comparison. Instead, I used Enumerable#each_with_index.
#
# # using each_char or chars:
# def crunch(string)
#   crunched_string = ''
#   previous_char = ''
#   string.each_char do |char|
#     crunched_string << char if char != previous_char
#     previous_char = char
#   end
#
#   crunched_string
# end
#
# # using regexp:
# def crunch(string)
#   string.gsub(/((.)\2+)/, '\2')
# end



# # Bannerizer
# def print_in_box(string)
#   content_width = string.size
#   puts '+-' + ''.center(content_width, '-') + '-+'
#   puts '| ' + ''.center(content_width) + ' |'
#   puts '| ' + string.center(content_width) + ' |'
#   puts '| ' + ''.center(content_width) + ' |'
#   puts '+-' + ''.center(content_width, '-') + '-+'
# end

# # truncating version
# MAX_COLUMNS = 80
#
# def print_in_box(string)
#   string = string.slice(0, MAX_COLUMNS) if string.size > MAX_COLUMNS
#   content_width = string.size
#
#   horizontal_rule = '+-' + ''.center(content_width, '-') + '-+'
#   empty_line =  '| ' + ''.center(content_width) + ' |'
#
#   puts horizontal_rule
#   puts empty_line
#   puts "| #{string} |"
#   puts empty_line
#   puts horizontal_rule
# end

# wrapping vesion (chars, not words)
MAX_COLUMNS = 80

def set_width(string)
  string.size < MAX_COLUMNS ? string.size : MAX_COLUMNS
end

def display_message(lines, content_width)
  horizontal_rule = '+-' + ''.center(content_width, '-') + '-+'
  empty_line =  '| ' + ''.center(content_width) + ' |'

  puts horizontal_rule
  puts empty_line
  puts lines
  puts empty_line
  puts horizontal_rule
end

def print_in_box(string)
  lines = []
  line = ''
  words = string.split
  content_width = set_width(string)

  words.each do |word|
    if line.empty?
      line << word
    elsif (line.length + ' '.length + word.length) <= MAX_COLUMNS
      line << " #{word}"
    else
      lines.push("| #{line.ljust(content_width)} |")
      line = word
    end
  end

  lines.push("| #{line.ljust(content_width)} |")
  display_message(lines, content_width)
end

"Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked. If Peter Piper picked a peck of pickled peppers, then where's the peck of pickled peppers Peter Piper picked?"
