
[comment]: # (fixed_array.md)

### Fixed Array - 5/27/2017

#### A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

``` ruby
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end
```

### The above code should output `true` 15 times.

---

### Solution:

``` ruby
class FixedArray
  def initialize(size)
    @size = size
    @array = Array.new(size)
  end

  def [](index)
    if index < -@size || index >= @size
      raise IndexError
    else
      @array[index]
    end
  end

  def []=(index, object)
    if index < -@size || index >= @size
      raise IndexError
    else
      @array[index] = object
    end
  end

  def to_a
    @array
  end

  def to_s
    @array.to_s
  end
end
```

---

### Corrections:

`FixedArray#to_a` needs to return a copy, not the underlying collaborator `Array` (that gives access to the underlying `Array` and lets users potentially change its size).

We can re-use `FixedArray#to_a` in `FixedArray#to_s`:

``` ruby
  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
```
