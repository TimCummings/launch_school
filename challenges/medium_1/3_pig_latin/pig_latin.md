
[comment]: #(pig_latin.md)

# Medium 1-3: Pig Latin - 3/10/2018

Pig Latin is a made-up children's language that's intended to be confusing. It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.

* __Rule 1__: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
* __Rule 2__: If a word begins with a consonant sound, move it to the end of the word, and then add an "ay" sound to the end of the word.

There are a few more rules for edge cases, and there are regional variants too.

Test suite provided: [pig_latin_test.rb](pig_latin_test.rb)

---
### Solution
* Input: string representing word or series of words to be translated to pig latin
* Output: string representing input translated to pig latin
* Rules/Implicit Knowledge
  - if a word begins with a vowel sound, add "ay" sound to end of word
  - if a word begins with a consonant sound, move it to the end of the word and add an "ay" sound to the end
  - "sound": in between a letter and a syllable
    + will often be just the first letter, but not always
    + will sometimes be multiple letters
    + can sometimes be the opposite of what the first letter is, e.g. "xray" starts with a consonant but is treated as starting with a vowel sound
    + if first letter is consonant, "sound" usually includes all letters until the first vowel
    + if first letter is vowel, "sound" usually includes all letters until the first consonant
* Examples: [pig_latin_test.rb](pig_latin_test.rb)
* Edge Cases
  - input must be string
  - invalid characters (/[^a-zA-Z ]/) aren't addressed in test cases; discard them
  - case isn't addressed in test cases; downcase everything for consistency
  - 'q': almost always followed by 'u'
  - characters that can go either way ('x', 'y')
    + followed by vowel = consonant sound
    + followed by consonant = vowel sound
* Data Structure: array of strings
* Algorithm
  - raise ArgumentError unless input is a string
  - detect and discard invalid characters, warning user
  - separate input into list of words (split on spaces)
  - iterate list of words (map?)
    + detect first sound of word
    + if vowel sound, add "ay" to end
    + if consonant sound, move sound to end and add "ay"
  - join resulting array with spaces
