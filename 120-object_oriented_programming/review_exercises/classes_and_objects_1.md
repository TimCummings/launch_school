
[comment]: # (classes_and_objects_1.md)

# Classes and Objects 1 - 5/15/2017

---

### 1. Find the Class

#### Update the following code so that, instead of printing the values, each statement prints the name of the class to which it belongs.

``` ruby
puts "Hello"
puts 5
puts [1, 2, 3]
```

``` ruby
puts "Hello".class
puts 5.class
puts [1, 2, 3].class
```

---

### 2. Create the Class

#### Create an empty class named `Cat`.
``` ruby
class Cat
end
```

---

### 3. Create the Object

#### Using the code from the previous exercise, create an instance of Cat and assign it to a variable named kitty.

``` ruby
class Cat
end

kitty = Cat.new
```

---

### 4. What Are You?

#### Using the code from the previous exercise, add an #initialize method that prints I'm a cat! when a new Cat object is initialized.

``` ruby
class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new
```

---

### 5. Hello, Sophie! (Part 1)

#### Using the code from the previous exercise, add a parameter to `#initialize` that provides a name for the `Cat` object. Use an instance variable to print a greeting with the provided name. (You can remove the code that displays `I'm a cat!`.)

``` ruby
class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
```

---

### 6. Hello, Sophie! (Part 2)

#### Using the code from the previous exercise, move the greeting from the #initialize method to an instance method named #greet that prints a greeting when invoked.

``` ruby
class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
```

---

### 7. Reader

#### Using the code from the previous exercise, add a getter method named `#name` and invoke it in place of `@name` in `#greet`.

``` ruby
class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
```

---

### 8. Writer

#### Using the code from the previous exercise, add a setter method named #name. Then, rename kitty to 'Luna' and invoke #greet again.

``` ruby
class Cat
  attr_reader :name
  attr_writer :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet
```

---

### 9. Accessor

#### Using the code from the previous exercise, replace the getter and setter methods using Ruby shorthand.

``` ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet
```

---

### 10. Walk the Cat

#### Using the following code, create a module named `Walkable` that contains a method named `#walk`. This method should print `Let's go for a walk!` when invoked. Include `Walkable` in `Cat` and invoke `#walk` on `kitty`.

``` ruby
module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk
```
