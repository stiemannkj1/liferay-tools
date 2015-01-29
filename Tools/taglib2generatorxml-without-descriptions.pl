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
s/(\s*)<description>\s*\n\s*.*?\s*\n\s*<\/description/$1<description>$1\t<![CDATA[]]>$1<\/description/gs;
s/name>\s*\n\s*(.*)\s*\n\s*<\/name/name>$1<\/name/g;
s/type>\s*\n\s*(.*)\s*\n\s*<\/type/type>$1<\/type/g;
s/>(\s*)<type>/>\n$1<type>/g;

if (defined $ARGV[1]) { # If you specify a second arg, this script will add a property which specifies that the generator does not need to implement getters/setters for the attribute
	s/(\s*)<type>(.*)<\/type>/$1<type>$2<\/type>$1<generateJava>false<\/generateJava>/g;
}

print "$_";

# while ($_ =~ /description>(.*?)<\/description/g) {
#       print $1;
#       print "\n\n\n";
#       @split = split(/\s*\n\s*/, $1);
#       $description = join(" ", @split);
#       s/$1/$description/;
#}
