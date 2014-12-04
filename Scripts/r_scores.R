#sample vs phage scoring

GetAlignmentScore = function(PhageFasta, Spacers)
{
  res = 0
  for (i in 1:nrow(Spacers))
  {
    score = pairwiseAlignment(Spacers[i,]$Spacers, PhageFasta, scoreOnly = T, type = "local")
    res = res + score / nchar(as.character(Spacers[i,]$Spacers)) / 2        
  }
  
  return (res)
}

GetSamplePhageScore = function(SampleFastaFileName, PhageFastaFileName)
{
#   Spacers = readDNAStringSet(SampleFastaFileName)
#   Table = table(Spacers)
#   SpacersDF = as.data.frame(Table) 
#   Phage = readDNAStringSet(PhageFastaFileName)
#   return (GetAlignmentScore(SpacersDF, Spacers))
  
  return (1)
  
  #Spacers = read.table(Samples[SampleId])
  #Phage = readDNAStringSet(Phages[j])
  #Expression_Matrix[SampleId,PhageId] = GetSampleScore(Phage, Spacers)
}

# 
# for(i in 1:length(Samples))
# {  
#   Spacers = read.table(Samples[i])
#   
#   for(j in 1:length(Phages))
#   {
#     Phage = readDNAStringSet(Phages[j])
#         
#     Expression_Matrix[i,j] = GetSampleScore(Phage, Spacers)
#   }
# }