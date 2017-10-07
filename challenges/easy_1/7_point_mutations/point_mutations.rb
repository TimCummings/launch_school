# point_mutations.rb

class DNA
  def initialize(strand)
    raise ArgumentError, "Input must be a string" unless strand.is_a? String
    @strand = strand
  end

  def shorter_length(other_strand)
    [@strand.length, other_strand.length].min
  end

  def hamming_distance(other_strand)
    raise ArgumentError, "Input must be a string" unless other_strand.is_a? String
    counter = 0

    shorter_length(other_strand).times do |idx|
      counter += 1 unless @strand[idx] == other_strand[idx]
    end

    counter
  end
end
