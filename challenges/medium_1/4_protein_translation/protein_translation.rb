# protein_translation.rb

class InvalidCodonError < RuntimeError
end

# # initial solution
# class Translation
#   PROTEINS = { 'Methionine'    => ['AUG'],
#                'Phenylalanine' => ['UUU', 'UUC'],
#                'Leucine'       => ['UUA', 'UUG'],
#                'Serine'        => ['UCU', 'UCC', 'UCA', 'UCG'],
#                'Tyrosine'      => ['UAU', 'UAC'],
#                'Cysteine'      => ['UGU', 'UGC'],
#                'Tryptophan'    => ['UGG'],
#                'STOP'          => ['UAA', 'UAG', 'UGA'] }
#
#   def self.of_codon(codon)
#     result = PROTEINS.find { |_, v| v.include? codon }
#     raise InvalidCodonError if result.nil?
#     result.first
#   end
#
#   def self.of_rna(strand)
#     raise ArgumentError unless strand.is_a? String
#
#     polypeptide = []
#     loop do
#       break if strand.empty?
#       protein = of_codon strand.slice!(0, 3).upcase
#       break if protein == 'STOP'
#       polypeptide << protein
#     end
#
#     polypeptide
#   end
# end



# # initial solution refactored:
# #   eliminate local variable from self.of_codon
# #   combine `loop do` and first `break` into `until empty?` in self.of_rna
# class Translation
#   PROTEINS = { 'Methionine'    => ['AUG'],
#                'Phenylalanine' => ['UUC', 'UUU'],
#                'Leucine'       => ['UUA', 'UUG'],
#                'Serine'        => ['UCA', 'UCC', 'UCG', 'UCU'],
#                'Tyrosine'      => ['UAC', 'UAU'],
#                'Cysteine'      => ['UGC', 'UGU'],
#                'Tryptophan'    => ['UGG'],
#                'STOP'          => ['UAA', 'UAG', 'UGA'] }
#
#   def self.of_codon(codon)
#     PROTEINS.find(lambda { raise InvalidCodonError }) do |_, values|
#       values.include? codon
#     end.first
#   end
#
#   def self.of_rna(strand)
#     raise ArgumentError unless strand.is_a? String
#
#     polypeptide = []
#     until strand.empty? do
#       codon = strand.slice!(0, 3).upcase
#       protein = Translation.of_codon(codon)
#       break if protein == 'STOP'
#       polypeptide << protein
#     end
#
#     polypeptide
#   end
# end



# # idiomatic Ruby solution
# module Translation
#   PROTEINS = { 'Methionine'    => ['AUG'],
#                'Phenylalanine' => ['UUC', 'UUU'],
#                'Leucine'       => ['UUA', 'UUG'],
#                'Serine'        => ['UCA', 'UCC', 'UCG', 'UCU'],
#                'Tyrosine'      => ['UAC', 'UAU'],
#                'Cysteine'      => ['UGC', 'UGU'],
#                'Tryptophan'    => ['UGG'],
#                'STOP'          => ['UAA', 'UAG', 'UGA'] }
#
#   def self.of_codon(codon)
#     PROTEINS.find(lambda { raise InvalidCodonError }) do |_, values|
#       values.include? codon
#     end.first
#   end
#
#   def self.of_rna(strand)
#     raise ArgumentError unless strand.is_a? String
#
#     strand.scan(/.../).map do |codon|
#       Translation.of_codon(codon.upcase)
#     end.take_while { |codon| codon != 'STOP' }
#   end
# end



# in-between solution: idiomatic that breaks at 'STOP'
class Translation
  PROTEINS = { 'Methionine'    => ['AUG'],
               'Phenylalanine' => ['UUC', 'UUU'],
               'Leucine'       => ['UUA', 'UUG'],
               'Serine'        => ['UCA', 'UCC', 'UCG', 'UCU'],
               'Tyrosine'      => ['UAC', 'UAU'],
               'Cysteine'      => ['UGC', 'UGU'],
               'Tryptophan'    => ['UGG'],
               'STOP'          => ['UAA', 'UAG', 'UGA'] }

  def self.of_codon(codon)
    PROTEINS.find(lambda { raise InvalidCodonError }) do |_, values|
      values.include? codon
    end.first
  end

  def self.of_rna(strand)
    raise ArgumentError unless strand.is_a? String

    strand.scan(/.../).each_with_object([]) do |codon, polypeptide|
      protein = Translation.of_codon(codon)
      return polypeptide if protein == 'STOP'
      polypeptide << protein
    end
  end
end
