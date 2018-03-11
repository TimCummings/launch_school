# reading_documentation_2.rb

# # Methods Without Arguments
# "xyz".upcase



# # Required Arguments
# a = %w(a b c d e)
#
# a.insert(3, 5, 6, 7)



# # Optional Arguments
# s = 'abc def ghi,jkl mno pqr,stu vwx yz'
# puts s.split.inspect
# # ["abc", "def", "ghi,jkl", "mno", "pqr,stu", "vwx", "yz"]
#
# puts s.split(',').inspect
# # ["abc def gji", "jkl mno pqr", "stu vwx yz"]
#
# puts s.split(',', 2).inspect
# # ["abc def gji", "jkl mno pqr,stu vwx yz"]



# # Optional Arguments Redux
# require 'date'
#
# puts Date.new
# # -4712-01-01
#
# puts Date.new(2016)
# # 2016-01-01
#
# puts Date.new(2016, 5)
# # 2016-05-01
#
# puts Date.new(2016, 5, 13)
# # 2016-05-13



# # Mandatory Blocks
# a.bsearch { |x| x > 8 }



# # Multiple Signatures
# a = %w(a b c d e)
#
# puts a.fetch(7)
# # an out of bounds IndexError
#
# puts a.fetch(7, 'beats me')
# # beats me
#
# puts a.fetch(7) { |index| index**2 }
# # 49



# Keyword Arguments
5.step(to: 10, by: 3) { |value| puts value }

5
8



# Parent Class
puts s.public_methods(false).inspect



# Included Modules
a = [5, 9, 3, 11]
puts a.min(2)



# Down the Rabbit Hole
#http://ruby-doc.org/stdlib-2.4.0/libdoc/psych/rdoc/Psych.html#method-c-load_file
