
[comment]: # (fix_the_program-books_pt2.md)

# Fix the Program - Books (Part 2) - 5/22/2017

#### Complete this program so that it produces the expected output:

``` ruby
class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
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
  attr_accessor :author, :title

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
```

---

### Further Exploration

#### What do you think of this way of creating and initializing `Book` objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?

In most cases I have encountered, it is better to to create and initialize in one step via a class's `initialize` method. This simplifies the code's readability and maintainability, and helps protect instance variables from unnecessary external manipulation.

But there are some cases where it could make sense to create and initialize separately, so it is good to know how to provide such functionality. For example, there may be some information (instance variables) that are unknown at the time an object is instantiated; there may also be instance variables that need to change over the course of an object's lifetime.
