# exercise6.rb

# Since I struggled a bit on this exercise, and my solution turned out to be unnecessarily complex (compared to the solution provided after the exercise), I am going to leave comments to hopefully demonstrate my thought process as I tried to solve this exercise

words = [ 'demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon' ]

# I started by working backwards - I normally would not have attempted to incorporate hashes into this exercise, but the exercise was in the hash chapter, so I started by reviewing the Hash class on ruby-doc.org and looking for any method that would help in solving this exercise.

# I was somewhat daunted by the task of comparing words to discover if they were anagrams or not. As I reviewed the Hash class on ruby-doc.org I noticed that the hash comparison operator (==) ignored order and seemingly provided me an easy way to find anagrams. So I decided to use this as my starting point and work backwards from that.

words_hashed = []

# Once I had my starting point, I needed to get the words into a hash form where each letter was a separate value. But for my comparison to work, the key for a given letter in one word had to match the key for that same letter in another word. The simplest way to do this seemed to be using that same letter as both the value and the key. I realized that would cause an issue for words with multiple instances of the same letter, but, after some IRB testing, realized that it would still successfully detect anagrams.

#I did worry that I was possibly missing a better way to incorporate hashes into this exercise, as matching keys and values seemed unnecessarily redundant, but I also thought I had a workable solution, so I proceeded with it.

words.each do |word|
  hash_of_letters = {}
  letters = word.chars
  letters.each do |v|
    k = v

    # While I was correct above that my solution would detect anagrams when words had multiple instances of the same letter, I would not be able to print such words at the end, as they would be missing at least one instance of a repeated letter. So I added this loop to keep keys unique while not dropping any repeated letters.
    while hash_of_letters.key?(k)
      k += k
    end
    hash_of_letters[k] = v
  end
  words_hashed.push(hash_of_letters)
end

until words_hashed.empty?
  word1 = words_hashed.shift
  anagrams = []
  words_hashed.each do |word2|

    # This became my starting point - comparing the words to each other as hashes to find anagrams
    if word1 == word2
      anagrams.push(word2.values.join)
    end
  end
  words_hashed.delete(word1)
  if !(anagrams.empty?)
    anagrams.unshift(word1.values.join)
    p anagrams
  end
end



# I mentioned towards the beginning that I would normally not have attempted to solve this with hashes, but started with hashes since this exercise was in the Hashes chapter. The solution in the book shows pretty clearly that hashes provide a much simpler and more elegant solution than my solution above (which did use hashes, but not in the best way) or any other non-hash solution I might have come up with had this not been a Hashes chapter exercise.
