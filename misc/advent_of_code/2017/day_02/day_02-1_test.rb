# day_02-1_test.rb

require 'minitest/autorun'
require_relative 'day_02-1'

class SpreadsheetTest < Minitest::Test
  def test_checksum
    spreadsheet1 = Spreadsheet.new("5 1 9 5\n7 5 3\n2 4 6 8")
    assert_equal 18, spreadsheet1.checksum
  end
end
