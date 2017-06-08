
[comment]: # (fix_the_program-books_pt1.md)

# Fix the Program - Books (Part 1) - 5/22/2017

#### Complete this program so that it produces the expected output:

``` ruby
class Book
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

#### Expected output:

```
The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
```

---

### Solution:

``` ruby
class Book
  attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

---

### Further Exploration

#### What are the differences between `attr_reader`, `attr_writer`, and `attr_accessor`? Why did we use `attr_reader` instead of one of the other two? Would it be okay to use one of the others? Why or why not?

For the specified instance variable, `attr_reader` creates a getter method, `attr_writer` creates a setter method, and `attr_accessor` creates both a getter and a setter method.

We use `attr_reader` here because the provided code only requires getter functionality: it is only trying to access the instance variables after they are set in the class's `initialize` method.

We could not use just `attr_writer` here because there would be no way to access the instance variables (which the provided code is trying to do.) We could use `attr_accessor` and it would work, but it would also provide a getter method that would not be used in the provided code.


#### Instead of attr_reader, suppose you had added the following methods to this class:

``` ruby
def title
  @title
end

def author
  @author
end
```

#### Would this change the behavior of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?

These two methods, in place of `attr_reader`, would not change the class's behavior - these setter methods are exactly what Ruby creates behind the scenes when it evaluates `attr_reader`.

There are not currently advantages to manually typing out full getter methods instead of `attr_reader`, but there are other situations in which manually defining getter methods would make lots of sense, in order to provide slightly different functionality, e.g. formatting an instance variable in a certain way or protecting sensitive information the default getter method would expose (such as hiding most of the digits in a credit card number or a social security number.)
