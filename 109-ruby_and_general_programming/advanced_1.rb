# advanced_1.rb

# # Madlibs Revisited
# WORDS = {
#   adjective:
#     %w(fierce slim tall short skinny fat round square rectangular cylindrical
#        timid shy happy mirthful sad morose angry enraged pathetic apathetic),
#   adverb:
#     %w(slowly quickly carefully carelessly tirelessly slothfully meticulously
#        painstakingly happily angrily pathetically determinedly),
#   noun:
#     %w(man woman clown dog cat monkey elephant car bus train house apartment
#        tire flamingo),
#   verb:
#     %w(eats tastes smells sniffs pats flies jumps runs judges flails pursues
#        hides scares terrifies frightens chases follows selects)
# }
#
# def madlibs(filename)
#   File.open(filename).each do |line|
#     WORDS.each do |k, v|
#       until line.match(/\b#{k.to_s}\b/i) == nil
#         line.sub!(/\b#{k.to_s}\b/i, v.sample)
#       end
#     end
#     puts line
#   end
# end



# # Seeing Stars
# def stars(num)
#   last_half = []
#   0.upto(num / 2 - 1) do |spaces|
#     string = '*' + (' ' * spaces) + '*' + (' ' * spaces) + '*'
#     last_half << string.center(num)
#   end
#
#   lines = last_half.reverse
#   lines << "*" * num << last_half
#   puts lines
# end



# # Transpose 3x3
# def transpose(matrix)
#   result = [[], [], []]
#   0.upto(matrix.size - 1) do |row|
#     0.upto(matrix.size - 1) { |col| result[row] << matrix[col][row] }
#   end
#
#   result
# end
#
# # Further Exploration
# def transpose!(matrix)
#   indices = (0..(matrix.size - 1)).to_a.combination(2).to_a
#   indices.each do |x, y|
#     matrix[x][y], matrix[y][x] = matrix[y][x], matrix[x][y]
#   end
#   matrix
# end



# # Transpose MxN
# def transpose(matrix)
#   result = []
#   line = []
#
#   0.upto(matrix[0].size - 1) do |col|
#     0.upto(matrix.size - 1) do |row|
#       line << matrix[row][col]
#     end
#     result << line
#     line = Array.new
#   end
#
#   result
# end

# Further Exploration
# The 3x3 matrix was a great starting point. This exercise would have been more difficult starting with non-square matrices.



# # Rotating Matrices
# def rotate90(matrix)
#   result = []
#   line = []
#
#   0.upto(matrix[0].size - 1) do |col|
#     (matrix.size - 1).downto(0) do |row|
#       line << matrix[row][col]
#     end
#     result << line
#     line = Array.new
#   end
#
#   result
# end
#
# # Further Exploration
# def rotate(matrix, degrees=90)
#   (degrees / 90).times do
#     matrix = rotate90(matrix)
#   end
#
#   matrix
# end



# #Permutations
# def heap_perm(array, n, result)
#   if n == 1
#     result << array.dup
#   else
#     0.upto(n - 2) do |i|
#       heap_perm(array, n - 1, result)
#       if n.even?
#         array[i], array[n - 1] = array[n - 1], array[i]
#       else
#         array[0], array[n - 1] = array[n - 1], array[0]
#       end
#     end
#     heap_perm(array, n - 1, result)
#   end
# end
#
# def permutations(array)
#   result = []
#   size = array.size
#   heap_perm(array.dup, size, result)
#   result
# end
#
# # Further Exploration: I started with Heap's Algorithm



# # Fix the Bug
# def my_method(array)
#   if array.empty?
#     []
#   elsif array.size > 1
#     array.map do |value|
#       value * value
#     end
#   else
#     [7 * array.first]
#   end
# end
#
# p my_method([])
# p my_method([3])
# p my_method([3, 4])
# p my_method([5, 6, 7])

# The provided my_method was missing a condition for the second branch (the "elsif"). Since the conditional was missing, the body was treated as the conditional and the array returned by Array#map evaluates to true, but then there is no body to execute.
# The bug is fixed by adding an appropriate conditional (array.size > 1) to get the output to match what is expected.



# # Merge Sorted Lists
# def merge(array_1, array_2)
#   result = []
#   array_1 = array_1.dup
#   array_2 = array_2.dup
#
#   until array_1.empty? || array_2.empty? do
#     if array_1.first < array_2.first
#       result << array_1.shift
#     else
#       result << array_2.shift
#     end
#   end
#
#   result += array_1 unless array_1.empty?
#   result += array_2 unless array_2.empty?
#   result
# end



# # Merge Sort
# def merge_sort(array)
#   return array if array.size == 1
#
#   midpoint = (array.size - 1) / 2
#   first_half = array[0..midpoint]
#   last_half = array[(midpoint + 1)..-1]
#
#   merge(merge_sort(first_half), merge_sort(last_half))
# end
#
# # Further Exploration
# # non-recursive merge sort
# def merge_sort(array)
#   return array if array.size == 1
#   result = []
#   array = array.map { |element| [element] }
#
#   ((array.size - 1) / 2 + 1).times do
#     (array.size / 2).times { result << merge(array.shift, array.shift) }
#     array, result = result, array
#   end
#
#   array.flatten
# end



# Egyptian Fractions
def egyptian(rational)
  result = []
  denom = 1

  while rational >= 1
    result << Rational(1, denom)
    rational -= result.last
    denom += 1
  end

  while rational > 0
    closest = (rational.denominator.to_f / rational.numerator).ceil
    denom = closest if denom <= closest
    result << Rational(1, denom)
    rational -= result.last
    denom += 1
  end

  result.map { |fraction| fraction.denominator }
end

def unegyptian(array)
  array.map { |denom| Rational(1, denom) }.reduce(:+)
end
