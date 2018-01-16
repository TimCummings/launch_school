# secret_handshake.rb

class SecretHandshake
  EVENTS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze
  MAX_SIZE = EVENTS.size

  def initialize(code)
    @code =
      case
      when code.is_a?(String)  then code.chars.reverse
      when code.is_a?(Integer) then code.to_s(2).chars.reverse
      else raise TypeError, "Must enter integer or binary string."
      end

    @reverse_events = @code[4] == '1'
  end

  def commands
    @code = @code[0..(MAX_SIZE - 1)] if @code.size > MAX_SIZE
    return [] if @code.any? { |char| char =~ /[^01]/ }

    handshake = @code.map.with_index do |digit, idx|
      digit == '0' ? '' : EVENTS.fetch(idx, '')
    end
    handshake.reverse! if @reverse_events
    handshake.select { |move| !move.empty? }
  end
end
