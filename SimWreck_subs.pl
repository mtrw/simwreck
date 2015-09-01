#!/usr/bin/perl

    use strict;
    use warnings;
    use Data::Dumper;
    use Getopt::Std;
    use Bio::SeqIO;


print "\n";

plot_beta(4,8,24,220,301,30);

sub plot_beta
{
    my ($shape , $scale , $minlength , $maxlength , $displen_h , $displen_v) = @_;

    my @cols;
    my @betas;
    for ( 1 .. $displen_h )
    {
	push @betas , beta_pdf(((2*$_)+1)/(2*$displen_h) , $shape , $scale ); # get the right beta function
    }
    my $max = max(@betas);
    @betas = map {($_/$max)*$displen_v} @betas;

    for ( 0 .. $displen_h -1 )
    {
	my $height = nint($betas[$_]);
	my @thiscol = ('#') x $height;
	@thiscol = (@thiscol, (' ') x ($displen_v - $height) );
	push @cols , [@thiscol];
    }

    for my $row (reverse(0 .. scalar @{$cols[0]}-1))
    {
	print map {@$_[$row]} @cols;
	print "\n";
    }

    my $midlength = ($maxlength - $minlength)/2 + $minlength;
    my $gaps = (scalar @cols) - (length $maxlength) - (length $minlength) - (length $midlength);
    my $gap1 = nint ($gaps/2);
    my $gap2 = $gaps-$gap1;

    print '-' x scalar @cols;
    print "\n$minlength" , ' ' x $gap1 , "$midlength" , ' ' x $gap2 , "$maxlength\n";
}




binary_search(3,1..9);

exit;

    sub max #################################################################################################################################################################################################################################################################################
    {
	my $best = shift;
	foreach (@_)
	{
	    ($_ > $best) && ($best = $_)
	}
	$best;
    }


    sub beta_pdf #################################################################################################################################################################################################################################################################################
    {
	(($_[0]**($_[1]-1))*(1-$_[0])**($_[2]-1))#/beta($_[1],$_[2]);
    }
    
    sub nint ##################################################################################################################################################################################################################################################################################
    {
	(($_[0] - int($_[0])) >= 0.5) ? return int($_[0]) + 1 : return int($_[0])
    }
    
    
    sub binary_search
    {
	my $tgt = shift;
	print "In: @_\nTgt: $tgt\n";
	my $l = scalar @_;
	my $a = $l/2;
	my $b = $a - 1;
	my $up = $_[$a];
	my $down = $_[$b];
	my @upper = @_[$a..scalar(@_)-1];
	my @lower = @_[0..$b];
	
	print "Length: $l\nA: $a\nB: $b\nUp: $up\nDown: $down\nLower: @lower\nUpper: @upper\n";
	#(($up >= $tgt) && ($down <= $tgt)) && (return $b); work out logic tree here
	
    }
    
