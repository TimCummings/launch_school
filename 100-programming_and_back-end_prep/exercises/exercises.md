## Exercises

### Exercise 1
Use the `each` method of `Array` to iterate over `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`, and print out each value.

#### Solution
``` ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

array.each { |x| puts x }
```

---
### Exercise 2
Same as above, but only print out values greater than 5.

#### Solution
``` ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

array.each do |x|
  if x > 5
    puts x
  end
end
```

---
#### Exercise 3
Now, using the same array from #2, use the `select` method to extract all odd numbers into a new array.

#### Solution
``` ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

odds = array.select { |x| x.odd? }
```

---
### Exercise 4
Append "11" to the end of the original array. Prepend "0" to the beginning.

#### Solution
``` ruby
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

array.push(11)

array.unshift(0)
```

---
### Exercise 5
Get rid of "11". And append a "3".

#### Solution
``` ruby
array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

array.pop

array.push(3)
```

---
### Exercise 6
Get rid of duplicates without specifically removing any one value.

#### Solution
``` ruby
array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 3]

array.uniq!
```

---
### Exercise 7
What's the major difference between an `Array` and a `Hash`?

#### Solution
There are two major differences between arrays and hashes: arrays are ordered while hashes are unordered; arrays are collections of single objects while hashes are collections of key, value pairs.

---
### Exercise 8
Create a `Hash` using both Ruby syntax styles.

#### Solution
``` ruby
syntax1 = {
  "component" => "analog",
  "composite" => "analog",
  "HDMI" => "digital",
  "TOSLINK" => "digital"
}

syntax2 = {
  component: "analog",
  composite: "analog",
  HDMI: "digital",
  TOSLINK: "digital"
}
```

---
### Exercise 9
Suppose you have a hash `h = {a:1, b:2, c:3, d:4}`
```
1. Get the value of key `:b`.

2. Add to this hash the key:value pair `{e:5}`

3. Remove all key:value pairs whose value is less than 3.5
```

#### Solution
``` ruby
h = {a:1, b:2, c:3, d:4}

# 1 Get the value of key `:b`.
h[:b]

# 2. Add to this hash the key:value pair `{e:5}`
h[:e] = 5

# 3. Remove all key:value pairs whose value is less than 3.5
h.select! { |key, value| value > 3.5 }
```

---
### Exercise 10
Can hash values be arrays? Can you have an array of hashes? (give examples)

#### Solution
Yes, hash values can be arrays:
``` ruby
harray = {
  key1: [1, 2, 3],
  key2: ["a", "b", "c"]
}
```

Yes, you can have an array of hashes:
``` ruby
arrash = [ {key1: 'val1', key2: 'val2'},
           {key1: 'val1', key2: 'val2'} ]
```

---
### Exercise 11
Look at several Rails/Ruby online API sources and say which one you like best and why.

#### Solution
I currently like the [Ruby on Rails API](http://api.rubyonrails.org) the best, because of its layout. I like the series of dropdown menus on the left side of the page that allow quick/easy navigation to other sections without having to user browser navigation or multiple windows/tabs to quickly access related information.

---
### Exercise 12
Given the following data structures. Write a program that moves the information from the array into the empty hash that applies to the correct person.
``` ruby
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
```

#### Solution
``` ruby
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"]["email"] = contact_data[0][0]
contacts["Joe Smith"]["address"] = contact_data[0][1]
contacts["Joe Smith"]["phone"] = contact_data[0][2]

contacts["Sally Johnson"]["email"] = contact_data[1][0]
contacts["Sally Johnson"]["address"] = contact_data[1][1]
contacts["Sally Johnson"]["phone"] = contact_data[1][2]
```

---
### Exercise 13
Using the hash you created from the previous exercise, demonstrate how you would access Joe's email and Sally's phone number?

#### Solution
``` ruby
contacts["Joe Smith"]["email"]
contacts["Sally Johnson"]["phone"]
```

---
### Exercise 14
In exercise 12, we manually set the contacts hash values one by one. Now, programmatically loop or iterate over the `contacts` hash from exercise 12, and populate the associated data from the `contact_data` array. Hint: you will probably need to iterate over (`[:email, :address, :phone]`), and some helpful methods might be the Array `shift` and `first` methods.

Note that this exercise is only concerned with dealing with 1 entry in the `contacts` hash, like this:
``` ruby
contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
```
As a bonus, see if you can figure out how to make it work with multiple entries in the `contacts` hash.

#### Solution
``` ruby
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

fields = [:email, :address, :phone]

contacts.each do |name, data|
  fields.each do |key|
    contacts[name][key] = contact_data.first.shift
  end
  contact_data.shift
end
```

---
### Exercise 15
Use Ruby's Array method `delete_if` and String method `start_with?` to delete all of the words that begin with an "s" in the following array.
``` ruby
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
```
Then recreate the `arr` and get rid of all of the words that start with "s" or starts with "w".

#### Solution
``` ruby
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |word| word.start_with?("s") }

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
arr.delete_if { |word| word.start_with?("s", "w") }
```

---
### Exercise 16
Take the following array:
``` ruby
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
```
and turn it into a new array that consists of strings containing one word. (ex. `["white snow", etc...]` → `["white", "snow", etc...]`. Look into using Array's `map` and `flatten` methods, as well as String's `split` method.

#### Solution
``` ruby
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

new_a = a.map { |string| string.split }
new_a.flatten
```

---
### Exercise 17
What will the following program output?
``` ruby
hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end
```

#### Solution
This program outputs: `These hashes are the same!`
