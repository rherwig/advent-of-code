use strict;

my $filename = 'resources/input.txt';

open(FH, '<', $filename) or die $!;

my $contains = 0;
my $overlap = 0;

while(<FH>){
    my $line = $_;

    while($line =~ /(\d+)-(\d+),(\d+)-(\d+)/g) {
        my $min1 = "$1";
        my $max1 = "$2";
        my $min2 = "$3";
        my $max2 = "$4";

        if ($max1 >= $min2 && $min1 <= $max2) {
            $overlap++;
        }

        if (($min1 <= $min2 && $max1 >= $max2) || ($min2 <= $min1 && $max2 >= $max1)) {
            $contains++;
        }
    }
}

print "Total contains: $contains\n";
print "Total overlaps: $overlap\n";

close(FH);
