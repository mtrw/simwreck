README SimWreck V1.0

Mark Timothy Rabanus-Wallace
November 2015
Australian Centre for Ancient DNA (ACAD)


______________________________
An aDNA read simulator for testing analysis pipelines.
Give it a genome and describe to it what condition the reads will be in.
Face the STDOUT and prepare to catch your sequences.
______________________________


SYNOPSIS:

SimWreck -i genome.fasta -n50 > wreckedreads.fasta #fifty damaged short reads with default parameters
SimWreck -i genome.fasta -X -d.5 -D.15 #apply deamination damage to each sequence
nohup parallel 'SimWreck -i {} -n1000000 -d.3 -D.4 -s4 -S12 -m20 -M180 -p2 -b.02 > {\.}wrecked.fasta' ::: \*genome.fasta & #one million reads each from all \*genome.fasta, produced in parallel, with customised parameters
SimWreck -P -s4 -S12 -m20 -M180 -a120 -u25 #look at the read length distribution
        
ARGUMENTS:  [interval] (default)    Description
    
General
    
-i				Genome file to make reads from, in fasta format.
-n      [1,+inf) (10000) 	Number of reads desired.
-r      [0,1] (.5)      	Proportion of minus strand reads.    
-X                  		Damage-only mode. Returns each input sequence whole, with damage added as per any damage parameters specified.

Size distribution
    
-s      (0,+inf) (4)        	Shape parameter (alpha).
-S      (0,+inf) (4)        	Scale parameter (beta).
-m      [0,+inf) (80)       	Nucleotide length at left end of beta distribution.
-M      (0,+inf) (280)      	Nucleotide length at right end of beta distribution.
    
Damage
    
-p      [0,+inf) (3)       	Depurination weight parameter. Ratio of nicks that occur 3' of a purine:3' of a pyrimidine. (e.g. at 2, it   is twice as likely that a strand will begin or end with a purine).
-d      [0,+inf) (.3)      	Deamination weight parameter, influencing how frequently deamination results in pseudomutations.
-D      [0,+inf) (.5)      	Deamination decay parameter, influencing how the rate of deamination decays further from the ends of the     sequence.
-b      [0,-d] (.01)       	Baseline rate of deamination.
    
Plot Funtion
    
-P                  		Plot mode. Plots the shape of the beta distribution requested by parameters -s, -S, -, and -M.
-a      [0,+inf) (120)     	Plot width in characters.
-u      [0,+inf) (45)      	Plot height in characters.

TUTORIAL:

Welcome to SimWreck. If you suspect your analysis is being biased by the effects of DNA damage, this program will produce data that can help explore this suspicion.

SimWreck can a produce NGS reads that have a smiler damage profile to your library. You just have to tell it what that damage profile is like.
First up, you can adjust the length distribution of reads using -m,-M,-s, and -S. To explore what shapes are possible, try visualising a few curves …
SimWreck -P -a80 -u30 -s4 -S4
SimWreck -P -a80 -u30 -s4 -S8
SimWreck -P -a80 -u30 -s8 -S4
SimWreck -P -a80 -u30 -s2 -S2
SimWreck -P -a80 -u30 -s1 -S1
SimWreck -P -m20 -u25 -s1 -S4

You can change the size of the plot with -a (pixels across) and -u (up).


… when satisfied with the curve, set the length range to your satisfaction by adjusting -m and -M.


Once done, have a look at your MapDamage profile.
To set the deamination parameters, look at the deamination frequency curves.
The intercept with the y-axis can be entered as -d.
If the curve “bottoms out” at a particular value, enter it as -b.
The rate at which the curve decays from -d to -b is influenced by -D (higher=decaying faster). Default is usually pretty good, but values from .1 to 2 cover the range seen in most empirical damage profiles.
To set the deprivation, compare the frequency of C/T to that of A/G at they first position before/after the reads. Work out the purine:pyrimidine ratio (i.e. if it’s 70% A/G and 30% C/T, the ratio is .7/.3 ~= 2.3) and enter it as -p.

Now set the number of reads (-n) and specify the input genome (-i). Redirect stdout to a file and run the program.

SimWreck produces reads that overlap the ends of the reference as well as those that fall entirely within it. When a read overlaps an end, the unknown nucleotides are assigned “N” - so if you’ve requested high coverage (or given a very short reference sequence), a portion of the reads will be N-heavy.

Perhaps you’d like to see whether your analysis results would change if your reads had more deamination damage. In this case, use the -X flag. You may set the deamination parameters -d, -D, and -p, and give the program your reads with -i. Deamination will be applied according to the described profile.