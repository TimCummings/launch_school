
[comment]: # (secret_handshake.md)

## Medium 1-1: Secret Handshake - 10/11/2017

Write a program that will take a decimal number, and convert it to the appropriate sequence of events for a secret handshake.

There are 10 types of people in the world: Those who understand binary, and those who don't. You and your fellow cohort of those in the "know" when it comes to binary decide to come up with a secret "handshake".
```
1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```
``` ruby
handshake = SecretHandshake.new 9
handshake.commands # => ["wink","jump"]

handshake = SecretHandshake.new "11001"
handshake.commands # => ["jump","wink"]
```
The program should consider strings specifying an invalid binary as the value 0.

test suite provided: [secret_handshake_test.rb](secret_handshake_test.rb)

---
### Solution
[secret_handshake.rb](secret_handshake.rb)

* Input:
  - integer or string representing binary number representing secret handshake
* Output:
  - array of secret handshake "moves" (strings)
* Edge Cases:
  - no input -> automatically raises ArgumentError
  - input isn't string or integer -> raise TypeError
  - invalid string -> return empty array
  - number out of range -> convert to binary and process normally (ignoring excess digits)


* Pseudocode:
  - create an array of strings to represent secret handshake "moves" (which will be accessed by their index, representing the place-value of the associated binary digit, e.g. "double blink" is associated with binary "10" so it's index will be 1: 2 ** 1)
  - guard against edge cases
    + raise TypeError unless input is integer or string
  - if input is integer, convert to binary string
  - remove any excess digits
  - split string into array of digits (smallest place-value to largest)
  - map array to associated "moves" based on index of digit
  - reverse array if necessary
  - return result
