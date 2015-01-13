#helper stuff
library(Biostrings)

Spacers = sapply(1:2000, function(x) paste(sample(c("A", "C", "G", "T"), 32, replace=TRUE,prob=c(0.25, 0.25, 0.25, 0.25)), collapse=""))
Spacers

#x # will print x
#alphabetFrequency(x,baseOnly=TRUE)   # Will print base composition in numbers

Spacers = DNAStringSet(Spacers)

Table = table(Spacers)
SpacersDF = as.data.frame(Table) 
SpacersDF$FileName = "Random"

SampleSpacers = SpacersDF

AllPhages = data.frame()
for (j in 1:length(Phages))
{    
  Phage = readDNAStringSet(Phages[j])
  PTable = table(Phage)
  Pdf = as.data.frame(PTable)
  Pdf$FileName = Phages[j]
  
  AllPhages = rbind(AllPhages, Pdf)
}

nrow(AllPhages)
Scores = rep(0, nrow(AllPhages))
Scores
for (j in 1:nrow(AllPhages))
{
  print(j)
  for (i in 1:nrow(SampleSpacers))
  {
    Aligment = pairwiseAlignment(SampleSpacers[i,]$Spacers, AllPhages[j,]$Phage, scoreOnly = T, type = "local", substitutionMatrix = mat)
    if (Aligment[1] > 26)
      Scores[j] = Scores[j] + 1# Aligment / nchar(as.character(SampleSpacers[i,]$Spacers)) / 2        
  }
}



AlignmentScores = read.table("c:/CRISPr/ThermusToPhage/data/res.txt")
AlignmentScoresMatrix = data.matrix(AlignmentScores)
AlignmentScoresMatrix

AlignmentScoresMatrix = rbind(AlignmentScoresMatrix, Scores)

Scores

ResDf = as.data.frame(AlignmentScoresMatrix)
write.table(ResDf,file = "c:/CRISPr/ThermusToPhage/data/res_test3.txt")


Spacers = sapply(1:10000, function(x) paste(sample(c("A", "C", "G", "T"), 32, replace=TRUE,prob=c(0.25, 0.25, 0.25, 0.25)), collapse=""))
Spacers = DNAStringSet(Spacers)
if (length(Spacers) > 1)
  names(Spacers) = c(1:length(Spacers))

library(ShortRead)
writeFasta(Spacers, "c:/CRISPr/ThermusToPhage/data/Clusters/random_spacers.fasta")


vcountPDict(
  DNAStringSet(c("GAGCCTGGCCGAGA","AAGAGCCTGGCCGAGAGCAAGCTTTCCGACTCGGACCTG")),
  DNAStringSet(c("GAGCCTGGCCGAGA","GCAAGCTAACCGACTCGGA")),   
  with.indels = T, max.mismatch = 2)

AlignmentScores = read.table("c:/CRISPr/ThermusToPhage/data/res_score_sampleVSsample.txt")
AlignmentScoresMatrix = data.matrix(AlignmentScores)

res = which(AlignmentScoresMatrix != 0, arr.ind = T)
res[1,]



#debug
task <- list(SampleNumber = 2, OtherSampleNumber = 3, AlignmentScore = Score)  

