#!/usr/bin/perl

#This script will run autodoc vina for a Zinc library. use the dir scalar to indicate the location of the pdbqt0, pdbqt1 etc. folders


use strict;
use warnings;
   

my @directories;

my $inter = $ARGV[0];

my $dir = "$inter/pdbqt";

    opendir(DIR, $dir) or die $!;

    while (my $file = readdir(DIR)) {

        # A file test to check that it is a directory
	# Use -f to test for a file
        next unless (-d "$dir/$file");
	next if $file eq '.' or $file eq '..';
	push @directories, $file;

    }

closedir(DIR);

#print join(", ", @directories);

#chdir('fda') or die "$!";chdir();

my $curdir = `pwd`;
chomp($curdir);


my $filename = 'conf.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

my $row = <$fh>;
my @words = split(/ /, $row);
my $conf= $words[2];
chomp($conf);


foreach my $l (@directories){
   chdir("$dir/$l") or die "$!";
   system("cp $curdir/vina_screen_local.sh vina.sh");
   system("cp $curdir/conf.txt conf.txt");
   system("cp $curdir/$conf $conf");
   system("chmod 755 vina.sh");
   system("./vina.sh");
   chdir($curdir) or die "Cant get to $curdir $!";
}

