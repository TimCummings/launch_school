## More Stuff - Exercises

### Exercise 1
Write a program that checks if the sequence of characters "lab" exists in the following strings. If it does exist, print out the word.
* "laboratory"
* "experiment"
* "Pans Labyrinth"
* "elaborate"
* "polar bear"

#### Solution
``` ruby
def check_and_print(string)
  if string =~ /lab/
    puts string
  end
end

check_and_print("laboratory")
check_and_print("experiment")
check_and_print("Pans Labyrinth")
check_and_print("elaborate")
check_and_print("polar bear")
```

---
### Exercise 2
What will the following program print to the screen? What will it return?
``` ruby
def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }
```

#### Solution
This program does not print anything to the screen. It returns a `Proc` object.

---
### Exercise 3
What is exception handling and what problem does it solve?

#### Solution
Exception handling, when done properly, is the graceful handling of exceptions (errors) that would normally stop a program from executing once encountered. Exception handling manages errors, allowing a program to continue executing despite them.

---
### Exercise 4
Modify the code in exercise 2 to make the block execute properly.

#### Solution
``` ruby
def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
```

---
### Exercise 5
Why does the following code...
``` ruby
def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
```
Give us the following error when we run it?
```
block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError)
from test.rb:5:in `<main>'
```

#### Solution
This gives us an `ArgumentError` because the method, as it is written, expects a non-block argument but is given a block instead. To be used in this way, the first line of the method definition needs an `&` before `block`:
`def execute(&block)`
