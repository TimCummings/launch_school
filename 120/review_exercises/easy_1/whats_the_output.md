
[comment]: # (whats_the_output.md)

# What's the Output? - 5/17/2017

#### Take a look at the following code:

``` ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

#### What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

This code prints:
```
Fluffy
My name is FLUFFY.
FLUFFY
FLUFFY
```

Fixed code:

``` ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

---

### Further Exploration

#### What would happen in this case?

``` ruby
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```

This prints:
```
42
My name is 42.
42
43
```

#### This code "works" because of that mysterious `to_s` call in `Pet#initialize`. However, that doesn't explain why this code produces the result it does. Can you?

`name` is assigned `42` which is an `Integer`. When the `Integer` `42` is passed to `Pet#initialize`, it calls `to_s` on the `Integer` `42`. `Integer#to_s` returns a `String` object, which is what is assigned to the `Pet` `@name` instance variable. Now `name` and `@name` point to different objects.
