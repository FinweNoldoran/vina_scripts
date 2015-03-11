#!/usr/bin/perl

use warnings;
use strict;

use Tie::File;

my $top = shift || 10;

my @directories;

my $curdir = `pwd`;
chomp($curdir);
    
my $dir = 'fda/pdbqt';

    opendir(DIR, $dir) or die $!;

    while (my $file = readdir(DIR)) {

        # A file test to check that it is a directory
	# Use -f to test for a file
        next unless (-d "$dir/$file");
	next if $file eq '.' or $file eq '..';
	push @directories, $file;

    }

closedir(DIR);

#print join(',', @directories);#works

my %hash;
my @zinc;
my @directs;


foreach my $d (@directories){ #outer loop, find all the ZINC directories

    
    my $dest="$dir/$d";
    #print $dest;
    opendir(DIR, $dest) or die $!;
    #print $dest;#works

   while (my $fil = readdir(DIR)) {
        # A file test to check that it is a directory
	# Use -f to test for a file
        next unless (-d "$dest/$fil");
	next if $fil eq '.' or $fil eq '..';
	push @directs, "$dest/$fil"; #only fills up first one?
   }
    closedir(DIR);
}

#print join(',', @directs);


    foreach my $d2 (@directs){ #inner loop

	chdir("$d2");
	tie my @zinc, 'Tie::File', 'out.pdbqt' or die "$!"; 
	my $lof = $zinc[1];
	my @vals = split(':', $lof); #remove text
	my $w = $vals[1];
	my @v2= split(/\s\d/,$w); #isolate energy
	my $wt = $v2[0];
	$wt =~ s/^\s+|\s+$//g; #remove leading and trailing whitespace
	$hash{$d2}=$wt;
	chdir($curdir);
	untie @zinc;
	chdir($curdir);

  }
    

my @keys = sort { $hash{$a} <=> $hash{$b} } keys %hash;

for (my $i = 0; $i < $top; $i++) {
    print "$keys[$i] $hash{$keys[$i]}\n";
}
