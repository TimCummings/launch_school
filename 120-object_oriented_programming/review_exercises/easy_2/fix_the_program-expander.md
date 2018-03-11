
[comment]: # (fix_the_program-expander.md)

### Fix the Program - Expander - 5/24/2017

#### What is wrong with the following code? What fix(es) would you make?

``` ruby
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
```

---

### Solution:

``` ruby
class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
```

In `Expander#to_s`, change `self.expand(3)` to `expand(3)`.
