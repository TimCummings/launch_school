# temp.rb

# require 'minitest/autorun'
#
# class MyFirstTest < Minitest::Test
#   def test_first_test
#     assert true
#   end
# end



# thoughts:
  # We just defined a class, but we never "ran" anything - how was our assertion evaluated?
    # Is there something in 'minitest/autorun' ('autorun' potentially being the key word) that evaluates our assertion automatically?
      # If so, does it automatically evaluate all assertions, or just a specific selection (and what is the selection criteria if so)? Let's try something:

# require 'minitest/autorun'
#
# class MyFirstTest < Minitest::Test
#   def test_first_test
#     assert true
#   end
#
#   def test_second_test
#     assert false
#   end
# end

  # This results in 2 assertions with one being a failure. So it seems like this code is either evaluating all assertions or there is something possibly in the naming convention of the methods that gets them evaluated automatically.

  # Let's try one more thing:

# require 'minitest/autorun'
#
# class MyFirstTest < Minitest::Test
#   def test_first_test
#     assert true
#   end
#
#   def second_test
#     assert false
#   end
# end

# This results in only one assertion (which is true), so it looks like this code does have a way of automatically evaluating assertions based on some criteria, and it looks like that criteria is prepending the method name with 'test_'
