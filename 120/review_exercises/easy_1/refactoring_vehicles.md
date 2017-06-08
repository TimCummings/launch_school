
[comment]: # (refactoring_vehicles.md)

### Refactoring Vehicles - 5/22/2017

#### Consider the following classes:

``` ruby
class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end
```

#### Refactor these classes so they all use a common superclass, and inherit behavior as needed.

---

### Solution:

``` ruby
class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end
```

---

### Further Exploration

#### Would it make sense to define a `wheels` method in `Vehicle` even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?

I would not currently define a `wheels` method in `Vehicle` for two reasons: all of the current classes would be overriding it, and there are plenty of vehicles that do not have wheels; we are not using any such classes currently, but that is a likely possibility.

If I were to define a `wheels` method in `Vehicle`, it would be:

``` ruby
def wheels
  4
end
```

I would default to the most common occurrence (four wheeled vehicles) which would let us get rid of `wheels` in `Car`, and continue to override `wheels` in the less commonly occurring situations.
