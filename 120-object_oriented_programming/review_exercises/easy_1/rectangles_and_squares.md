
[comment]: # (rectangles_and_squares.md)

### Rectangles and Squares - 5/22/2017

#### Given the following class:

``` ruby
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end
```

#### Write a class called `Square` that inherits from `Rectangle`, and is used like this:

``` ruby
square = Square.new(5)
puts "area of square = #{square.area}"
```

---

### Solution:

``` ruby
class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(side)
    super(side, side)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"
```
