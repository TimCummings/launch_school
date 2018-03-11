
[comment]: # (easy_1.md)

# Easy 1 - 8/25/2017

---
## 1. Enumerable Class Creation
Assume we have a `Tree` class that implements a binary tree.
``` ruby
class Tree
  ...
end
```
A binary tree is just one of many forms of collections, such as Arrays, Hashes, Stacks, Sets, and more. All of these collection classes include the `Enumerable` module, which means they have access to an `each` method, as well as many other iterative methods such as `map`, `reduce`, `select`, and more.

For this exercise, modify the `Tree` class to support the methods of `Enumerable`. You do not have to actually implement any methods -- just show the methods that you must provide.

### Solution
``` ruby
class Tree
  include Enumerable

  def each
    ...
  end

  # required to use #max, #min, and #sort
  def <=>
    ...
  end
end
```

---
## 2. Optional Blocks
Write a method that takes an optional block. If the block is specified, the method should execute it, and return the value returned by the block. If no block is specified, the method should simply return the String 'Does not compute.'.

Examples:
``` ruby
compute { 5 + 3 } == 8
compute { 'a' + 'b' } == 'ab'
compute == 'Does not compute.'
```

### Solution
``` ruby
def compute
  block_given? ? yield : 'Does not compute.'
end
```

### Further Exploration
Modify the `compute` method so it takes a single argument and yields that argument to the block. Provide at least 3 examples of calling this new version of `compute`, including a no-block call.

### Solution
``` ruby
def compute(arg)
  block_given? ? yield(arg) : 'Does not compute.'
end

compute('Tim') { |name| "Hi, #{name}!" }
compute(7) { |root| root ** 2 }
compute(Time::now)
```

---
## 3. Find Missing Numbers
Write a method that takes a sorted array of integers as an argument, and returns an array that includes all of the missing integers (in order) between the first and last elements of the argument.

Examples:
``` ruby
missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
missing([1, 2, 3, 4]) == []
missing([1, 5]) == [2, 3, 4]
missing([6]) == []
```

### Solution
``` ruby
def missing(array)
  result = (array.first..array.last).to_a
  result.delete_if { |num| array.include?(num) }
  result
end
```

---
## 4. Divisors
Write a method that returns a list of all of the divisors of the positive integer passed in as an argument. The return value can be in any sequence you wish.

Examples
``` ruby
divisors(1) == [1]
divisors(7) == [1, 7]
divisors(12) == [1, 2, 3, 4, 6, 12]
divisors(98) == [1, 2, 7, 14, 49, 98]
divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute
```

### Solution
``` ruby
def divisors(int)
  result = [1]
  2.upto(int) { |x| result << x if int % x == 0 }
  result
end
```

### Further Exploration
You may have noticed that the final example took a few seconds, maybe even a minute or more, to complete. This shouldn't be a surprise as we aren't doing anything to optimize the algorithm. It's what is commonly called a brute force algorithm where you try every possible solution; these are easy to write, but they don't always produce fast results. They aren't necessarily bad solutions -- it depends on your needs -- but the speed of brute force algorithms should always be examined.

How fast can you make your solution go? How big of a number can you quickly reduce to its divisors? Can you make `divisors(999962000357)` return almost instantly? (The divisors are [1, 999979, 999983, 999962000357].) Hint: half of the divisors gives you the other half.

### Solution
``` ruby
def divisors(int)
  results = []
  max_divisor = Math.sqrt(int).to_i

  1.upto(max_divisor) do |x|
    if int % x == 0
      results << x
      results << int / x
    end
  end

  results.uniq.sort
end
```

---
## 5. Encrypted Pioneers
The following list contains the names of individuals who are pioneers in the field of computing or that have had a significant influence on the field. The names are in an encrypted form, though, using a simple (and incredibly weak) form of encryption called [Rot13](https://en.wikipedia.org/wiki/ROT13).
```
Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unvog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu
```
Write a program that deciphers and prints each of these names.

### Solution
Encrypted pioneer names were saved to a text file: [pioneers.txt](pioneers.txt).
``` ruby
def rot13ify(char)
  case char
  when 'a'..'z' then (((char.ord - 84) % 26) + 97).chr
  when 'A'..'Z' then (((char.ord - 52) % 26) + 65).chr
  else char
  end
end

File.open('pioneers.txt').each do |name|
  puts name.chars.map { |char| rot13ify(char) }.join
end
```

### Further Exploration
Not all computers use ASCII. Some mainframes use different schemes such as EBCDIC, which some IBM computers use. EBCDIC is unusual: the alphabetic characters are not all grouped together like in ASCII (see the linked page). How would this impact our implementation of this program if we were running this program on data that uses the EBCDIC representation?

### Solution
I would give in to the temptation mentioned at the beginning of the provided solution and use a lookup table:
``` ruby
LOWER_LETTERS = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z].freeze
UPPER_LETTERS = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z].freeze

def rot13ify_ebcdic(char)
  case char
  when 'a'..'z' then LOWER_LETTERS[((LOWER_LETTERS.index(char) + 13) % 26)]
  when 'A'..'Z' then UPPER_LETTERS[((UPPER_LETTERS.index(char) + 13) % 26)]
  else char
  end
end

File.open('pioneers.txt').each do |name|
  puts name.chars.map { |char| rot13ify_ebcdic(char) }.join
end
```        

---
## 6. Iterators: True for Any?
A great way to learn about blocks is to implement some of the core ruby methods that use blocks using your own code. Over this exercise and the next several exercises, we will do this for a variety of different standard methods.

The `Enumerable#any?` method processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of `true` for any element, then `#any?` returns `true`. Otherwise, `#any?` returns `false`. Note in particular that `#any?` will stop searching the collection the first time the block returns `true`.

Write a method called ``any?`` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `true` for any of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true`.

If the Array is empty, `any?` should return `false`, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
``` ruby
any?([1, 3, 5, 6]) { |value| value.even? } == true
any?([1, 3, 5, 7]) { |value| value.even? } == false
any?([2, 4, 6, 8]) { |value| value.odd? } == false
any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
any?([1, 3, 5, 7]) { |value| true } == true
any?([1, 3, 5, 7]) { |value| false } == false
any?([]) { |value| true } == false
```

### Solution
``` ruby
def any?(array, &block)
  return false if array.empty?
  array.each { |item| return true if yield(item) == true }
  false
end
```

#### Refactored based on provided solution:
``` ruby
def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end
```

---
## 7. Iterators: True for All?
In the previous exercise, you developed a method called `any?` that is similar to the standard `Enumerable#any?` method for Arrays (our actual solution works with any Enumerable collection). In this exercise, you will develop its companion, `all?`.

`Enumerable#all?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of `true` for every element, then `#all?` returns `true`. Otherwise, `#all?` returns `false`. Note in particular that `#all?` will stop searching the collection the first time the block returns `false`.

Write a method called `all?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for all of the element values. Otherwise, it should return false.

Your method should stop processing elements of the Array as soon as the block returns `false`.

If the Array is empty, `all?` should return `true`, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
``` ruby
all?([1, 3, 5, 6]) { |value| value.odd? } == false
all?([1, 3, 5, 7]) { |value| value.odd? } == true
all?([2, 4, 6, 8]) { |value| value.even? } == true
all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
all?([1, 3, 5, 7]) { |value| true } == true
all?([1, 3, 5, 7]) { |value| false } == false
all?([]) { |value| false } == true
```

### Solution
``` ruby
def all?(collection)
  collection.each { |item| return false unless yield(item) }
  true
end
```

---
## 8. Iterators: True for None?
In the previous two exercises, you developed methods called any? and all? that are similar to the standard `Enumerable` methods with the same names. In this exercise, you will develop another of the methods in this family, `none?`.

`Enumerable#none?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns `true` for any element, then `#none?` returns `false`. Otherwise, `#none?` returns `true`. Note in particular that `#none?` will stop searching the collection the first time the block returns `true`.

Write a method called `none?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `false` for all of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true`.

If the Array is empty, `none?` should return `true`, regardless of how the block is defined.

Your method may not use any of the following methods from the Array and Enumerable classes: `all?`, `any?`, `none?`, `one?`. You may, however, use either of the methods created in the previous two exercises.

Examples:
``` ruby
none?([1, 3, 5, 6]) { |value| value.even? } == false
none?([1, 3, 5, 7]) { |value| value.even? } == true
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true
```

### Solution 1 (using previously defined `any?`)
``` ruby
def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end

def none?(collection, &block)
  return false if any?(collection, &block)
  true
end
```

#### Refactored based on provided solution:
``` ruby
def any?(collection)
  collection.each { |item| return true if yield(item) }
  false
end

def none?(collection, &block)
  !any?(collection, &block)
end
```

### Solution 2 (from scratch)
``` ruby
def none?(collection)
  collection.each { |item| return false if yield(item) }
  true
end
```

## 9. Iterators: True for One?
In the previous 3 exercises, you developed methods called `any?`, `all?`, and `none?` that are similar to the standard `Enumerable` methods of the same names. In this exercise, you will develop one last method from this family, `one?`.

`Enumerable#one?` processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of `true` for exactly one element, then `#one?` returns `true`. Otherwise, `#one?` returns `false`. Note in particular that #one? will stop searching the collection the second time the block returns `true`.

Write a method called `one?` that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return `true` if the block returns `true` for exactly one of the element values. Otherwise, it should return `false`.

Your method should stop processing elements of the Array as soon as the block returns `true` a second time.

If the Array is empty, `one?` should return false, regardless of how the block is defined.

Your method may not use any standard ruby method that is named `all?`, `any?`, `none?`, or `one?`.

Examples:
``` ruby
one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
one?([1, 3, 5, 7]) { |value| true }           # -> false
one?([1, 3, 5, 7]) { |value| false }          # -> false
one?([]) { |value| true }                     # -> false
```

### Solution
``` ruby
def one?(collection)
  trues = 0
  collection.each do |item|
    trues += 1 if yield(item)
    return false if trues > 1
  end

  trues == 1 ? true : false
end
```

## 10. Count Items
Write a method that takes an array as an argument, and a block that returns `true` or `false` depending on the value of the array element passed to it. The method should return a count of the number of times the block returns `true`.

You may not use `Array#count` or `Enumerable#count` in your solution.

Examples:
``` ruby
count([1,2,3,4,5]) { |value| value.odd? } == 3
count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
count([1,2,3,4,5]) { |value| true } == 5
count([1,2,3,4,5]) { |value| false } == 0
count([]) { |value| value.even? } == 0
count(%w(Four score and seven)) { |value| value.size == 5 } == 2
```

### Solution
``` ruby
def count(collection)
  trues = 0
  collection.each { |item| trues += 1 if yield(item) }
  trues
end
```

### Further Exploration
Write a version of the `count` method that meets the conditions of this exercise, but also does not use `each`, `loop`, `while`, or `until`.

### Solution
``` ruby
def count(collection, &block)
  collection.select(&block).size
end
```
