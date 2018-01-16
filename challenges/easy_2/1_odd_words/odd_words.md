
[comment]: # (odd_words.md)

## Easy 2-1: Odd Words - 10/7/2017

Consider a character set consisting of letters, a space, and a point. Words consist of one or more, but at most 20 letters. An input text consists of one or more words separated from each other by one or more spaces and terminated by 0 or more spaces followed by a point. Input should be read from, and including, the first letter of the first word, up to and including the terminating point. The output text is to be produced such that successive words are separated by a single space with the last word being terminated by a single point. Odd words are copied in reverse order while even words are merely echoed.

For example, the input string:
```
"whats the matter with kansas."
```
becomes:
```
"whats eht matter htiw kansas."
```

__BONUS POINTS__: the characters must be read and printed one at a time.

---
### Solution
* input: string representing a sentence consisting of one or more words, separated by one or more spaces, and ending in zero or more spaces followed by one period.
* output: string representing the input sentence modified the following ways:
  - even words print just as they are
  - odd words print with reversed letters (e.g. "with" becomes "htiw")
  - words are separated by only a single space
  - the sentence ends with no spaces after the last word and a single period
* cases:
  - one word sentence
  - multiple spaces between words
  - zero spaces between last word and period
  - multiple spaces between last word and period
* edge cases:
  - initialization:
    + no input -> automatically raise ArgumentError
    + input isn't string -> raise TypeError
  - call:
    + input string is empty -> return '.'
    + input string contains invalid characters ([^a-zA-Z .]) -> warn and sanitize
    + word more than 20 characters -> warn
    + no ending period -> warn and add period for final output
    + more than one period -> warn and ignore input after first period


* Pseudocode
  - split input string by whitespace
  - if last array item is a single period, append it to the last word/second to last array item, shortening the array by one element
  - map the array, reversing the letters of odd_indexed words
  - join the array with a single space as the separator


* Solution: [odd_words.rb](odd_words.rb)
