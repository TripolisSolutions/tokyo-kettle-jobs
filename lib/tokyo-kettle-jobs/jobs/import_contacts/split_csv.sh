#!/bin/sh
in_file=$1
chunk_size=$2
awk '{if (NR!=1) {print}}' $in_file | split -d -a 5 -l $chunk_size - $in_file"_" # Get all lines except the first, split into 100,000 line chunks
for file in $in_file"_"*
do
    tmp_file=$(mktemp $in_file.XXXXXX) # Create a safer temp file
    head -n 1 $in_file | cat - $file > $tmp_file # Get header from main file, cat that header with split file contents to temp file
    mv -f $tmp_file $file # Overwrite non-header containing file with header-containing file
done


