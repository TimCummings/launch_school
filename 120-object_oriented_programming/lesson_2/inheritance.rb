# inheritance.rb

# 1
class Dog
  def speak
    'Bark!'
  end

  def swim
    'Swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end



# 2
class Mammal
  def run
    "Running!"
  end

  def jump
    "Jumping!"
  end
end

class Dog < Mammal
  def speak
    'Bark!'
  end

  def fetch
    "Fetching!"
  end

  def swim
    "Swimming!"
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

class Cat < Mammal
  def speak
    "Meow!"
  end
end



# 3
  #            Mammal
  #            ------
  #            run
  #            jump
  #            ------
  #               |
  #         -------------
  #         |            |
  #        Dog          Cat
  #        -----        -----
  #        run          run
  #        jump         jump
  #        speak        speak
  #        fetch
  #        swim
  #        -----
  #          |
  #        Bulldog
  #        -------
  #        run
  #        jump
  #        speak
  #        fetch



# 4
# The method lookup path is the order of classes and modules by which Ruby searches for a method when one is called. This is important because it allows for inheritance and overriding - if the method lookup path were different, those would work different or might not even be possible.
# For example, in the code above, the method lookup path allows us to define appropriate `speak` methods for `Dog` and `Cat`, even though they inherit from `Mammal` which has no speak method; Ruby's method lookup path for searches within the class of the calling object for the appropriate method, before stepping up to the superclass (or modules if they are mixed in).
