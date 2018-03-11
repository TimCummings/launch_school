
[comment]: # (what_will_this_do.md)

### What Will This Do? - 5/23/2017

#### What will the following code print?

``` ruby
class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
```

---

### Solution:

This code will print:
```
ByeBye
HelloHello
```
