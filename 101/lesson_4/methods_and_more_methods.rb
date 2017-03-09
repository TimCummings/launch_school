# methods_and_more_methods.rb

# Exercise 1
# The return value is the same as the initial array: [1, 2, 3] because the string 'hi' is a truthy value which causes the select block to evaluate to true for each element in the array.



# Exercise 2
# #count evaluates the block's return value for truthiness and returns an integer that is the sum of all elements in the collection for which the block evaluated to true. We can find this out by reading the documentation for Array#count.



# Exercise 3
# #reject returns an array with the same values as the caller: [1, 2, 3] because puts is the last line of the block and its return value is always nil which evaluates to false for every element in the array.



# Exercise 4
# The return value of #each_with_object is the same hash that is given as an argument to #each_with_object; once it's returned, it will contain: { 'a' => 'ant', 'b' => 'bear', 'c' => 'cat' }.



# Exercise 5
# #shift removes and returns a key, value pair from the hash as an array:
# hash.shift returns: [a:, 'ant'], and hash now == { b: 'bear' }
# We find this out by checking the documentation for Hash#shift



# Exercise 6
# 11: Array#pop removes and returns the last item in the array (the string 'caterpillar') and 'caterpillar'.size returns the length of the string 'caterpillar' which is the integer 11.



# Exercise 7
# The block's return value is the last line of code that is evaluated for truthiness (in this case: num.odd?, so either true or false).
# The return value of #any? is true since the array [1, 2, 3] contains at least one element for which num.odd? will return true.
# This code outputs each element in the array until the block returns true or has been evaluated for every element; this is because of puts num. In this case, only the first element, 1, will be output since the block evaluates to true and consequently does not get run for any other elements.
# 1



# Exercise 8
# The first thing to do is to check the documentation for Array#take, but it is somewhat vague. The wording (just "returns" instead of "removes and returns") seems to imply that #take is not destructive, but since the documentation is not clear, this code needs to be tested in a safe environment such as IRB before being used.
# Once tested, it is clear that Array#take is not destructive.



# Exercise 9
# #map returns an array of the same size as the hash: [nil, 'bear']. #map evaluates the block once for each item in the collection and returns a new collection with the return values of the block.



# Exercise 10
# The block's return value is the value returned by the last line evaluated in the block. For 1, the return value is 1 as determined by the else branch. For 2 and 3, the return value is nil as determined by the puts (puts always returns nil).