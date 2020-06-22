#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install(version = "3.10") 
#BiocManager::install(c("Biostrings","ShortRead","doParallel","GenomicAlignments","Gviz","GenomicFeatures","Rsubread"))
library(Biostrings)
library(ShortRead)
library(doParallel)
library(GenomicAlignments)
library(Gviz)
library(GenomicFeatures)
library(Rsubread)

genomedir="/media/l/barracuda2/viraltrack/accessories/ref"
#create fasta for STAR genome reference and annotation file for virusite
f=readDNAStringSet(paste(genomedir,"genomes.fasta", sep="/"),format="fasta")
writeXStringSet(f,file=paste(genomedir,"out.fasta", sep="/"),format="fasta",width=60)

f@ranges@NAMES[1]

#split by | and remove , complete genome in Virus_name
strsplit(f@ranges@NAMES[1], split='|', fixed=TRUE)[[1]][4]
Complete_segment_name=unlist(lapply(f@ranges@NAMES, function(x) strsplit(x, split='|', fixed=TRUE)[[1]][4]))
Name_sequence=unlist(lapply(f@ranges@NAMES, function(x) strsplit(x, split='|', fixed=TRUE)[[1]][2]))
Genome_length=unlist(f@ranges@width)
df=data.frame(Name_sequence=Name_sequence, Genome_length=Genome_length, Virus_name=Complete_segment_name, Complete_segment_name=Complete_segment_name)
dim(df)
#write.table(df, file=paste(genomedir,'virusite.tsv', sep="/"), quote=FALSE, sep='\t', row.names = F)

