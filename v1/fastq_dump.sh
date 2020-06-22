#!/bin/bash

cat $src"samples.txt" | while read line; do
  cd $indir
  echo "$indir"
  prefetch --max-size 100gb $line
  cd $indir$line
  echo $line
  fastq-dump --split-files $line".sra"
  pigz *.fastq
  cd $indir
done
