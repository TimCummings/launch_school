
[comment]: # (complete_the_program-houses.md)

### Complete the Program - Houses - 5/23/2017

#### Assume you have the following code:

``` ruby
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
```

#### and this output:

```
Home 1 is cheaper
Home 2 is more expensive
```

#### Modify the `House` class so that the above program will work. You are permitted to define only one new method in `House`.

---

### Solution:

``` ruby
class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
```

---

### Further Exploration

#### Is the technique we employ here to make `House` objects comparable a good one? (Hint: is there a natural way to compare Houses? Is price the only criteria you might use?) What problems might you run into, if any? Can you think of any sort of classes where including `Comparable` is a good idea?

For houses, square footage is probably a better comparison. But one could also use age. Location, neighborhood, nearby amenities or sources of disturbance (e.g. train tracks, airports) are also used to compare houses, but these are more difficult to quantify.

Including `Comparable` could be a good idea in any class that needs to compare instances. This would certainly be useful for online shopping to be able to sort products by various attributes.
