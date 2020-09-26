#!/usr/bin/perl -w
# just a little tool I wrote
# Visvaldas Kairys, Vilnius University, Institute of Biotechnology
# Computes molecular weight from GROMACS topology file(s) *itp or *top

use strict;

if(@ARGV==0){
	print "Converts GROMACS topology file(s) (*itp or *top) to molecular weight.\n";
	print "Topology files must contain [ atoms ] section.\n";
	die "Usage: $0 topfile(s)\n";
}


foreach my $file ( @ARGV ){
	#print "topology file $file\n";
	#(my $root = $file) =~ s/(.+)\.[^.]+$/$1/;
	#my ($ext) = $ARGV[0] =~ /(\.[^.]+)$/;


	open(TOPF,"<$file") or die "Error while opening $file $!\n";
	my $numatoms=0;
	my $mw=0;
	while(<TOPF>){
		if(/^\[ atoms \]/ .. /^\s*$/){  #until blank line
			#print $_;
			unless(/^\[ atoms \]/ or /^\s*$/ or /^;/){
				#print $_;
				chomp; my @tmp=split;
				$mw=$mw+$tmp[7];
				#print "$tmp[7] $mw\n";
				$numatoms++;
			}
		}
	}
	print "$file Number of atoms $numatoms molecular weight $mw\n";
}

