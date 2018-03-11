
[comment]: # (students.md)

### Students - 5/27/2017

#### Students

Below we have 3 classes: `Student`, `Graduate`, and `Undergraduate`. Some details for these classes are missing. Make changes to the classes below so that the following requirements are fulfilled:

1. Graduate students have the option to use on-campus parking, while Undergraduate students do not.

2. Graduate and Undergraduate students have a name and year associated with them.

> Note, you can do this by adding or altering no more than 5 lines of code.

``` ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate
  def initialize(name, year, parking)
  end
end

class Undergraduate
  def initialize(name, year)
  end
end
```

---

### Solution:

``` ruby
class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
end

class Generic < Student
  def initialize
    super()
  end
end
```

---

### Further Exploration

#### There is one other "form" of the keyword `super`. We can call it as `super()`. This calls the superclass method of the same name as the calling method, but here no arguments are passed to the superclass method at all.

#### Can you think of a way to use `super()` in another Student related class?

In order to be able to use `super()`, the superclass would need an initialize method that has ability to not take any arguments. Trying to use `super()` with a subclass of `Student` results in an `ArgumentError: wrong number of arguments`, because `Student#initialize` expects two arguments.

In order to be able to use `super()`, we could define a superclass of `Student` (maybe some kind of generic student entry?) with an initialize method that either takes zero arguments or has default values for its arguments. Or we could modify `Student` to have default values for its arguments.
