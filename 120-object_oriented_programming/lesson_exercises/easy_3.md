
[comment]: # (easy_3.md)

# Easy 3 - 5/1/2017

---

#### 1. If we have this code:
``` ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
#### What happens in each of the following cases:

* #### case 1:
``` ruby
hello = Hello.new
hello.hi
```
> prints "Hello"

* #### case 2:
``` ruby
hello = Hello.new
hello.bye
```
> NoMethodError

* #### case 3:
``` ruby
hello = Hello.new
hello.greet
```
> ArgumentError: wrong number of arguments

* #### case 4:
``` ruby
hello = Hello.new
hello.greet("Goodbye")
```
> prints "Goodbye"

* #### case 5:
``` ruby
Hello.hi
```
> NoMethodError

---

#### 2. If we call `Hello.hi` we get an error message. How would you fix this?
``` ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    puts "Hello"
  end

  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

---

#### 3. When objects are created they are a separate realization of a particular class. Given the class below, how do we create two different instances of this class, both with separate names and ages?
``` ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

``` ruby
howard = AngryCat.new(7, 'Howard')
garfield = AngryCat.new(39 ,'Garfield')
```

---

#### 4. Given the class below, if we created a new instance of the class and then called `to_s` on that instance we would get something like `"#<Cat:0x007ff39b356d30>"`
``` ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```
#### How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (this is assuming that `"tabby"` is the `type` we passed in during initialization).

We would need to override the `to_s` method inside the `Cat` class:
``` ruby
def to_s
  "I am a #{@type} cat"
end
```

---

#### 5. If I have the following class:
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
#### What would happen if I called the methods like shown below?
``` ruby
tv = Television.new
tv.manufacturer
# NoMethodError; `manufacturer` is a class method
tv.model
# This would "work", but not do anything, since the method is empty

Television.manufacturer
# This would "work", but not do anything, since the method is empty
Television.model
# NoMethodError; `model` is an instance method
```

---

#### 6. If we have a class such as the one below:
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
#### In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?
``` ruby
def make_one_year_older
  @age += 1
end
```

---

#### 7. What is used in this class but doesn't add any value?
``` ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end
```
The class method `information` does not add any value - the states described do not necessarily match what an instance of `Light` may contain.

**Correct answer:** The `return` in the `information` method.
