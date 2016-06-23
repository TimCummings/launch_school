# exercise2.rb

# One
arr1 = ["b", "a"]
arr1 = arr1.product(Array(1..3))
arr1.first.delete(arr1.first.last)
# This will return 1
# After this program, the value of arr1 will be:
# [["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]


# Two
arr2 = ["b", "a"]
arr2 = arr2.product([Array(1..3)])
arr2.first.delete(arr2.first.last)
# This will return [1, 2, 3]
# After this program, the value of arr1 will be:
# [["b"], ["a", [1, 2, 3]]]
