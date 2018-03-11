
[comment]: # (reverse_engineering.md)

### Reverse Engineering - 5/23/2017

#### Write a class that will display:

```
ABC
xyz
```

### when the following code is run:

``` ruby
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
```

---

### Solution:

``` ruby
class Transform
  def self.lowercase(string)
    string.downcase
  end

  def initialize(phrase)
    @data = phrase
  end

  def uppercase
    @data.upcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')
```
