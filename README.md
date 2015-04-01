# simwreck
This is simwrecEADME FILE FOR SimWreck.pl

Mark Timothy Rabanus-Wallace
November 2014

Australian Centre for Ancient DNA (ACAD)

====================================================================================================

######### BETA VERSION #########

BUGS/ISSUES:

~Arguments legitimitely entered as "0" change to defaults (as 0 in logical test = FALSE)

~Will accept some arguments that will result on no sequence data

~Reports progress at different intervals dependent on input. Harmless but stupid.

i###############################

SimWreck is a bottom-up DNA damage simulator written in Perl5. It takes a genomes or long strands of dsDNA in .fasta format, and simulates the effects of the following processes:

NICK: Breaks in the sugar-phosphate backbone of each strand.

    These breaks have some dependency on the context - specifically, they are more likely to occur immediately 3' of a purine.

SEPARATION: The separation of nicked dsDNA into fragments with 3' and 5' overhangs.

    This results in several possible arrangements:
                     ______________________
        Blunt ends:  ______________________

                       ______________
        5' overhangs:     ____________________

                          _________________
        3' overhangs:  _______________

                                    ______________ 
        Single Strands:  _________    

                                     ___       ________   _______________
        Combinations of the above:  ______   __________           ____

CYTOSINE DEAMINATION: The conversion of cytosine residues into uracils by post-mortem hydrolysis.

    This process is far more frequent in single-stranded overhangs than in double-stranded sections.

AMPLIFICATION: The inclusion or excusion of fragment sections based upon the action of sequencing library preparation enzyme T4 Polymerase.

    T4 cleaves off 3' overhangs and extends the 3' strand over 5' overhangs. Uracils introduced by cytosine deamination are paired with adenine which, when amplified, is subsequently paired with thymine. As a result, deaminated cytosines are result in apparent C->T mutations at the 5' ends of reads, and G->A mutations at the 3' ends.

5' - XXXCXXX                XXXUXXX                XXXUXXX                                XXXTXXX  - 3'
     ||||||| (deamination)  |||||||  (extension)   |||||||   (amplification) |||||||  ->  |||||||
3' -                                               YYYAYYY                   YYYAYYY      YYYAYYY  - 5'

SIZE SELECTION: The preferential exclusion of short fragments during library preparation.

    This occurs largely in the various purification steps.

=====================================================================================================

SYNOPSIS: SimWreck.pl -i genome.fasta > ancient_reads.fasta
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


