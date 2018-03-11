# cash_register_test.rb

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(500)
    @transaction = Transaction.new(50)
  end

  def test_accept_money
    assert_equal 500, @register.total_money
    @transaction.amount_paid = 50
    @register.accept_money(@transaction)
    assert_equal 500 + @transaction.amount_paid, @register.total_money
  end

  def test_change
    @transaction.amount_paid = 100
    assert_equal 50, @register.change(@transaction)
  end

  def test_give_receipt
    expected = "You've paid $50.\n"
    assert_output(expected) { @register.give_receipt(@transaction) }
  end
end
