# variable_scope.rb

# What's My Value? (Part 1)
7
# Once the my_value method is exited, a remains 7 since it was modified only in the scope of the method, my_value; also, += does not mutate the caller for integers.



# What's My Value? (Part 2)
7
# The a outside the my_value method and the a inside the my_value method are different variables, even though they share the same name. += still does not mutate the caller, so the variable a outside the my_value method retains its value of 7.



# What's My Value? (Part 3)
7
# The variable a outside the scope of the my_value method is still not being mutated. The a = b inside the my_value method is creating a new, different variable named a within the scope of the my_value method; the a variable outside the my_value method is still not accessible within the method, and the = method also does not mutate the caller.



# What's My Value? (Part 4)
"Xy-zy"
# The []= method for strings mutates the caller so the string "Xyzzy" is modified.



# What's My Value? (Part 5)
"Xyzzy"
# The = method inside my_value does not mutate the caller; instead, the variable b is assigned to reference a different string: "yzzyX". Once outside my_value, the variable a remains unchanged and so does the string it references: "Xyzzy".



# What's My Value? (Part 6)
# Variable scope error: no such variable as a within the my_value method.
# The variable, a, is outside the scope of the my_value method. Unlike previous exercises, where a new variable named a was being created in the my_value method, this exercise tries to reference a variable named a within my_value when one does not yet exist.



# What's My Value? (Part 7)
3
# The variable a is modified within the do block to reference a new integer; the final one is 3.



# What's My Value? (Part 8)
# variable scope error: the variable a is defined only inside the do block so trying to puts a outside the block results in an undefined variable error.



# What's My Value? (Part 9)
7
# The do block defines its own variable a that holds each successive element from array. The += 1 is applied to the new a within the do block; once the do block exits, the original variable a remains unchanged.



# What's My Value? (Part 10)
# Variable scope error: undefined variable. This exercise is back to using a method instead of a block. There is no a defined within the my_value method so the line a += b generates an error.
# *** It does generate an error, but not a variable scope error; this generates an undefined method error: no method '+' for nil:NilClass
