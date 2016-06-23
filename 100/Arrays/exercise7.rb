# exercise7.rb

def incr_by_two(array)
  built = []
  array.map { |value| built.push(value + 2) }
  p array
  p built
end

array = [8, 22, 17, 34, 56, 3, 0, 91]

incr_by_two(array)
