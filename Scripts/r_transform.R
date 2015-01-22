# transform fasta to spacer/qty csv

library(Biostrings)
library(ShortRead)

DataFolder = "C:/CRISPr/ThermusToPhage/data/extra/spacers/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/extra/spacers_tables"
DataFolder = "E:/downloads/renamed/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/spacers_renamed/"

Samples = list.files(DataFolder, full.names=TRUE, recursive = T)
Samples = Samples[7]
i = 7
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
  #SpacersDF = SpacersDF[SpacersDF$Freq > 1,]
  SpacersDF$Spacers = as.character(SpacersDF$Spacers)
  SpacersDF = SpacersDF[!grepl("N", SpacersDF$Spacers),]
  
  write.table(SpacersDF, 
              file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))
#   ,
#               col.names = F, row.names = F,
#               sep = ";", quote = F)
#   
#   #to do: write fasta due to different distributions 
#   Parts = 3
#   SampleSize = nrow(SpacersDF) / Parts
#   for (j in 1:Parts)
#   {
#     RowsNos = c(1 : SampleSize) 
#     SpacersSet = SpacersDF[RowsNos,]
#     SpacersDF = SpacersDF[-RowsNos,]
#     write.table(SpacersSet, 
#                 file = paste(NewSamplesFolder, sep = "/", paste(basename(Samples[i]), j, sep = "_")),
#                 col.names = F, row.names = F,
#                 sep = ";", quote = F)
#   }  
}

DataFolder = "C:/CRISPr/ThermusToPhage/data/extra/spacers/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/Spacers/"

Samples = "E:/downloads/qb.fasta" #list.files(DataFolder, full.names=TRUE, recursive = T)
Samples = list.files(DataFolder, full.names=TRUE, recursive = T)


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
DataFolder = "E:/downloads/clustersFiltered/resFiltered"

NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/extra/Slon3"

Samples = list.files(DataFolder, full.names=TRUE, recursive = T)

library(ShortRead)

for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next
  
  Spacers = read.csv(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
  
  Parts = 5
  SampleSize = nrow(SpacersDF) / Parts
  for (j in 1:Parts)
  {
    RowsNos = sample(1:nrow(SpacersDF), SampleSize, replace = F)
    SpacersSet = DNAStringSet(SpacersDF[RowsNos,]$Spacers)
    SpacersDF = SpacersDF[-RowsNos,]
    writeFasta(SpacersSet, file = paste(NewSamplesFolder, sep = "/", paste(j, basename(Samples[i]), sep = "_")))
  }
}

#to fasta from tables
DataFolder = "C:/CRISPr/ThermusToPhage/data/spacers/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/spacers/fasta/"

Samples = list.files(DataFolder, full.names=TRUE, recursive = T)

for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next
  
  SpacersDF = read.table(Samples[i])
  SpacersSet = DNAStringSet(SpacersDF$Spacers)
  writeFasta(SpacersSet, file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))  
}

temp = read.table(Samples[1])
temp[1,]



# #for weighted clusters
# DataFolder = "C:/CRISPr/ThermusToPhage/data/ClustersWeighted/"
# NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/ClustersWeighted/fasta"
# 
# Samples = list.files(DataFolder, full.names=TRUE, recursive = T)
# 
# Spacers = read.csv(Samples[1], sep = ";")
# names(Spacers) = c("Spacers", "Qty")
# Spacers[1,]
# Table = table(Spacers)
# SpacersDF = as.data.frame(Table) 
# 
# 
# SpacersDF[,1]
# 
# for(i in 1:length(Samples))
# {
#   if (file.info(Samples[i])$size == 0)
#     next
#   
#   Spacers = read.csv(Samples[i])
#   Table = table(Spacers)
#   SpacersDF = as.data.frame(Table) 
#   
#   SpacersDF = read.table(Samples[i])
#   SpacersSet = DNAStringSet(SpacersDF$Spacers)
#   writeFasta(SpacersSet, file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])))  
# }
# 
# temp = read.table(Samples[1])
# temp[1,]
# 
# 

LeadersDataFolder = "C:/CRISPr/ThermusToPhage/data/leaders/"
NewSamplesFolder = "C:/CRISPr/ThermusToPhage/data/LeadersCsv/"
Samples = list.files(LeadersDataFolder, full.names=TRUE, recursive = T)

Fasta = readDNAStringSet(Samples[1])
class(Fasta)
as.character(Fasta)

FastaSet = data.frame(as.character(Fasta))
FastaSet$Qty = 1
FastaSet

for(i in 1:length(Samples))
{
  if (file.info(Samples[i])$size == 0)
    next

  Fasta = readDNAStringSet(Samples[i])
  FastaSet = data.frame(as.character(Fasta))
  FastaSet$Qty = 1
  write.table(FastaSet, file = paste(NewSamplesFolder, sep = "/", basename(Samples[i])), col.names = F, row.names = F, sep = ";")
}
