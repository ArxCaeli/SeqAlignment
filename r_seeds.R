Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/water_good_2.fasta")
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/Spacers/mud_good_2.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/Spacers/9_good_1.fasta"))

Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/9_good_1.fasta")
Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/mud_good_2.fasta")
Spacers = read.table("C:/CRISPr/ThermusToPhage/data/Spacers/qb.fasta")

Spacers = read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/9_good_hybrid.fasta")
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/water_good_hybrid.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/mud_good_hybrid.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/12_good_hybrid.fasta"))

Spacers = read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/water_good_I-E.fasta")
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/mud_good_I-E.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/9_good_I-E.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/12_good_I-E.fasta"))

Spacers = read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/water_red.fasta")
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/mud_red.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/etna9_red_1.fasta"))
Spacers = rbind(Spacers, read.table("C:/CRISPr/ThermusToPhage/data/spacers_renamed/etna12_red_1.fasta"))

Spacers = Spacers[nchar(as.character(Spacers$Spacers)) > 26,]



PhageSpacers = readDNAStringSet("E:/Downloads/I-E_vesuvio_phiko.fasta")
PhageSpacers = as.character(PhageSpacers)
PhageSpacers

SamplePhageSpacers = Spacers[Spacers$Spacers %in% PhageSpacers, ]
SamplePhageSpacers


GoodSpacers = Spacers[nchar(as.character(Spacers$Spacers)) >= 32,]
SamplePhageSpacers = Spacers
SamplePhageSpacers = head(GoodSpacers[with(GoodSpacers, order(-Freq)), ], 1000)
SamplePhageSpacers = head(Spacers[with(Spacers, order(-Freq)), ], 200)

head(Spacers, 20)
TopSpacer = as.character(Spacers[1,]$Spacers)

Errors = c(rep.int(0, 32))
Left = nrow(SamplePhageSpacers)

Extract checked records,
Normalize by length

for (TopSpacer in SamplePhageSpacers$Spacers)
{
  Left = Left - 1
  print(Left)
  
  if (nchar(TopSpacer) > 32)
  {    
    TopSpacer = substr(TopSpacer, 1, 32)
  }
  
  ScoreMatrix = vcountPDict(
    DNAStringSet(Spacers$Spacers), DNAStringSet(TopSpacer),
    with.indels = F, collapse = F, max.mismatch = 1)
  
  Indexes = which(ScoreMatrix != 0, arr.ind = T)
  
  SameSpacers = Spacers[Indexes[,1],]
  
  if (nrow(SameSpacers) != 0)
  {      
    AlignmentRes = pairwiseAlignment(SameSpacers$Spacers, TopSpacer)
    
    print(TopSpacer)
    
    Patterns = c()
    for (i in 1:length(AlignmentRes))
    {
      #Patterns = append(Patterns, paste(as.matrix(AlignmentRes)[1,], collapse = ""))
      Patterns = append(Patterns, as.character(pattern(AlignmentRes[i])))  
    }
            
    Patterns32 = c()
    for (i in 1:length(Patterns))
    {
      if (nchar(Patterns[i]) == 32)
      {
        Patterns32 = append(Patterns32, Patterns[i])
      }
    }
    
    if (length(Patterns32) > 0)
    {
      for (Pat in Patterns32)
      {
        for (i in 1:nchar(Pat))
        {
          if (substr(Pat, i, i) != substr(TopSpacer, i, i))
          {
            Errors[i] = Errors[i] + 1  
          }    
        }
      }
      
      Set = DNAStringSet(Patterns32)
      names(Set) = 1:length(Patterns32)
      writeFasta(Set, paste("C:/CRISPr/ThermusToPhage/results/aligmnents/", TopSpacer, ".fasta", sep = ""))
    }
  }
}

Errors1 = Errors
Errors = Errors1
Errors2 = Errors
Errors3 = Errors
Errors = Errors3

Errors6 = Errors
Errorsh6 = Errors
Errorsie6 = Errors
Errors

plot(Errors)
hist(Errors, freq = F)

library(ggplot2)

df = data.frame(Pos = 1:32, Errors = Errors)
df

ggplot(data = df) + 
  geom_bar(data = df, aes(Pos, Errors), 
           stat = "identity", position = "identity",
           fill="blue", colour="grey")

TopSpacer
Patterns32[1] = "TTCAGGGGCTCCGGCGGAAGCACTTCCTCCGG"
Patterns32[1]
Errors





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






InitSpacers = Spacers 
Spacers = InitSpacers
Spacers = Spacers[with(Spacers, order(-Freq)), ]
nrow(Spacers[nchar(as.character(Spacers$Spacers)) == 32,])

Spacers = Spacers[nchar(as.character(Spacers$Spacers)) == 32,]

ErrorsDistr = data.frame()

for (i in 1:1000)
{
  print(i)
  if (nrow(Spacers) == 0)
  {
    break
  }
    
  TopSpacer = as.character(Spacers[1,]$Spacers)
  ScoreMatrix = vcountPDict(
    DNAStringSet(Spacers$Spacers), DNAStringSet(TopSpacer),
    with.indels = F, collapse = F, max.mismatch = 6)
  
  Indexes = which(ScoreMatrix != 0, arr.ind = T)
  
  SameSpacers = Spacers[Indexes[,1],]
  Spacers = Spacers[-Indexes[,1],]
    
  if (nrow(SameSpacers) != 0)
  {      
    AlignmentRes = pairwiseAlignment(SameSpacers$Spacers, TopSpacer)
    print(TopSpacer)
    
    Summary = mismatchSummary(AlignmentRes)
    mismatchTable(AlignmentRes)
    
    class(Summary)
    class(Summary[[1]][1])
    
    Mat = as.matrix(AlignmentRes)
    Mat[Mat == "A"] = as.numeric(1)
    Mat[Mat == "T"] = 2
    Mat[Mat == "C"] = 3
    Mat[Mat == "G"] = 4
    Mat = as.numeric(Mat)
    class(Mat) = "numeric"
    Mat
    
    is.numeric(matrix(c(1,1)))
    
    heatmap.2(Mat, trace = "none", Colv=FALSE,  
              col = brewer.pal(9,"Oranges"),
              #cexRow = 1, cexCol = 1,
              srtCol=45, offsetCol = -0.8)
    
    SpacerErrorsDistr = data.frame(
      ErrorsCount = rep(0, nchar(TopSpacer)), 
      ErrorPosition = c(0:(nchar(TopSpacer) - 1)) / (nchar(TopSpacer) - 1),
      SpacerLength = rep(nchar(TopSpacer), nchar(TopSpacer)))
          
    for (i in 1:nchar(TopSpacer))
    {
      MatchMatr = as.matrix(AlignmentRes)
      Column = MatchMatr[,i]
      SpacerErrorsDistr[i,]$ErrorsCount = length(Column[Column != substr(TopSpacer, i, i)])          
    }
    
    ErrorsDistr = rbind(ErrorsDistr, SpacerErrorsDistr)
  }
}

ErrorsDistr

ErrorsDistr[ErrorsDistr$ErrorPosition >= 1,]$ErrorPosition = 0.99999
ggplot(data = ErrorsDistr) +
  geom_histogram(aes(x = ErrorPosition, weight = ErrorsCount), stat = "bin", binwidth = 0.01, fill="blue", colour="grey") +
  xlim(0, 1)
  

1/32
