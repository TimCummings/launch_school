
[comment]: # (protein_translation.md)

# Medium 1-4: Protein Translation - 3/17/2018

Lets write a program that will translate RNA sequences into proteins. RNA can be broken into three nucleotide sequences called codons, and then translated to a polypeptide like so:
```
RNA: "AUGUUUUCU" => translates to

Codons: "AUG", "UUU", "UCU"
=> which become a polypeptide with the following sequence =>

Protein: "Methionine", "Phenylalanine", "Serine"
```
There are 64 codons which in turn correspond to 20 amino acids; however, all of the codon sequences and resulting amino acids are not important in this exercise.

There are also four terminating codons (also known as 'STOP' codons); if any of these codons are encountered (by the ribosome), all translation ends and the protein is terminated. All subsequent codons after are ignored, like this:
```
RNA: "AUGUUUUCUUAAAUG" =>

Codons: "AUG", "UUU", "UCU", "UAA", "AUG" =>

Protein: "Methionine", "Phenylalanine", "Serine"
```
Note the stop codon terminates the translation and the final methionine is not translated into the protein sequence.--

Below are the codons and resulting Amino Acids needed for the exercise.

| Codon             |	Protein       |
|-------------------|---------------|
|AUG	              | Methionine    |
|UUU, UUC	          | Phenylalanine |
|UUA, UUG	          | Leucine       |
|UCU, UCC, UCA, UCG	| Serine        |
|UAU, UAC	          | Tyrosine      |
|UGU, UGC	          | Cysteine      |
|UGG	              | Tryptophan    |
|UAA, UAG, UGA	    | STOP          |

Test suite provided: [protein_translation_test.rb](protein_translation_test.rb)

---
### Solution
[protein_translation.rb](protein_translation.rb)

* Input: string representing one or more RNA codons
* Output: string representing polypeptide translated from input
* Rules/Implicit Knowledge
  - each character represents a nucleotide
    + valid characters from provided table: A, C, G, U
  - three nucleotides compose a sequence called a codon
  - codon translates to a named amino acid protein (see provided table)
  - some codons are terminating or STOP codons; translation should end at end of input or when first STOP codon is reached and translated
* Examples: see [protein_translation_test.rb](protein_translation_test.rb)
* Edge Cases
  - input not string: raise ArgumentError
  - invalid character: raise InvalidCodonError
  - wrong number of nucleotides: raise InvalidCodonError
  - lowercase letter: not specified in tests; upcase each input character when processing
* Data Structure
  - save provided mapping table as hash with protein names as string keys and associated codons as array of strings
  - leave input as string and process three character slice at a time
  - compose polypeptide array while translating
* Algorithm
  - raise ArgumentError unless input is String
  - initialize empty polypeptide array to contain translated proteins
  - while not nil: slice! first three characters and save to codon variable
    + translate codon
      * find hash entry where value includes codon
      * raise InvalidCodonError if result is nil
      * extract and return key (protein name)
    + break if STOP codon
  - join polypeptide array with spaces and return resulting string
