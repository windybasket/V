#!/bin/bash
source $src"viraltrack/bin/activate"

#cat /media/l/barracuda2/viraltrack/in/fastqs/cov/IW-00_?_S2_L00?_R1_001.fastq.gz > $R1;
#cat /media/l/barracuda2/viraltrack/in/fastqs/cov/IW-00_?_S2_L00?_R2_001.fastq.gz > $R2;

#cat "$fastq_dir"*R1_001.fastq.gz > $R1
#cat "$fastq_dir"*R2_001.fastq.gz > $R2

#fastq_dir=/media/l/barracuda2/viraltrack/in/fastqs/chang/SRR8315736/
#cat "$fastq_dir"*_1.fastq > $R1
#cat "$fastq_dir"*_2.fastq > $R2

cat $src"samples.txt" | while read line
do
  mkdir $outdir$line
  cd $outdir$line
  R1=$indir$line"/"$line"_1.fastq.gz"
  R2=$indir$line"/"$line"_2.fastq.gz"
  #R1_extracted=$outdir$line"/R1_extracted.fastq.gz"
  #R2_extracted=$outdir$line"/R2_extracted.fastq.gz"
  R1_extracted=$R1
  R2_extracted=$R2
# Step 2: Identify correct cell barcodes

#umi_tools whitelist --stdin $R1 \
#                    --bc-pattern=CCCCCCCCCCCCCCCCNNNNNNNNNN \
#                    --3prime \
#                    --log2stderr > $whitelist;

# Step 3: Extract barcodes and UMIs and add to read names
  #umi_tools extract --bc-pattern=$bc_pattern \
  #                  --stdin $R1 \
  #                  --stdout $R1_extracted \
  #                  --read2-in $R2 \
  #                  --read2-out=$R2_extracted \
  #                  --filter-cell-barcode \
  #                  --whitelist=$whitelist
  echo -e "$R2_extracted" > $accessories"Files_to_process.txt"
  echo "$line"
  #touch $accessories"Files_to_process1.txt"
  echo -e "N_thread=14" > $accessories"Parameters1.txt"
  echo -e "Output_directory=\"$outdir$line\"" > $accessories"Parameters2.txt"
  echo -e "Index_genome=\"$ref\"" > $accessories"Parameters3.txt"
  echo -e "Viral_annotation_file=\"$virusite\"" > $accessories"Parameters4.txt"
  echo -e "Name_run=\"$line\"" > $accessories"Parameters5.txt"
  echo -e "Load_STAR_module=FALSE" > $accessories"Parameters6.txt"
  echo -e "Load_samtools_module=FALSE" > $accessories"Parameters7.txt"
  echo -e "Load_stringtie_module=FALSE" > $accessories"Parameters8.txt"
  echo -e "Minimal_read_mapped=50" > $accessories"Parameters8.txt"
  cd $accessories
  cat Parameters?.txt > $accessories"Parameters.txt"
  rm Parameters?.txt
  cd $src
  Rscript Viral_Track_scanning.R $accessories"Parameters.txt" $accessories"Files_to_process.txt"
  cd $outdir
done
#Rscript Viral_Track_transcript_assembly.R /media/l/barracuda2/viraltrack/accessories/Parameters.txt /media/l/barracuda2/viraltrack/accessories/Files_to_process.txt
#Rscript Viral_Track_cell_demultiplexing.R /media/l/barracuda2/viraltrack/accessories/Parameters.txt /media/l/barracuda2/viraltrack/accessories/Files_to_process.txt
