
[comment]: # (complete_the_program-cats.md)

### Complete the Program - Cats - 5/22/2017

#### Consider the following program.

``` ruby
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
```

#### Update this code so that when you run it, you see the following output:

```
My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
```

---

### Solution:

``` ruby
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
```

---

### Further Exploration

#### An alternative approach to this problem would be to modify the `Pet` class to accept a `colors` parameter. If we did this, we wouldn't need to supply an `initialize` method for `Cat`.

#### Why would we be able to omit the `initialize` method? Would it be a good idea to modify `Pet` in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying `Pet`?


If we modified the `initialize` method in `Pet` to include a `@colors` instance variable, we could omit the `initialize` method for `Cat` because `Cat` would inherit the `initialize` method in `Pet`. Ruby, upon evaluating a new `Cat` object at creation, would look for an `initialize` method in `Cat`; upon not finding one, Ruby would move up the lookup path to `Pet` and try to use the `initialize` method in `Pet`; since the `initialize` method in `Pet` would have been modified to accommodate the `@colors` instance variable, we would not get an `ArgumentError`.

Without more information, it's difficult to say whether or not this would be a good idea. Since most pets do tend to have some sort of variety of coloration, this is probably not a wrong or bad solution, simply a different one with corresponding tradeoffs.

One possible tradeoff is that `@colors` implies more than one color, while some pets are only a single color. If we encountered enough negatives, we could simply remove the `@colors` functionality from both classes, encapsulate it in a module, and mix it in where appropriate.
