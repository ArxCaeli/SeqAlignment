Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/water_good_2.fasta")

Spacers = Spacers[nchar(as.character(Spacers$Spacers)) > 26,]
max(Spacers$Freq)

head(Spacers[with(Spacers, order(-Freq)), ], 10)

Spacers = Spacers[with(Spacers, order(-Freq)), ]

head(Spacers, 50)

TopSpacer = as.character(Spacers[1,]$Spacers)

ScoreMatrix = vcountPDict(
  DNAStringSet(Spacers$Spacers), DNAStringSet(TopSpacer),
  with.indels = F, collapse = F, max.mismatch = 6)

Indexes = which(ScoreMatrix != 0, arr.ind = T)

SameSpacers = Spacers[Indexes[,1],]

AlignmentRes = pairwiseAlignment(SameSpacers$Spacers, TopSpacer)

Patterns = c()
for (i in 1:length(AlignmentRes))
{
  Patterns = append(Patterns, as.character(pattern(AlignmentRes[i])))  
}
Patterns

Patterns32 = c()
for (i in 1:length(Patterns))
{
  if (nchar(Patterns[i]) == 32)
  {
    Patterns32 = append(Patterns32, Patterns[i])
  }
}

Set = DNAStringSet(Patterns32)
names(Set) = 1:length(Patterns32)
writeFasta(Set, "C:/CRISPr/ThermusToPhage/results/aligmnents/res.fasta")





Spacers = readDNAStringSet("E:/downloads/megaspacers_mam_single.fasta")
Nums = read.table("E:/downloads/num_qbeta.fasta")
Qb = Spacers[Nums$V1]
Qb
writeFasta(Qb, "E:/downloads/qb.fasta")

Qb[1]
Qb[3]
res = pairwiseAlignment(Qb, Qb[1])
class(res[1])
res[6]
class(pattern(res[1]))
length(res)

Patterns
Patterns = c()
for (i in 1:length(res))
{
  Patterns = append(Patterns, as.character(pattern(res[i])))  
}

Patterns32 = c()
for (i in 1:length(Patterns))
{
  if (nchar(Patterns[i]) == 32)
  {
    Patterns32 = append(Patterns32, Patterns[i])
  }
}


Set = DNAStringSet(Patterns32)
names(Set) = 1:length(Patterns32)
writeFasta(Set,  "E:/downloads/qb32aligned.fasta")
