
[comment]: # (luhn_algorithm.md)

## Medium 1-2: Luhn Algorithm - 10/13/2017

The Luhn formula is a simple checksum formula used to validate a variety of identification numbers, such as credit card numbers and Canadian Social Insurance Numbers.

The formula verifies a number against its included check digit, which is usually appended to a partial number to generate the full number. This number must pass the following test:

* Counting from rightmost digit (which is the check digit) and moving left, double the value of every second digit.
* For any digits that thus become 10 or more, subtract 9 from the result.
  - 1111 becomes 2121.
  - 8763 becomes 7733 (from 2×6=12 → 12-9=3 and 2×8=16 → 16-9=7).


* Add all these digits together.
  - 1111 becomes 2121 sums as 2+1+2+1 to give a checksum of 6.
  - 8763 becomes 7733, and 7+7+3+3 is 20.


If the total (the checksum) ends in 0 (put another way, if the total modulus 10 is congruent to 0), then the number is valid according to the Luhn formula; else it is not valid. So, 1111 is not valid (as shown above, it comes out to 6), while 8763 is valid (as shown above, it comes out to 20).

Write a program that, given a number

* Can check if it is valid per the Luhn formula. This should treat, for example, "2323 2005 7766 3554" as valid.
* Can return the checksum, or the remainder from using the Luhn method.
* Can add a check digit to make the number valid per the Luhn formula and return the original number plus that digit. This should give "2323 2005 7766 3554" in response to "2323 2005 7766 355".


About Checksums:

A checksum has to do with error-detection. There are a number of different ways in which a checksum could be calculated.

When transmitting data, you might also send along a checksum that says how many bytes of data are being sent. That means that when the data arrives on the other side, you can count the bytes and compare it to the checksum. If these are different, then the data has been garbled in transmission.

In the Luhn problem the final digit acts as a sanity check for all the prior digits. Running those prior digits through a particular algorithm should give you that final digit.

It doesn't actually tell you if it's a real credit card number, only that it's a plausible one. It's the same thing with the bytes that get transmitted -- you could have the right number of bytes and still have a garbled message. So checksums are a simple sanity-check, not a real in-depth verification of the authenticity of some data. It's often a cheap first pass, and can be used to quickly discard obviously invalid things.

Test suite provided: [luhn_algorithm_test.rb](luhn_algorithm_test.rb)

---
### Solution
[luhn_algorithm.rb](luhn_algorithm.rb)

* Input:
  - `Luhn#initialize`: integer representing an identification number (partial number with its checksum digit)
  - `Luhn::create`: integer representing a partial identification number without its checksum digit
* Output:
  - `Luhn#addends`: array of integers representing the digits of the identification number after they have been appropriately transformed in preparation of validating the checksum
    + appropriate transformation is doubling the value of every second digit (odd indexed) and subtracting 9 if the value is 10 or greater
  - `Luhn#checksum`: integer representing the result of the checksum validation test (by summing the elements of the array returned by `Luhn#addends`)
  - `Luhn#valid?`: boolean representing whether the check digit is valid or not (a check digit is valid when the result of `Luhn#checksum` is evenly divisible by 10)
  - `Luhn::create`: integer representing the identification (the partial number provided as input along with its valid check digit as calculated in this method)
* Edge Cases:
  - no input -> automatically raises ArgumentError
  - input isn't an integer -> raise TypeError


* Pseudocode:
  - `Luhn#initialize`:
    + guard against edge cases
    + split the identification number into a reversed array of digits
  - `Luhn#addends`:
    + map the digit array applying the Luhn validation transformation as necessary (to elements with an odd index)
      * transformation: multiply the element by 2 and subtract 9 if the element is 10 or greater
  - `Luhn#checksum`:
    + reduce the transformed digit array by summing
  - `Luhn#valid?`:
    + return true if the result of `Luhn#checksum` is evenly divisble by 10 (return false otherwise)
  - `Luhn::create`:
    + guard against edge cases
    + since the input is a partial number without its check digit, add a zero in the least significant place value so existing `Luhn` methods based on digit index can be re-used
    + calculate the checksum of this number
    + find the remainder when dividing the checksum by 10
    + subtract the remainder from 10 to find the appropriate check digit value to add to the input partial number
