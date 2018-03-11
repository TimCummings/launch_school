
[comment]: # (easy_1.md)

# Easy 1 - 5/1/2017

---

#### 1. Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

1. `true`
2. `"hello"`
3. `[1, 2, 3, "happy days"]`
4. `142`

All of the above are objects in Ruby. You can find an object's class by invoking the `Object#class` method:

1. `true.class` => TrueClass
2. `"hello".class` => String
3. `[1, 2, 3, "happy days"].class` => Array
4. `142.class` => Integer

---

#### 2. If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast` using the module `Speed`? How can you check if your `Car` or `Truck` can now go fast?

##### Provided code:
```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

Both the `Car` class and the `Truck` class need to include the `Speed` module:
`include Speed`

This can then be tested by creating a `Car` and `Truck` object and having each one attempt to call `go_fast`:

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slowly."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

lumina = Car.new
f150 = Truck.new
lumina.go_fast
f150.go_fast
```
This outputs:
I am a Car and going super fast!
I am a Truck and going super fast!

---

#### 3. When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

When we `include Speed` in the `Car` class, we are effectively adding the method(s) in the `Speed` module to the `Car` class. When we create a `Car` object, that object is what calls the `go_fast` method; so when Ruby gets into the `go_fast` method and evaluates `self.class`, `self` in this scope is the `Car` object we created.

`self.class` becomes equivalent to `small_car.class`.

---

#### 4. If we have a class `AngryCat` how do we create a new instance of this class?

`AngryCat.new`

---

#### 5. Which of these two classes has an instance variable and how do you know?

`Pizza` has an instance variable `@name` as denoted by the `@`.

---

#### 6. What could we add to the class below to access the instance variable `@volume`?

We could add:
* getter method
``` ruby
def volume
    @volume
end
```
* attribute reader
``` ruby
attr_reader :volume
```
* attribute accessor:
``` ruby
attr_accessor :volume
```

---

#### 7. What is the default thing that Ruby will print to the screen if you call to_s on an object? Where could you go to find out if you want to be sure?

By default, calling an object's `to_s` method will print a representation of that object which includes its class name and an encoding of its `object_id`. The `to_s` method, if not overriden, can be found in the `Object` class: http://ruby-doc.org/core-2.4.1/Object.html#method-i-to_s

---

#### 8. If we have a class such as the one below:
``` ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```
#### You can see in the make_one_year_older method we have used self. What does self refer to here?

In this code, `self` refers to the calling object - the instance of `Cat` that would be calling this method.

---

#### 9. If we have a class such as the one below:

``` ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

#### In the name of the cats_count method we have used self. What does self refer to in this context?

In this code, `self` is being used to define a class method; as such, `self` here refers to the `Cat` class itself (not an instantiated `Cat` object.)

---

#### 10. If we have the class below, what would you need to call to create a new instance of this class.

``` ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

To create an instance of the `Bag` class, we would still do what we have previously done and call `Bag#new`, but we would need to provide two arguments as shown in the `initialize` method: `Bag.new('green', 'nylon')`
