## Flow Control - Exercises

## Exercise 1
Write down whether the following expressions return `true` or `false`. Then type the expressions into IRB to see the results.
```
1. (32 * 4) >= 129
2. false != !true
3. true == 4
4. false == (847 == '874')
5. (!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false
```
1. `(32 * 4) >= 129`  
false - correct

2. `false != !true`  
false - correct

3. `true == 4`  
true - wrong

4. `false == (847 == '874')`  
true - correct

5. `(!true || (!(100 / 5) == 20) || ((328 / 4) == 82)) || false`  
true - correct

---
### Exercise 2
Write a method that takes a string as argument. The method should return the all-caps version of the string, only if the string is longer than 10 characters. Example: change "hello world" to "HELLO WORLD". (Hint: Ruby's String class has a few methods that would be helpful. Check the Ruby Docs!)

``` ruby
def upper(a_string)
  if a_string.length > 10
    a_string.upcase
  end
end

puts "Please enter a string:"
puts upper gets.chomp
```

---
### Exercise 3
Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

``` ruby
puts "Please enter a number between 0 and 100:"

number = gets.chomp.to_i

if((number >= 0) && (number <= 50))
  puts "The number is between 0 and 50."
elsif((number >= 51) && (number <= 100))
  puts "The number is between 51 and 100."
elsif number > 100
  puts "The number is more than 100."
else
  puts "Out of bounds."
end
```

---
### Exercise 4
What will each block of code below print to the screen? Write your answer on a piece of paper or in a text editor and then run each block of code to see if you were correct.

```
1. '4' == 4 ? puts("TRUE") : puts("FALSE")

2. x = 2
   if ((x * 3) / 2) == (4 + 4 - x - 3)
     puts "Did you get it right?"
   else
     puts "Did you?"
   end

3. y = 9
   x = 10
   if (x + 1) <= (y)
     puts "Alright."
   elsif (x + 1) >= (y)
     puts "Alright now!"
   elsif (y + 1) == x
     puts "ALRIGHT NOW!"
   else
     puts "Alrighty!"
   end
```

1. "FALSE"                  - correct
2. "Did you get it right?"  - correct
3. "Alright now!"           - correct


---
### Exercise 5
Rewrite your program from exercise 3 using a case statement. Wrap the statement from exercise 3 in a method and wrap this new case statement in a method. Make sure they both still work.

##### Exercise 3 in a method:
``` ruby
def range
  puts "Please enter a number between 0 and 100:"

  number = gets.chomp.to_i

  if((number >= 0) && (number <= 50))
    puts "The number is between 0 and 50."
  elsif((number >= 51) && (number <= 100))
    puts "The number is between 51 and 100."
  elsif number > 100
    puts "The number is more than 100."
  else
    puts "Out of bounds."
  end
end
```

##### Case statement version:
``` ruby
def range_case
  puts "Please enter a number between 0 and 100:"
  number = gets.chomp.to_i
end

def compare(number)
  case
    when((number >= 0) && (number <= 50))
      puts "#{number} is between 0 and 50."
    when((number >= 51) && (number <= 100))
      puts "#{number} is between 51 and 100."
    when number > 100
      puts "#{number} is more than 100."
    else
      puts "#{number} is out of bounds."
  end
end
```


---
### Exercise 6
When you run the following code...
``` ruby
def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
end

equal_to_four(5)
```

You get the following error message...
```
test_code.rb:96: syntax error, unexpected end-of-input, expecting keyword_end
```

Why do you get this error message and how can you fix it?

#### Solution
This error is generated because the code is missing an `end`: there is one `end` for the `if` statement, but the `def` also needs an `end` before it is called. This can be fixed with:

``` ruby
def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
  end
end # This second "end" resolves the error

equal_to_four(5)
```
