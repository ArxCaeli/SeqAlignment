GenerateTasks = function(Samples, Phages, ScoreStart, ScoreEnd)
{
  tasks <- vector('list')
  n = 1
  for (Score in ScoreStart:ScoreEnd)
  {
    for (i in 1:length(Samples)) 
    { 
      for (j in 1:length(Phages))
      {    
        tasks[[n]] <- list(SampleFileName=Samples[i], PhageFileName = Phages[j], AlignmentScore = Score)  
        n = n + 1  
      }  
    }
  }
  
  return (tasks)
}

GenerateTasksForSpacersVsSpacers = function(Samples, Score)
{
  tasks <- vector('list')
  n = 1
  for (i in 1:(length(Samples)-1)) 
  {     
    for (j in (i + 1):length(Samples))
    {
      if (i != j)
      {
        tasks[[n]] <- list(SampleFileName=Samples[i], OtherSampleFileName = Samples[j], AlignmentScore = Score)  
        n = n + 1
      }
    }  
  }
  
  return (tasks)
}

GenerateTasksForFastMatching = function(Samples, Score)
{
  tasks <- vector('list')
  n = 1
  
  for (i in 1:length(Samples))#1:(length(Samples) - 1)) 
  {     
    for (j in 1:length(Samples))#(i + 1):length(Samples))
    {
      #if (i != j)
      #{
        tasks[[n]] <- list(SampleNumber = i, OtherSampleNumber = j, AlignmentScore = Score)  
        n = n + 1
      #}
    }  
  }
  
  return (tasks)
}

GenerateParticularTasksForFastMatching = function(Score, Rows, Columns)
{
  tasks <- vector('list')
  n = 1
  
  for (i in Rows) 
  {     
    for (j in Columns)
    {
      tasks[[n]] <- list(SampleNumber = i, OtherSampleNumber = j, AlignmentScore = Score)  
      n = n + 1      
    }  
  }
  
  return (tasks)
}



GenerateEmptyMatricies = function(RowsQty, ColsQty, ScoreStart, ScoreEnd)
{
  Matricies <- vector('list')
  for (Score in ScoreStart:ScoreEnd)
  {
    Matricies[[Score - ScoreStart + 1]] = list(ExprMatrix = matrix(ncol = ColsQty, nrow = RowsQty), AlignmentScore = Score)
  }
  
  return (Matricies)
}

GetScore = function(task, AllSpacers)
{
  #return = GetTotalScore(task, AllSpacers)
  #return = GetTotalWeightedScore(task, AllSpacers)
  #return = GetTotalScoreAndSpacers(task, AllSpacers)
  return = GetTotalWeightedFullScores(task, AllSpacers)
}

GetTotalScore = function(task, AllSpacers)
{
  print(paste(task$SampleNumber, task$OtherSampleNumber, "Task Received"))
  
  SampleSpacers = AllSpacers[[task$SampleNumber]]
  OtherSampleSpacers = AllSpacers[[task$OtherSampleNumber]]
  AlignmentScoreBoundary = task$AlignmentScore
  
  MismatchScore = AlignmentScoreBoundary#length(SampleSpacers[[1]]) - AlignmentScoreBoundary
  
  print(paste("Task started: mismatchscore", MismatchScore))
  Score = sum(vcountPDict(SampleSpacers, OtherSampleSpacers, with.indels = T, collapse = 1, max.mismatch = MismatchScore))
  
  return = list(result = Score, SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber)
}

GetTotalScoreAndSpacers = function(task, AllSpacers)
{
  print(paste(task$SampleNumber, task$OtherSampleNumber, "Task Received"))
  
  SampleSpacers = AllSpacers[[task$SampleNumber]]
  OtherSampleSpacers = AllSpacers[[task$OtherSampleNumber]]
  
  print(paste("Task started: mismatchscore", task$AlignmentScore))
  
  ScoreMatrix = vcountPDict(
    SampleSpacers, OtherSampleSpacers,
    with.indels = T, collapse = F, max.mismatch = task$AlignmentScore)
  ScoreMatrix[ScoreMatrix != 0] = 1
  
  NonZeros = which(ScoreMatrix != 0, arr.ind = T)
  ResultMatchingSpacers = data.frame(Spacers = as.character(SampleSpacers[NonZeros[,1]]), OtherSpacers = as.character(OtherSampleSpacers[NonZeros[,2]]))
  
  Score = sum(ScoreMatrix)
  
  return = list(result = Score, SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber, MatchingSpacers = ResultMatchingSpacers)
}


GetTotalWeightedScore = function(task, AllSpacers)
{
  print(paste(task$SampleNumber, task$OtherSampleNumber, "Task Received"))
  
  SampleSpacers = AllSpacers[[task$SampleNumber]]
  OtherSampleSpacers = AllSpacers[[task$OtherSampleNumber]]
  MismatchScore = task$AlignmentScore
  
  print(paste("Task started: mismatchscore", MismatchScore))
  ScoreMatrix = vcountPDict(
    DNAStringSet(SampleSpacers$Spacers), DNAStringSet(OtherSampleSpacers$Spacers),
    with.indels = T, collapse = F, max.mismatch = MismatchScore)
  ScoreMatrix[ScoreMatrix != 0] = 1
  
  ScoreMatrix = ScoreMatrix * SampleSpacers$Qty
  ScoreMatrix = t(t(ScoreMatrix) * OtherSampleSpacers$Qty)
    
  return = list(result = sum(ScoreMatrix), SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber)
}

GetTotalWeightedFullScores = function(task, AllSpacers)
{
  print(paste(task$SampleNumber, task$OtherSampleNumber, "Task Received"))
  
  SampleSpacers = AllSpacers[[task$SampleNumber]]
  OtherSampleSpacers = AllSpacers[[task$OtherSampleNumber]]
  MismatchScore = task$AlignmentScore
  
  print(paste("Task started: mismatchscore", MismatchScore))
  ScoreMatrix = vcountPDict(
    DNAStringSet(SampleSpacers$Spacers), DNAStringSet(OtherSampleSpacers$Spacers),
    with.indels = T, collapse = F, max.mismatch = MismatchScore)
  ScoreMatrix[ScoreMatrix != 0] = 1
  
  #ScoreMatrix = ScoreMatrix * SampleSpacers$Qty
  ScoreMatrix = t(t(ScoreMatrix) * OtherSampleSpacers$Qty)
  
  #message = list(result = ScoreMatrix, SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber)
  return = list(result = ScoreMatrix, SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber)
}

SaveResults = function(HitMatrix, SampleNames)
{
  #colnames(HitMatrix) = SampleNames
  #rownames(HitMatrix) = SampleNames
  
  ResDf = as.data.frame(HitMatrix)
  write.table(ResDf,file = "c:/CRISPr/ThermusToPhage/data/res_score_sampleVSsample.txt")   
}

# UpdateResults = function(ResultObject, message, SampleNames)
# {  
#   ResultObject[message$SampleNumber, message$OtherSampleNumber] = message$result
#   
#   MatchedSpacers = message$MatchingSpacers
#   names(MatchedSpacers) = c(SampleNames[message$SampleNumber], SampleNames[message$OtherSampleNumber])
#   write.table(MatchedSpacers, 
#               file = paste("c:/CRISPr/ThermusToPhage/results/lastresult/", 
#                            paste(SampleNames[message$SampleNumber], SampleNames[message$OtherSampleNumber], sep = "_"),
#                            sep = ""))
#   
#   return = UpdateHitMatrix(ResultObject, message)  
# }

UpdateResults = function(ResultObj, message, AllSpacers)
{
  return = UpdateFullHitMatrix(ResultObj, message, AllSpacers)
  #return = UpdateHitMatrix(ResultObj, message)
}

UpdateHitMatrix = function(HitMatrix, message)
{
  HitMatrix[message$SampleNumber, message$OtherSampleNumber] = message$result
  return = HitMatrix
}

UpdateFullHitMatrix = function(HitMatrix, message, AllSpacers)
{ 
  #HitMatrix = ResultObject
  HitMatrix[GetTopRow(AllSpacers, message$SampleNumber):(GetTopRow(AllSpacers, message$SampleNumber + 1) - 1), message$OtherSampleNumber] = t(rowSums(message$result))  
  #HitMatrix[GetTopRow(AllSpacers, message$OtherSampleNumber):(GetTopRow(AllSpacers, message$OtherSampleNumber + 1) - 1), message$SampleNumber] = t(colSums(message$result))
  
  return = HitMatrix
}

GetTopRow = function(AllSpacers, SampleNo)
{
  TopRow = 1
  if (SampleNo == 1)
  {
    return(1)
  }
  
  for (i in 1:(SampleNo - 1))
  {
    TopRow = TopRow + nrow(AllSpacers[[i]])
  }
  
  return(TopRow)
}

loadWeightedSpacers = function(Samples, NormTargetVector)
{  
  AllSpacers = List()

  for (i in 1:length(Samples)) 
  {
    # commented because not supported
    # if (file.info(Samples[i])$size < 10)
    #   next

    Spacers = read.csv(Samples[i], sep = ";", header = F)
    names(Spacers) = c("Spacers", "Qty")
    
    #Spacers$Qty = as.vector(normalize.quantiles.use.target(as.matrix(Spacers$Qty), NormTargetVector))
    
    AllSpacers[[i]] = Spacers  
  }
    
  return = AllSpacers
}

makeFullResultObjForWeightedSpacers = function(AllSpacers, SampleNames)
{
  ResultObject = matrix(ncol = length(Samples))
  colnames(ResultObject) = SampleNames 
  
  for (i in 1:length(SampleNames))
  {  
    Spacers = AllSpacers[[i]]
    
    TmpMatr = matrix(ncol = length(SampleNames), nrow = nrow(Spacers), data = 0)
    TmpMatr[1:nrow(Spacers), i] = 0#Spacers$Qty*Spacers$Qty
    rownames(TmpMatr) = Spacers$Spacers
    ResultObject = rbind(ResultObject, TmpMatr)  
  }
  
  ResultObject = ResultObject[-1,]
  
  return = ResultObject 
}
