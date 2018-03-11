
[comment]: # (medium_1.md)

# Medium 1 - 9/6/2017

---
## 1. Listening Device
Below we have a listening device. It lets us record something that is said and store it for later use. In general, this is how the device should be used:

Listen for something, and if anything is said, record it for later use. If nothing is said, then do not record anything.
``` ruby
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end
end
```

Anything that is said is retrieved by this listening device via a block. If nothing is said, then no block will be passed in. The listening device can also output what was recently recorded using a Device#play method.
``` ruby
listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
```
Finish the above program so that the specifications listed above are met.

### Solution
``` ruby
class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    record(yield) if block_given?
  end

  def play
    puts @recordings
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"
```

#### Refactored based on provided solution
`play` should only output the most recent recording, not all recordings:
``` ruby
def play
  puts @recordings.last
end
```

---
## 2. Text Analyzer - Sandwich Code
Fill out the rest of the Ruby code below so that print output like that shown in "Sample Output." You should read the text from a simple text file that you provide. (We also supply some example text below, but try the program with your text as well.)

Read the text file in the `#process` method and pass the text to the block provided in each call. Everything you need to work on is either part of the `#process` method or part of the blocks. You need no other additions or changes.

The text you use does not have to produce the same numbers as the sample output but should have the indicated format.
``` ruby
class TextAnalyzer
  def process
    # your implementation
  end
end

analyzer = TextAnalyzer.new
analyzer.process { puts # your implementation }
analyzer.process { puts # your implementation }
analyzer.process { puts # your implementation }
```
Sample Output:
```
3 paragraphs
15 lines
126 words
```

### Solution
``` ruby
class TextAnalyzer
  def process
    text = File.open('sample_text.txt')
    yield text.read
    text.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.scan(/\n{2,}/).size + 1} paragraphs" }
analyzer.process { |text| puts "#{text.scan(/\n/).size} lines" }
analyzer.process { |text| puts "#{text.split.size} words" }
end
```

---
## 3. Passing Parameters Part 1
Modify the method below so that the display/output of `items` is moved to a block, and its implementation is left up to the user of the `gather` method.
``` ruby
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  puts "#{items.join(', ')}"
  puts "Let's start gathering food."
end
```

### Solution
``` ruby
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Let's start gathering food."
end

gather(items) { |food| puts food.join(', ') }
```

---
## 4. Passing Parameters Part 2
Ruby gives us a lot of flexibility when assigning arrays to variables. If we want to assign the entire array to a single variable, we can do that:
``` ruby
birds = %w(raven finch hawk eagle)
p birds # => ['raven','finch','hawk','eagle']
```
If we want to assign every element to a separate variable, we can do that too:
``` ruby
raven, finch, hawk, eagle = %w(raven finch hawk eagle)
p raven # => 'raven'
p finch # => 'finch'
p hawk # => 'hawk'
p eagle # => 'eagle'
```
Suppose we want to organize our array contents into groups, where variables represent category names. Can we do that without extracting items directly from the array based on their indices?

We can use the splat operator() to do something like this:
``` ruby
raven, finch, *raptors = %w(raven finch hawk eagle)
p raven # => 'raven'
p finch # => 'finch'
p raptors  # => ['hawk','eagle']
```
Based on the examples shown above, write a method that takes an array as an argument. The method should yield the contents of the array to a block, which should assign your block variables in such a way that it ignores the first two elements, and groups all remaining elements as a raptors array.

### Solution
``` ruby
birds = %w[dove pigeon falcon hawk owl]

def ornithologize(birds)
  yield birds
end

ornithologize(birds) do |_, _, *raptors|
  puts raptors
end
```

---
## 5. Passing Parameters 3
Given this code:
``` ruby
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end
```
Fill out the following method calls for `gather` so that they produce the corresponding output shown in numbers 1-4 listed below:

1)
``` ruby
gather(items) do | , |
  puts
  puts
end
```
```
Let's start gathering food.
apples, corn, cabbage
wheat
We've finished gathering!
```

2)
``` ruby
gather(items) do | , , |
  puts
  puts
  puts
end
```
```
Let's start gathering food.
apples
corn, cabbage
wheat
We've finished gathering!
```

3)
``` ruby
gather(items) do | , |
  puts
  puts
end
```
```
Let's start gathering food.
apples
corn, cabbage, wheat
We've finished gathering!
```

4)
``` ruby
gather(items) do | , , , |
  puts
end
```
```
Let's start gathering food.
apples, corn, cabbage, and wheat
We've finished gathering!
```

### Solutions
1)
``` ruby
gather(items) do |*non_carbs, carb|
  puts non_carbs.join(', ')
  puts carb
end
```

2)
``` ruby
gather(items) do |fruit, *vegetables, carb|
  puts fruit
  puts vegetables.join(', ')
  puts carb
end
```

3)
``` ruby
gather(items) do |fruit, *not_fruit|
  puts fruit
  puts not_fruit.join(', ')
end
```

4)
``` ruby
gather(items) do | fruit, veg1, veg2, carb|
  puts "#{fruit}, #{veg1}, #{veg2}, and #{carb}"
end
```

---
## 6. Exploring Procs, Lambdas, and Blocks: Definition and Arity

For this exercise, we'll be learning and practicing our knowledge of the arity of lambdas, procs, and implicit blocks. Two groups of code also deal with the definition of a `Proc` and a `Lambda`, and the differences between the two. Run each group of code below: For your answer to this exercise, write down your observations for each group of code. After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.
``` ruby
# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}" }
my_second_lambda = -> (thing) { puts "This is a #{thing}" }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}" }

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}
```

### Solution

#### Group 1
This group of code displays instantiating and calling a `Proc` object, which behaves like I would expect most Ruby objects to behave: it is a member of the `Proc` class; it gets an `object_id` like other Ruby objects; its `to_s` method displays its class and `object_id`.

Based on just this code, `Proc`s appear to behave the same as a block that has been assigned to a variable:
* They can be evaluated by calling `#call` on the `Proc` object.
* They will evaluate without error when no argument is provided for a defined "`Proc` parameter", e.g. `thing`: `Proc`s have lenient arity, like blocks.
* If an argument is provided for a `Proc` parameter, it will be evaluated inside the `Proc` as expected.

#### Group 2
This group of code displays some new behavior:
* There is no `Lambda` class as I had assumed before seeing lambdas in action: "lambdas" in Ruby are types of `Proc` objects.
* There are at least two forms of syntax for instantiating a `Proc`: one is identical to a block or `Proc`, but one is new and reminiscent of the older-style "hash-rocket" (`=>`), but with a hyphen instead of an equals sign (`->`).
* There is at least some differentiation between a lambda and a `Proc`, as the `to_s` method specifically tells us by appending a `(lambda)` on the end of the expected `class:object_id_encoding` format we previously saw for `Proc` objects.
* Lambdas seem to behave the same as `Proc`s when arguments are provided for defined parameters (lambda parameters? `Proc` parameters?)
* However, lambdas raise `ArgumentError`s when arguments are not provided for defined parameters: lambdas have more strict arity than `Proc`s and blocks.

#### Group 3
This group of code shows the arity of a method taking an implicit block argument compared to the arity of a block taking a block argument: implicit blocks can be yielded to without error even if arguments are not provided for all block parameters. But a method attempting to yield to an implicit block when one has not been provided will raise a `LocalJumpError`.  
This group of code also shows that block parameters with no corresponding arguments will evaluate to `nil` inside the block instead of raising argument errors. Yielding to a block will not automatically pass arguments into the block; arguments must be provided to `yield` to be passed to an implicit block.

#### Group 4
This group of code shows:
* How to provide arguments to `yield` so that they are passed into an implicit block via a block parameter.
* That we can pass the wrong number of arguments to a block without error: the provided arguments will be evaluated inside the block as expected, while block parameters with no argument will evaluate to `nil` as seen in Group 3.
* Despite the lenient arity of blocks, even though block parameters with no arguments evaluate to `nil` instead of raising an error, attempting to call an undefined method or variable inside a block will still raise a `NameError`.

#### Summary Statement
##### Blocks
* Blocks are un-named (un-instantiated) chunks of code that can be passed into methods either explicitly or implicitly. Only one block can be passed to a method at a time.
* Blocks can be evaluated by yielding to them, or, if a block is passed explicitly, it can also be called.
* Blocks have lenient arity:
  - Blocks will not raise `ArgumentError`s if the incorrect number of arguments is passed to the block.
  - Block parameters for which no matching argument is passed will evaluate to `nil` inside the block.
  - Attempting to call uninitialized methods or variables inside blocks will still raise a `NameError`.

##### Procs
* Procs are essentially blocks that have been instantiated as `Proc` objects.
  - Since they are named/instantiated, they can't be passed implicitly or yielded to, but they can still be passed explicitly and called.
  - As instantiated objects, more than one `Proc` can be passed to a method at the same time.
* Procs have the same arity as blocks:
  - Procs will not raise `ArgumentError`s if the incorrect number of arguments is passed to the `Proc`.
  - `Proc` parameters for which no matching argument is passed will evaluate to `nil`.
  - Attempting to call uninitialized methods or variables inside `Procs` will still raise a `NameError`.

##### Lambdas
* There is no `Lambda` class in Ruby.
* Lambdas are special types of `Proc` objects, and their `to_s` method will show this by appending a "(lambda)" after the `object_id` encoding.
* Lambdas can be instantiated similarly to procs with `= lambda {block}` or through a unique '= -> (args) {block_body}' syntax.
* Lambda arity is different than block or `Proc` arity - it is more strict:
  - Lambdas will raise `ArgumentError`s if the incorrect number of arguments is passed.

---
## 7. Exploring Procs, Lambdas, and Blocks: Returning

For this exercise, we'll be learning and practicing our knowledge of returning from lambdas, procs, and implicit blocks. Run each group of code below: For your answer to this exercise, write down your observations for each group of code. After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.

``` ruby
# Group 1
def check_return_with_proc
  my_proc = proc { return }
  my_proc.call
  puts "This will never output to screen."
end

check_return_with_proc

# Group 2
my_proc = proc { return }

def check_return_with_proc_2(my_proc)
  my_proc.call
end

check_return_with_proc_2(my_proc)

# Group 3
def check_return_with_lambda
  my_lambda = lambda { return }
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda

# Group 4
my_lambda = lambda { return }
def check_return_with_lambda(my_lambda)
  my_lambda.call
  puts "This will be output to screen."
end

check_return_with_lambda(my_lambda)

# Group 5
def block_method_3
  yield
end

block_method_3 { return }
```

### Solution

#### Group 1
Procs seem to function similarly to blocks in terms of their "return scope": a `return` within a `Proc` will not just exit the scope of the `Proc` but will attempt to exit the scope from which the `Proc` was ~~called~~ initialized.

#### Group 2
The statement from Group 1 needs to be corrected: a `return` within a `Proc` will attempt to exit the scope containing the `Proc`, but that scope is based on where the `Proc` is initialized, not where the `Proc` is called.

#### Group 3
Lambdas act differently than blocks or Procs in terms of their "return scope": a `return` within a lambda will just exit the scope of the lambda, not any other scope containing the lambda.

#### Group 4
The observation from Group 3 holds true: a `return` within a lambda exits the scope of the lambda, not any outer scope.

#### Group 5
A `return` within a block attempts to exit the scope in which the block is initialized. Even when provided as an implicit argument to a method, the block is defined outside the scope of the method and a `return` will not attempt to exit the method but the scope in which the method is called.

#### Summary Statement
Implicit blocks and procs behave the same in terms of returning: a `return` within either one will attempt to exit from the scope in which the block or proc is initialized, not necessarily the scope where they are called.

A lambda behaves differently by establishing its own "return scope", causing a `return` within a lambda to simply exit the lambda.

---
## 8. Method to Proc

In our Ruby course content on blocks, we learn about "symbol to proc" and how it works. To review briefly, consider this code:
``` ruby
comparator = proc { |a, b| b <=> a }
```
and the `Array#sort` method, which expects a block argument to express how the Array will be sorted. If we want to use `comparator` to sort the `Array`, we have a problem: it is a proc, not a block. The following code:
``` ruby
array.sort(comparator)
```
fails with an ArgumentError. To get around this, we can use the proc to block operator `&` to convert `comparator` to a block:
``` ruby
array.sort(&comparator)
```
This now works as expected, and we sort the `Array` in reverse order.

A lone `&` applied to an object causes ruby to try to convert the object to a block. If that object is a proc, the conversion happens automagically, just as shown above. If the object is not a proc, then `&` attempts to call the `#to_proc` method on the object first. Used with symbols, e.g., `&:to_s`, Ruby creates a proc that calls the `#to_s` method on a passed object, and then converts that proc to a block. This is the "symbol to proc" operation (though perhaps it should be called "symbol to block").

Did you know that you can perform a similar trick with methods? You can apply the `&` operator to an object that contains a `Method`; in doing so, Ruby calls `Method#to_proc`.

Using this information, together with the course page linked above, fill in the missing part of the following code so we can convert an array of integers to base 8. Use the comments for help in determining where to make your modifications, and make sure to review the "Approach/Algorithm" section for this exercise; it should prove useful.
``` ruby
def convert_to_base_8(n)
  n.method_name.method_name # replace these two method calls
end

# The correct type of argument must be used below
base8_proc = method(argument).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
[8,10,12,14,16,33].map(&a_proc)
```
The expected return value of map on this number array should be:
```
[10, 12, 14, 16, 20, 41]
```

### Solution
``` ruby
def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8).to_proc

[8,10,12,14,16,33].map(&base8_proc)
```

---
## 9. Internal vs External Iterators

So far, we've used iterators often. You've seen the use of `#each` and `#map` used on various data structures, such as Arrays and Hashes. These methods make writing certain code a bit easier, at least when compared to a `while` or `for` loop. Yet, what we've seen thus far is only part of what is available.

Whenever we use `map` or `each` on something like an Array, we're using something called "Internal Iteration". It's called that because the process and implementation of that iteration is hidden from us, and the process that allows us to progress through a collection is part of that hidden implementation.

There's also "External Iteration". This is iteration that takes place at the behest of the user. Ruby gives us the option to use this type of iteration with the `Enumerator` class. For this exercise, lets take a bit of a tour of the capabilities of `Enumerator`. While we do that, let's make something interesting with it.

In this exercise, your task is to create a new `Enumerator` object. When creating a new `Enumerator`, you may define what values are iterated upon. We'll want to create an `Enumerator` that can iterate over an infinite list of factorials. Once you make this new `Enumerator`, test it out by printing out the first 7 factorial values, starting with zero factorial.

More specifically, print the first 7 factorials by using an "External Iterator". Once you have done so, reset your Enumerator. Finally, reprint those same 7 factorials using your Enumerator object as an "Internal Iterator".

You can find almost everything you need for this exercise in the [documentation](https://ruby-doc.org/core-2.2.0/Enumerator.html) for `Enumerator`. In particular, check out the `::new` method; it should prove a good starting point for this exercise. Some further details about internal vs external iterators are mentioned at the start of that documentation, so make sure to read that section. Keep in mind that that section can be a bit dense; if you don't understand everything about it, that's ok.

The [wikipedia page on factorials](https://en.wikipedia.org/wiki/Factorial) may also be of some use.

Two final hints:

You'll only need 3 `Enumerator` methods to complete this exercise.
An `Enumerator` also implements the `Enumerable` module. Keep this in mind, as it may make certain parts of this exercise easier to write.

### Solution
``` ruby
facts = Enumerator.new do |fact|
  num = 0
  accumulator = 1

  loop do
    fact << accumulator
    num += 1
    accumulator *= num
  end
end

7.times { puts facts.next }

facts.rewind

puts facts.take(7)
```

---
## 10. Bubble Sort with Blocks

In an earlier exercise, you were asked to construct a `#bubble_sort!` method that used the bubble sort algorithm to sort Arrays in place. Our solution was this:
``` ruby
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end
```
The problem with this solution is that it doesn't give you any freedom in terms of the criteria used for the sort. For example, perhaps you want to sort the Array in reverse order from usual, or perhaps you want to sort a list of names in a case-insensitive manner.

Your task in this assignment is to modify `#bubble_sort!` so it takes an optional block that determines which of two consecutive blocks will appear first in the results.

If you still have a copy of your `#bubble_sort!` method, you may use that method as the basis for this exercise. Otherwise, you can use the above solution.

Examples:
``` ruby
array = [5, 3]
bubble_sort!(array)
array == [3, 5]

array = [5, 3, 7]
bubble_sort!(array) { |first, second| first >= second }
array == [7, 5, 3]

array = [6, 2, 7, 1, 4]
bubble_sort!(array)
array == [1, 2, 4, 6, 7]

array = [6, 12, 27, 22, 14]
bubble_sort!(array) { |first, second| (first % 7) <= (second % 7) }
array == [14, 22, 12, 6, 27]

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array)
array == %w(Kim Pete Tyler alice bonnie rachel sue)

array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |first, second| first.downcase <= second.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
```

### Solution
``` ruby
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield array[index - 1], array[index]
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end
```

#### Further Exploration

Modify your solution so it only passes one element to the block at a time; the block should perform some sort of transformation to the argument, and `#bubble_sort!` itself should just use `<=` to compare two values. In other words, you should be able to call `#bubble_sort!` like this:
``` ruby
array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort!(array) { |value| value.downcase }
array == %w(alice bonnie Kim Pete rachel sue Tyler)
```

#### Solution
``` ruby
def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1]) <= yield(array[index])
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end
```
