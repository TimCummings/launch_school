# exercise2.rb

# merge is non-destructive; it combines two hashes into a new hash, which it returns, leaving the original two hashes un-changed (it does not mutate the caller)

# merge! is destructive; it combines two hashes by adding the "passed" hash to the "calling" hash, which it returns. The "calling" hash is changed (this does mutate the caller)

puts "Demonstration of the difference between hash's merge and merge! methods:"

hash1 = { first_name: "Abraham", last_name: "Lincoln", height: "6ft 4in" }
hash2 = { manufacturer: "Tesla", model: "P90D", year: "2015"}

puts "I have two hashes:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge returns: #{hash1.merge(hash2)}"
puts "My two hashes are still:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge! returns: #{hash1.merge!(hash2)}"
puts "My two hashes are now:\n  Hash1: #{hash1}\n  Hash2: #{hash2}"
puts "merge is non-destructive: it did not change my two hashes."
puts "merge! is destructive: it changed Hash1."
