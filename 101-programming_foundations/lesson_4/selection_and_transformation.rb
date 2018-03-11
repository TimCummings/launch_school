# collections_basics.rb

# # In this example we want to select the key-value pairs where the value is 'Fruit'.
# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }
#
# def select_fruit(produce)
#   fruits = {}
#   produce_keys = produce.keys
#   count = 0
#
#   loop do
#     break if count == produce.size
#     current_key = produce_keys[count]
#     current_value = produce[current_key]
#
#     fruits[current_key] = current_value if current_value == 'Fruit'
#     count += 1
#   end
#
#   fruits
# end



# # Can you implement a double_numbers! method that mutates its argument?
# def double_numbers!(numbers)
#   count = 0
#
#   loop do
#     break if count == numbers.size
#     numbers[count] *= 2
#     count += 1
#   end
#
#   numbers
# end



# # Try coding a solution that doubles the numbers that have odd indices:
# def double_odd_idx(numbers)
#   result = []
#   count = 0
#
#   loop do
#     break if count == numbers.size
#     if count.odd?
#       result << numbers[count] * 2
#     else
#       result << numbers[count]
#     end
#
#     count += 1
#   end
#
#   result
# end



# # Try coding a method that allows you to multiply every array item by a specified value:
# def multiply(numbers, factor=2)
#   result = []
#   count = 0
#
#   loop do
#     break if count == numbers.size
#     result << numbers[count] * factor
#     count += 1
#   end
#
#   result
# end



# Let's write a method called select_letter, that takes a string and returns a new string containing only the letter that we specified.
def select_letter(question, letter)
  counter = 0
  letter_count = 0

  loop do
    break if counter == question.size
    letter_count += 1 if question[counter] == letter
    counter += 1
  end

  letter * letter_count
end
