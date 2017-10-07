# roman_numerals.rb

NUMERAL_PATTERNS =
  [[], [:one], [:one, :one], [:one, :one, :one], [:one, :five], [:five],
   [:five, :one], [:five, :one, :one], [:five, :one, :one, :one], [:one, :ten]]

NUMERAL_DENOMINATIONS = [ { one: 'I', five: 'V', ten: 'X' },
                          { one: 'X', five: 'L', ten: 'C' },
                          { one: 'C', five: 'D', ten: 'M' },
                          { one: 'M'} ]

class Integer
  def to_roman
    patterns = self.digits.map { |digit| NUMERAL_PATTERNS[digit] }
    patterns.map.with_index do |place_value, idx|
      place_value.map { |pattern| NUMERAL_DENOMINATIONS[idx][pattern] }
    end.reverse.join
  end
end
