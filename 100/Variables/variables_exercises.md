## Variables - Exercises

### Exercise 1
Write a program called `name.rb` that asks the user to type in their name and then prints out a greeting message with their name included.

#### Solution
[Link to solution in separate file: name.rb](name.rb)

---
### Exercise 2
Write a program called `age.rb` that asks a user how old they are and then tells them how old they will be in 10, 20, 30, and 40 years. Below is the output for someone 20 years old:
```
# output of age.rb for someone 20 yrs old

How old are you?
In 10 years you will be:
30
In 20 years you will be:
40
In 30 years you will be:
50
In 40 years you will be:
60
```

#### Solution
[Link to solution in separate file: age.rb](age.rb)

---
### Exercise 3
Add another section onto `name.rb` that prints the name of the user 10 times. You must do this without explicitly writing the puts method 10 times in a row. Hint: you can use the `times` method to do something repeatedly.

### Solution
[Link to solution in separate file: name.rb](name.rb)

---
### Exercise 4
Modify `name.rb` again so that it first asks the user for their first name, saves it into a variable, and then does the same for the last name. Then outputs their full name all at once.

### Solution
[Link to solution in separate file: name.rb](name.rb)

---
### Exercise 5
Look at the following programs...
``` ruby
x = 0
3.times do
  x += 1
end
puts x
```

and

``` ruby
y = 0
3.times do
  y += 1
  x = y
end
puts x
```

What does `x` print to the screen in each case? Do they both give errors? Are the errors different? Why?

#### Solution
**5a**: `x` prints `3` to the screen. This program does not give any errors.

**5b**: `x` does not print to the screen. This program does give an error:
```
exercise5b.rb:6:in `<main>': undefined local variable or method `x' for main:Object (NameError)
```

This program generates an error and the first program does not because of variable declaration and scope. In the first program, `x` is declared outside of the do block, so it is usable both inside the `do` block and outside of the `do` block. In the second program, `x` is declared inside the `do` block and is therefore not accessible outside of the `do` block. Consequently, trying to `puts x` outside of the `do` block (where `x` was declared) results in the error above.

---
### Exercise 6
What does the following error message tell you?
```
NameError: undefined local variable or method `shoes' for main:Object
  from (irb):3
  from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'
```

#### Solution
The program is trying to use a variable or method named `shoes` that has not yet been defined within an accessible scope.
