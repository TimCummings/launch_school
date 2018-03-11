# transaction_test.rb
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require 'stringio'

require_relative 'transaction'

class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(50)
  end

  def test_prompt_for_payment
    iosim_in = StringIO.new("50\n")
    iosim_out = StringIO.new
    @transaction.prompt_for_payment(input: iosim_in, output: iosim_out)
    assert_equal(50, @transaction.amount_paid)
  end
end
