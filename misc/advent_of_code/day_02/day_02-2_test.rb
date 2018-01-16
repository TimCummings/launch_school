# day_02-2_test.rb

require 'minitest/autorun'
require_relative 'day_02-2'

class SpreadsheetTest < Minitest::Test
  def test_checksum
    spreadsheet1 = Spreadsheet.new("5 9 2 8\n9 4 7 3\n3 8 6 5")
    assert_equal 9, spreadsheet1.checksum
  end
end
