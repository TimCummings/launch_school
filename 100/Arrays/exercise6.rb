# exercise6.rb

names = ['bob', 'joe', 'susan', 'margaret']

names['margaret'] = 'jody'

# The error is caused by: names['margaret']
# The bracked array reference names[] expects an integer inside the brackets, but as written above, it is given a string

# If the programmer knows which index of the names array contains 'margaret', the error can be fixed with:
names[3] = 'jody'

# If the programmer does not know which index of the names array contains 'margaret', the error can be fixed with:

# if we can assume that there is only one 'margaret':
names[names.index('margaret')] = 'jody'

# if there could be multiple 'margaret's:
names.each_with_index do |object, index|
  if object == 'margaret'
    names[index] = 'jody'
  end
end
