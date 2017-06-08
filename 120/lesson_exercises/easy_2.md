
[comment]: # (easy_2.md)

# Easy 2 - 5/1/2017

---

#### 1. You are given the following code:
``` ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```
#### What is the result of calling
``` ruby
oracle = Oracle.new
oracle.predict_the_future
```

This code will return (*not* print) a string composed of `"You will "` and a random phrase from the array, e.g. `"You will stay at work late"`.

---

#### 2. We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class.
``` ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```
#### What is the result of the following:
``` ruby
trip = RoadTrip.new
trip.predict_the_future
```

The result will be similar to the previous question, only the random phrase composing the second part of the sentence will be selected from the new array, since `RoadTrip` overrides `Oracle#choices`, e.g. `"You will fly to Fiji"`.

---

#### 3. How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

``` ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```
#### What is the lookup chain for Orange and HotSauce?

To find where Ruby looks for methods when they are called, one would check Ruby's lookup path for the calling object's class. You can find a class's lookup path/ancestors by calling `Method#ancestors` on it:
``` ruby
Orange.ancestors
# => [Orange, Taste, Object, Kernel, BasicObject]
HotSauce.ancestors
# => [HotSauce, Taste, Object, Kernel, BasicObject]
```

---

#### 4. What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?
``` ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

An attribute accessor:

``` ruby
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end
```

---

#### 5. There are a number of variables listed below. What are the different types and how do you know which is which?
``` ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

It is difficult to answer this question accurately without knowing the context in which this code occurs. **IF** this is inside a class definition, `excited_dog` is a local variable and `@@excited_dog` is a class variable. `@excited_dog` could be an instance variable if it's within an instance method; otherwise it's a class instance variable.

If these are not inside a class at all, `excited_dog` is a local variable, `@excited_dog` will be `nil`, `@@excited_dog` will throw a `NameError: uninitialized class variable`.

---

#### 6. If I have the following class:
``` ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```
#### Which one of these is a class method (if any) and how do you know? How would you call a class method?
`manufacturer` is a class method because its definition is prefixed with `self`, indicating it is being defined on the `Television` class itself, and not as an instance method. You could call it by: `Television.manufacturer`

---

#### 7. If we have a class such as the one below:
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
#### Explain what the `@@cats_count` variable does and how it works. What code would you need to write to test your theory?

The `@@cats_count` variable is a class variable that keeps track of how many instances of the `Cat` class have been created. It works by being incremented in the `Cat:initialize` method, which is called whenever a new `Cat` object is instantiated. We can test it with the following:
``` ruby
Cat.cats_count
# this will be 0 since we have not yet instantiated any `Cat`'s
felix = Cat.new('cartoon')
garfield = Cat.new('tabby')
Cat.cats_count
# this will now be 2 since we have created 2 `Cat` objects
leo = Cat.new('lion')
Cat.cats_count
# We made a third `Cat` so this is now 3
```

---

#### 8. If we have this class:
``` ruby
class Game
  def play
    "Start the game!"
  end
end
```
#### And another class:
``` ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```
#### What can we add to the `Bingo` class to allow it to inherit the `play` method from the `Game` class?

Change the first line of `Bingo` to: `class Bingo < Game`

---

#### 9. What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.

The newly defined `play` method in the `Bingo` class would override the previously defined `play` method in the `Game` class. When a `Bingo` object called a `play` method, Ruby's lookup path would find the overriden `play` explicitly added to `Bingo` first and use it. The `play` method inherited from `Game` would not be used.

---

#### 10. What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.
* easier to understand
* more readable
* more scalable
* more secure
* easier to debug
* easier to maintain
* easier to collaborate / more efficient to work on
* more re-usable
* more options for consumers - easier to achieve price points (can easily add or leave out functionality as necessary)
