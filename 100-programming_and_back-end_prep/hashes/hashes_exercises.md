## Hashes - Exercises

### Exercise 1
Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in `select` method to gather only immediate family members' names into a new array.
``` ruby
# Given
family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
```

#### Solution
``` ruby
array = family.select { |k, v| k == :brothers || k == :sisters }
array = array.values.flatten
```

---
### Exercise 2
Look at Ruby's `merge` method. Notice that it has two versions. What is the difference between `merge` and `merge!`? Write a program that uses both and illustrate the differences.

#### Solution
`merge` is non-destructive; it combines two hashes into a new hash, which it returns, leaving the original two hashes un-changed (it does not mutate the caller.)

`merge!` is destructive; it combines two hashes by adding the "passed" hash to the "calling" hash, which it returns. The "calling" hash is changed (this **does** mutate the caller.)

``` ruby
puts "Demonstration of the difference between hash's merge and merge! methods:"

hash1 = { first_name: "Abraham", last_name: "Lincoln", height: "6ft 4in" }
hash2 = { manufacturer: "Tesla", model: "P90D", year: "2015"}

puts "I have two hashes:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge returns: #{hash1.merge(hash2)}"
puts "My two hashes are still:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge! returns: #{hash1.merge!(hash2)}"
puts "My two hashes are now:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge is non-destructive: it did not change my two hashes."
puts "merge! is destructive: it changed Hash1."
```

---
### Exercise 3
Using some of Ruby's built-in `Hash` methods, write a program that loops through a hash and prints all of the keys. Then write a program that does the same thing except printing the values. Finally, write a program that prints both.

#### Solution
``` ruby
dog = { name: "Spot", breed: "Dalmation", spots: 37, weight: 55}

puts dog.keys
puts dog.values
dog.each { |k, v| puts "#{k}: #{v}"}
```

---
### Exercise 4
Given the following expression, how would you access the name of the person?
``` ruby
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
```

#### Solution
`person[:name]`

---
### Exercise 5
What method could you use to find out if a `Hash` contains a specific value in it? Write a program to demonstrate this use.

#### Solution
To find out if a hash contains a specific value, I would use the value? method.
``` ruby
president = { first_name: "Abraham", last_name: "Lincoln", height: "6ft 4in" }

puts "Does this hash contain 'Lincoln'?"
puts president.value?("Lincoln")

puts "Does this hash contain 3.14?"
puts president.value?(3.14)
```

---
### Exercise 6
Given the array...
``` ruby
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
```
Write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order. Your output should look something like this:
```
["demo", "dome", "mode"]
["neon", "none"]
(etc)
```

#### Solution
[exercise6.rb](exercise6.rb)

---
### Exercise 7
Given the following code...
``` ruby
x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}
```
What's the difference between the two hashes that were created?

#### Solution
The key in `my_hash` is the symbol x (`:x`)
The key in `my_hash2` is the variable `x`, which is the string `"hi there"`

---
### Exercise 8
If you see this error, what do you suspect is the most likely problem?
```
NoMethodError: undefined method `keys' for Array
```
A. We're missing keys in an array variable.

B. There is no method called `keys` for Array objects.

C. `keys` is an Array object, but it hasn't been defined yet.

D. There's an array of strings, and we're trying to get the string `keys` out of the array, but it doesn't exist.

#### Solution
B. There is no method called `keys` for Array objects.
