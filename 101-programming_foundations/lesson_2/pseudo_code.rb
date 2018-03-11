# pseudo_code.rb

# 1) a method that returns the sum of two integers

# CASUAL #
  # ask the user for two integers
  # calculate the sum of the two integers
  # show the result

# FORMAL #
  START
    SET first_integer
    GET value of first_integer
    SET second_integer
    GET value of second_integer
    SET answer to sum of first_integer and second_integer
    PRINT answer
  END



# 2) a method that takes an array of strings, and returns a string that is all those strings concatenated together

# CASUAL #
  # given a collection of strings
  # make a new empty string to which we can concatenate the collection
  # iterate through the collection one by one
    # for each iteration, concatenate the current string onto the new string
  # return the new string

# FORMAL #
  START
    # given a collection of strings in an array called "strings"

    SET answer = empty string
    SET iterator = 0

    WHILE iterator < number of strings in "collection"
      SET current_string = string at index "iterator"
      concatenate "current_string" onto "answer"
      iterator = iterator + 1

    PRINT answer
  END



# 3) a method that takes an array of integers, and returns a new array with every other element

# CASUAL #
  # given a collection of integers
  # make a new empty array to store our answer
  # iterate through the collection one by one
    # for each iteration, if the index is even
      # add the integer at the index to the answer array
    # otherwise, if the index is not even
      # continue to the next iteration
  # return the answer array

# FORMAL #
  START
  # given a collection of integers in an array called "integers"
  SET answer = []
  SET iterator = 0
  WHILE iterator < number of integers
    IF iterator is even
      add integer at current iterator to answer array
    ELSE
      do nothing
    iterator = iterator + 1

  PRINT answer
