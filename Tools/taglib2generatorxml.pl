#!/usr/bin/perl

use strict;
use warnings;
use File::Slurp;

# my $description;
# my @split;

#TODO make this work from any directory
print "\nReading File.";
$_ = read_file($ARGV[0]);
print "\nFile read.";

# TODO create a backup copy and print to file

s/\s*<required>\s*\n*\s*.*\s*\n*\s*<\/required>\s*\n//g;
s/description>\s*\n\s*(.*?)\s*\n\s*<\/description/description>$1<\/description/gs;

# while ($_ =~ /description>(.*?)<\/description/g) {
#       print $1;
#       print "\n\n\n";
#       @split = split(/\s*\n\s*/, $1);
#       $description = join(" ", @split);
#       s/$1/$description/;
#}

s/name>\s*\n\s*(.*)\s*\n\s*<\/name/name>$1<\/name/g;
s/type>\s*\n\s*(.*)\s*\n\s*<\/type/type>$1<\/type/g;
s/(\s*)<type>(.*)<\/type>/\n$1<inputType>$2<\/inputType>\n$1<outputType>$2<\/outputType>/g;

if (defined $ARGV[1]) {
	s/(\s*)<outputType>(.*)<\/outputType>/$1<outputType>$2<\/outputType>$1<componentPropertyRequired>false<\/componentPropertyRequired>/g;
}

print "$_";
