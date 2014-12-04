# transform fasta to spacer/qty csv

library(Biostrings)
library(ShortRead)

DataFolder = "E:/downloads/documents-export-2014-10-26/"

NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/Spacers/"


Samples = list.files(DataFolder, full.names=TRUE, recursive = T)
Samples
Spacers = readDNAStringSet(Samples[1])
Spacers
Table = table(Spacers)
SpacersDF = as.data.frame(Table) 
head(SpacersDF$Spacers)

#for fasta
for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next
  
  FileCheck = read.table(Samples[i], nrows = 1)
  
  if (substr(FileCheck[[1]],0,1) != ">")
    next
  
  Spacers = readDNAStringSet(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
  write.table(SpacersDF, file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))
}

#for nonfasta
for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next
  
  FileCheck = read.table(Samples[i], nrows = 1)
  
  if (substr(FileCheck[[1]],0,1) == ">")
    next
  
  Spacers = read.csv(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
  write.table(SpacersDF, file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))
}

#to fasta
DataFolder = "E:/downloads/data14/resAll/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/Clusters/Slon"

library(ShortRead)


for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next
  
  Spacers = read.csv(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
    
  writeFasta(DNAStringSet(SpacersDF$Spacers), file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))
}
