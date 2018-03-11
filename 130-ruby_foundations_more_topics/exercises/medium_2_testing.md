
[comment]: # (medium_2_testing.md)

# Medium 2: Testing - 9/14/2017

---
## 1. Classes to Test - Cash Register and Transaction

These will be the classes you will be testing throughout the remaining exercises. You'll want to create two new files, one for each of the two classes listed below. You'll need this code for the remaining exercises of this set.
``` ruby
# cash_register.rb

class CashRegister
  attr_reader :total_money

  def initialize(total_money)
    @total_money = total_money
  end

  def change(transaction)
    transaction.amount_paid - transaction.item_cost
  end

  def give_receipt(transaction)
    puts "You've paid $#{transaction.item_cost}."
  end

  def accept_money(transaction)
    @total_money += transaction.amount_paid
  end

  def start_transaction(transaction)
    transaction.prompt_for_payment
    accept_money(transaction)
    change(transaction)
    give_receipt(transaction)
  end
end
```
``` ruby
# transaction.rb

class Transaction
  attr_reader :item_cost
  attr_accessor :amount_paid

  def initialize(item_cost)
    @item_cost = item_cost
    @amount_paid = 0
  end

  def prompt_for_payment
    loop do
      puts "You owe $#{item_cost}.\nHow much are you paying?"
      @amount_paid = gets.chomp.to_f
      break if valid_payment? && sufficient_payment?
      puts 'That is not the correct amount. ' \
           'Please make sure to pay the full cost.'
    end
  end

  private

  def valid_payment?
    amount_paid > 0.0
  end

  def sufficient_payment?
    amount_paid >= item_cost
  end
end
```

---
## 2. Setup the Test Class - Cash Register

Let's start things from the ground up. We want to make a simple test suite for our `CashRegister` class. Setup the initial testing file. You don't have to have any tests in your test file. For this exercise, write everything you would need to start testing `CashRegister`, excluding the tests themselves (necessary `require`s, test class, etc.).

### Solution

[cash_register_test.rb](cash_register_test.rb)

---
## 3. Test Accept Money Method - Cash Register

We now have the foundation of our CashRegister test class set up. Let's start testing! We'll start with the `CashRegister#accept_money` method. Write a test for the `#accept_money` method.

---
## 4. Test Change Method - Cash Register

Write a test for the method, `CashRegister#change`.

---
## 5. Test Give Receipt Method - Cash Register

Write a test for method `CashRegister#give_receipt` that ensures it displays a valid receipt.

---
## 6. Test Prompt For Payment Method- Transaction

Write a test that verifies that `Transaction#prompt_for_payment` sets the `amount_paid` correctly. We've changed the transaction class a bit to make testing this a bit easier. The `Transaction#prompt_for_payment` now reads as:
```
def prompt_for_payment(input: $stdin) # We've set a default parameter for stdin
  loop do
    puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f # notice that we call gets on that parameter
    break if valid_payment? && sufficient_payment?
    puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end
```

### Solution

[transaction_test.rb](transaction_test.rb)

---
## 7. Alter Prompt For Payment Method - Transaction

You may have noticed something when running the test for the previous exercise. And that is that our minitest output wasn't that clean. We have some residual output from the `Transaction#prompt_for_payment` method.
```
Run options: --seed 52842

# Running:

You owe $30.
How much are you paying?
.

Finished in 0.001783s, 560.7402 runs/s, 560.7402 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```
`Transaction#prompt_for_payment` has a call to `Kernel#puts` and that output is showing up when we run our test. Your task for this exercise is to make it so that we have "clean" output when running this test. We want to see something like this:
```
Run options: --seed 4957

# Running:

.

Finished in 0.000919s, 1087.9984 runs/s, 1087.9984 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

---
## 8. Swap Letters Sample Text and Starter File

This is not an actual exercise. It is the sample text and class for the next two exercises.

##### Sample Text
```
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras sed vulputate ipsum. Suspendisse commodo sem arcu. Donec a nisi elit. Nullam eget nisi commodo, volutpat quam a, viverra mauris. Nunc viverra sed massa a condimentum. Suspendisse ornare justo nulla, sit amet mollis eros sollicitudin et. Etiam maximus molestie eros, sit amet dictum dolor ornare bibendum. Morbi ut massa nec lorem tincidunt elementum vitae id magna. Cras et varius mauris, at pharetra mi.
```
##### Class and method to Test
``` ruby
class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end
end
```

---
## 9. Test swap method - Text

For this exercise you'll be given a sample text file and a starter class. The sample text's contents will be saved as a `String` to an instance variable in the starter class.

The `Text` class includes a `#swap` method that can be used to replace all occurrences of one letter in the text with another letter. And for this exercise we will swap all occurrences of 'a' with 'e'.

Your task is to write a test suite for class `Text`. In that test suite write a test for the `Text` method `swap`. For this exercise, you are required to use the minitest methods `#setup` and `#teardown`. The `#setup` method contains code that will be executed before each test; `#teardown` contains code that will be executed after each test.

### Solution
Sample text: [lorem_ipsum.txt](lorem_ipsum.txt)
Test file: [text_test.rb](text_test.rb)

---
## 10. Test word_count method - Text

Recall that in the last exercise we only had to test one method of our `Text` class. One of the useful facets of the `setup` and `teardown` methods is that they are automatically run before and after **each** test respectively. To show this we'll be adding one more method to our `Text` class, `word_count`.
``` ruby
class Text
  def initialize(text)
    @text = text
  end

  def swap(letter_one, letter_two)
    @text.gsub(letter_one, letter_two)
  end

  def word_count
    @text.split.count
  end
end
```
Write a test for this new method. Make sure to utilize the setup and teardown methods for any file related operations.

### Solution
Sample text: [lorem_ipsum.txt](lorem_ipsum.txt)
Test file: [text_test.rb](text_test.rb)
