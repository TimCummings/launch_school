# secret_handshake.rb

# class SecretHandshake
#   EVENTS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze
#   MAX_SIZE = EVENTS.size
#
#   def initialize(code)
#     @code =
#       case
#       when code.is_a?(String)  then code.chars.reverse
#       when code.is_a?(Integer) then code.to_s(2).chars.reverse
#       else raise TypeError, "Must enter integer or binary string."
#       end
#
#     @reverse_events = @code[4] == '1'
#   end
#
#   def commands
#     @code = @code[0..(MAX_SIZE - 1)] if @code.size > MAX_SIZE
#     return [] if @code.any? { |char| char =~ /[^01]/ }
#
#     handshake = @code.map.with_index do |digit, idx|
#       digit == '0' ? '' : EVENTS.fetch(idx, '')
#     end
#     handshake.reverse! if @reverse_events
#     handshake.select { |move| !move.empty? }
#   end
# end

# refactor using bitwise and for event lookup and proc hash for adding events
class SecretHandshake
  EVENTS = { 0b00001 => proc { |handshake| handshake << 'wink' },
             0b00010 => proc { |handshake| handshake << 'double blink' },
             0b00100 => proc { |handshake| handshake << 'close your eyes' },
             0b01000 => proc { |handshake| handshake << 'jump' },
             0b10000 => proc { |handshake| handshake.reverse! }}

  def initialize(code)
    raise RuntimeError, "Input must be decimal integer or binary string." unless code.is_a?(Integer) || code.is_a?(String)

    @code = code.is_a?(Integer) ? code : code.to_i(2)
  end

  def commands
    EVENTS.each.with_object([]) do |(key, event), handshake|
      event.call(handshake) if @code & key == key
    end
  end
end
