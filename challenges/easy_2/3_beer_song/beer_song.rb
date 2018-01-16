# beer_song.rb

# class BeerSong
#   def validate(bottle)
#     raise TypeError, 'Input must be integer.' unless bottle.is_a? Integer
#   end
#
#   def verse(bottle)
#     validate(bottle)
#
#     case bottle
#     when 3..99
#       "#{bottle} bottles of beer on the wall, #{bottle} bottles of beer.\n" \
#         "Take one down and pass it around, #{bottle - 1} bottles of beer on the wall.\n"
#     when 2
#       "#{bottle} bottles of beer on the wall, #{bottle} bottles of beer.\n" \
#         "Take one down and pass it around, #{bottle - 1} bottle of beer on the wall.\n"
#     when 1
#       "#{bottle} bottle of beer on the wall, #{bottle} bottle of beer.\n" \
#         "Take it down and pass it around, no more bottles of beer on the wall.\n"
#     when 0
#       "No more bottles of beer on the wall, no more bottles of beer.\n" \
#       "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
#     else
#       raise RuntimeError, "There can't be fewer than 0 bottles or more than 99."
#     end
#   end
#
#   def verses(initial, final)
#     validate(initial) && validate(final)
#     raise RuntimeError, "Initial bottle must be greater than final bottle; we're not putting beer back into bottles, that's not sanitary." unless final < initial
#
#     initial.downto(final).each_with_object([]) do |bottle, song|
#       song << verse(bottle)
#     end.join("\n")
#   end
#
#   def lyrics
#     verses(99, 0)
#   end
# end



# BONUS: no conditionals (`if`s, `case`s, etc.)
class BeerSong
  LYRICS = {
    0 => "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n",

    1 => "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n",

    2 =>"2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n",

    (3..99) => "%{bottle} bottles of beer on the wall, %{bottle} bottles of beer.\nTake one down and pass it around, %{less_bottle} bottles of beer on the wall.\n" }

  def verse(bottle)
    verse_key = LYRICS.keys.find { |key| key === bottle }
    sprintf(LYRICS[verse_key], { :bottle => bottle, :less_bottle => (bottle - 1) })
  end

  def verses(initial, final)
      initial.downto(final).each_with_object([]) do |bottle, song|
        song << verse(bottle)
      end.join("\n")
    end

    def lyrics
      verses(99, 0)
    end
end
