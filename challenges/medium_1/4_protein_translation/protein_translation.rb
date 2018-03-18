# protein_translation.rb

require 'pry'

class Translation
  PROTEINS = { 'Methionine'    => ['AUG'],
               'Phenylalanine' => ['UUU', 'UUC'],
               'Leucine'       => ['UUA', 'UUG'],
               'Serine'        => ['UCU', 'UCC', 'UCA', 'UCG'],
               'Tyrosine'      => ['UAU', 'UAC'],
               'Cysteine'      => ['UGU', 'UGC'],
               'Tryptophan'    => ['UGG'],
               'STOP'          => ['UAA', 'UAG', 'UGA'] }

  def self.of_codon(codon)
    result = PROTEINS.find { |k, v| v.include? codon }
    raise InvalidCodonError if result.nil?
    result.first
  end

  def self.of_rna(strand)
    raise ArgumentError unless strand.is_a? String

    polypeptide = []
    loop do
      protein = of_codon strand.slice!(0, 3).upcase
      break if protein == 'STOP'

      polypeptide << protein
      break if strand.empty?
    end

    polypeptide
  end
end

class InvalidCodonError < RuntimeError
end
