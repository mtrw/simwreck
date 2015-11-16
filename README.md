# simwreck
This is THE README FILE FOR SimWreck V1.0


Mark Timothy Rabanus-Wallace
November 2014

Australian Centre for Ancient DNA (ACAD)

====================================================================================================

######### BETA VERSION #########

BUGS/ISSUES:

Current README file doesn't contain any useful information.

###############################



=====================================================================================================

SYNOPSIS: SimWreck -i genome.fasta > ancient_reads.fasta
          nohup parallel 'Simwreck.pl -i {} -n1000000 -u4 -l20 -r1.5 -B2.5 -D1E10 -b.25 -d.3 -s.95 -m.1 -N5 > {\.}_wrecked.fasta' ::: *_genome.fasta &


ARGUMENTS {range} [default]:

-i  Input genome file in fasta format

-n  Number of reads desired { 0,inf } [10,000]

-b  Frequency of single-strand nicks. This parameter represents a combination of time and preservation { >0,inf } [.4]

-d  Frequency of deamination. This parameter represents a combination of time and preservation { >0,inf } [.5]

-s  Frequency of separation. This parameter represents a combination of time and preservation { >0,inf } [.5]

-l  Minimum theoretical length of reads { >0,inf } [15]

-m  "Hardness" of minimum length cutoff. As it increases, more reads closer to but above to the threshold length will pass { >0,inf } [.05]

-r  Ratio of p(ss nick occuring 3' of a purine) : p(ss nick occurring 3' of a pyramidine) { >0,inf } [3]

-B  Ratio of Bond Strength (purine) : Bond Strength (pyramidine) { >0,inf } [4]

-D  Ratio of p(deamination | ss) : p(deamination | ds) { >0,inf } <1E9>

-u  Minimum length of ds portion of a fragment for the amplification step to occur { 0,inf } [6]

-N  Maximum number of tandem Ns allowed in a sequence before the sequence is split up and the Ns discarded { >0,inf } [4]

-v  Verbose: Reports each iteration

-V  Debug-mode reporting

-h  Putatively-helpful information


