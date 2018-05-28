
[comment]: # (notes_101.md)

# 101 - Programming Foundations (Ruby)

### Variables
There are five types of variables:
1. constant variables - indicated by all caps e.g. `VOWELS`
2. global variables - start with `$` e.g. `$foo`
3. class variables - start with `@@` e.g. `@@vowels`
4. instance variables - start with `@` e.g. `@cost`
5. local variables

### Variable Scope
Most of the time an inner scope can access variables initialized in an outer scope, but an outer scope cannot access variables initialized in an inner scope.

A new "inner" scope is created by a block with `{...}` or `do ... end`.

While `for` is used much like a block, it does __not__ create a new scope.

```ruby
a = 3
1.times do
  puts a # outputs 3: outer scope variable is accessible from inner scope
  a = 5
  b = 6
end

puts a
# outputs 5: a is accessible in its own outer scope, but the reassignment from inside the block is still in effect

puts b # NameError 'b' undefined: outer scope cannot access inner scope
```
Methods have their own scope and cannot access outer scopes (except constants.)

---
### Methods
__method:__ a procedure that allows the programmer to extract common code to one place

__parameter:__ a placeholder declared in a method definition that allows data outside the method's scope to be passed into the method as an argument

__argument:__ data passed into a method (via a parameter) at method invocation to be modified or used to return a specific result

```ruby
# method definition
def say(words) # here, words is a parameter
  puts words   # here, words is a method local variable
end

# method call/invocation; "hello" is an argument
say("hello")
```

Parameters can be assigned default values like so:
```ruby
def say(words="hello") # notice there are no spaces around the =
  puts words + '.'
end

say() # outputs "hello."
say('hi') # outputs 'hi.'
```

A method call that modifies the calling object is said to be a destructive method or a method that "mutates the caller". Since Ruby's object passing is pass by reference value, __it is important to know (or be able to quickly test) which methods mutate the caller and which do not__.
