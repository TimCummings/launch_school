# medium_3.rb

# Question 1
# The IDs will not change. The values will change upon reassignment in the do loop

# Question 2
# IDs will change going from outside the method to inside the method, even before values are reassigned; IDs will change again when values are reassigned

# Question 3
# My string looks like this now: pumpkins
# My array looks like this now: ["pumpkins", "rutabaga"]
# Two different operators are being used for the two parameters: a_string_param is using the non-destructive assignment operator while an_array_param is using the destructive shovel operator

# Question 4
# My string looks like this now: pumpkinsrutabaga
# My array looks like this now: ["pumpkins"]
# As in the previous question, the two parameters are using different operators - the array assignment operator is non-destructive (creates a new copy instead of modifying the original) and the string shovel operator is destructive (modifies the original instead of creating a new copy)

# Question 5
# color == "green" || color == "blue" ? true : false
