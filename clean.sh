#!/bin/bash

infile=$1
outfile="summary_$infile"

echo "Cleaning file $infile"
echo "Output file is $outfile"

# Put the header, all instances of "*" with some context,
# and the last 35 lines of the file into summary...
head -n 9 $infile > $outfile
echo "--" >> $outfile
grep -C 10 "*" $infile >> $outfile
echo "--" >> $outfile
tail -n 35 $infile >> $outfile
# The reason for appending the last 35 lines is that there
# are a maximum of 30 hops, so we'll be sure to get a report
# of the time before the end of the file even if it has
# taken the maximum number of hops.
