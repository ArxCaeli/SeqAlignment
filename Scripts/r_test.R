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


mat <- nucleotideSubstitutionMatrix(match = 1, mismatch = -1, baseOnly = TRUE)
AllPhages[1,]
PhageNames

pairwiseAlignment(SampleSpacers[1,]$Spacers, AllPhages[9,]$Phage, scoreOnly = T, type = "local", substitutionMatrix = mat)
pairwiseAlignment(SampleSpacers[4,]$Spacers, AllPhages[9,]$Phage, scoreOnly = F, type = "local", substitutionMatrix = mat)

getMethod(pairwiseAlignment)


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



AllSpacers = data.frame()

SampleNames[13]
SampleNames[27]
SampleNames

Spacers = readDNAStringSet(Samples[13])
VSSpacers = readDNAStringSet(Samples[27])


Samples[1]
Samples[4]
Spacers = readDNAStringSet(Samples[1]) #mismatch
Target = readDNAStringSet(Samples[4])

Match = vcountPDict(Spacers, Target, with.indels = T, collapse = 0, max.mismatch = 8)
Match = matchPDict(Spacers, Target[[1]], with.indels = T, max.mismatch = 8)

Match
sum(Match)

startIndex(Match)
Match

Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/12_good_1.fasta")
Spacers

AllSpacers = c()

Samples[1]

for (i in 1:length(Samples)) 
{ 
  Sample = read.table(Samples[i])
  Sample = Sample[nchar(as.character(Sample$Spacers)) >= 32,]
  AllSpacers = c(AllSpacers, list(SampleSpacers = DNAStringSet(Sample$Spacers), Quantity = Sample$Freq))  
}

Sample = read.table(Samples[1])
nrow(Sample)
Sample = Sample[nchar(as.character(Sample$Spacers)) >= 32,]


AllSpacers[[3]]

SampleNumber = 1
OtherSampleNumber = 2

SampleSpacers[4]
OtherSampleSpacers[1]
SampleSpacers = AllSpacers[[SampleNumber * 2 - 1]]
SampleSpacersQuantity = AllSpacers[[SampleNumber * 2]]
OtherSampleSpacers = AllSpacers[[OtherSampleNumber * 2 - 1]]
OtherSampleSpacersQuantity = AllSpacers[[OtherSampleNumber * 2]]
AlignmentScoreBoundary = 28

MismatchScore = 32 - AlignmentScoreBoundary

print(paste("Task started: mismatchscore", MismatchScore))

MatchMatrix = matrix(nrow = length(SampleSpacers), ncol = length(OtherSampleSpacers))
MatchMatrix = vcountPDict(SampleSpacers, OtherSampleSpacers, with.indels = T, collapse = F, max.mismatch = MismatchScore)

as.character(SampleSpacers[1])

for (i in 1:length(SampleSpacers))
  SampleSpacers[i] = strtrim(as.character(SampleSpacers[i]), 32)

SampleSpacers

SampleSpacers[1]
= strtrim(as.character(SampleSpacers))

for (i in 1:length(OtherSampleSpacers))
  MatchMatrix[,i] = vcountPDict(SampleSpacers, OtherSampleSpacers[i], with.indels = T, collapse = F, max.mismatch = MismatchScore)

MatchMatrix
Score = sum(MatchMatrix)

vcountPDict(
  DNAStringSet("GAGCCTGGCCGAGAGCAAGCTAACCGACTCGGA"),
  DNAStringSet("AAGAGCCTGGCCGAGAGCAAGCTTTCCGACTCGGACCTG"), 
  with.indels = T, max.mismatch = 2)
