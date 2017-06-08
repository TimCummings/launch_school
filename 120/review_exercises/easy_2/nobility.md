
[comment]: # (nobility.md)

### Nobility - 5/24/2017

#### Now that we have a `Walkable` module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

#### We need a new class `Noble` that shows the title and name when `walk` is called:

``` ruby
byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
```

#### We must have access to both name and title because they are needed for other purposes that we aren't showing here.

```
byron.name
=> "Byron"
byron.title
=> "Lord"
```

---

### Solution:

``` ruby
module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "strolls"
  end
end

class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
```

---

### Further Exploration

#### This exercise can be solved in a similar manner by using inheritance; a `Noble` is a `Person`, and a `Cheetah` is a `Cat`, and both `Person`s and `Cat`s are `Animal`s). What changes would you need to make to this program to establish these relationships and eliminate the two duplicated `#to_s` methods?

---

### Solution:

``` ruby
module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def to_s
    "#{title} " + super
  end

  private

  def gait
    "struts"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
```

---

#### Is `to_s` the best way to provide the `name` and `title` functionality we needed for this exercise? Might it be better to create either a different `name` method (or say a new `full_name` method) that automatically accesses `@title` and `@name`? There are tradeoffs with each choice -- they are worth considering.

Different `name` and `full_name` methods would be a good way to provide distinct functionality; if that's not needed, using `to_s` is more seamless that explicity invoking a separate method.
