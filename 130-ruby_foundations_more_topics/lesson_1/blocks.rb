def test(&block)
  puts "What's &block? #{block}"
end

test { sleep(1) }



def times(number)
  (0...number).each do |x|
    yield(x)
  end

  number
end



def each(array)
  idx = 0

  while idx < array.size
    yield(array[idx])
    idx += 1
  end

  array
end



def select(array)
  result = []
  idx = 0

  while idx < array.size
    result << array[idx] if yield(array[idx])
    idx += 1
  end

  result
end



def reduce(array, acc = 0)
  idx = 0

  while idx < array.size
    acc = yield(acc, array[idx])
    idx += 1
  end

  acc
end
