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
  
  for (i in 1:(length(Samples) - 1)) 
  {     
    for (j in (i + 1):length(Samples))
    {
      if (i != j)
      {
        tasks[[n]] <- list(SampleNumber = i, OtherSampleNumber = j, AlignmentScore = Score)  
        n = n + 1
      }
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
  return = GetTotalScore(task, AllSpacers)
}

GetTotalScore = function(task, AllSpacers)
{
  print(paste(task$SampleNumber, task$OtherSampleNumber, "Task Received"))
  
  SampleSpacers = AllSpacers[[task$SampleNumber]]
  OtherSampleSpacers = AllSpacers[[task$OtherSampleNumber]]
  AlignmentScoreBoundary = task$AlignmentScore
  
  MismatchScore = length(SampleSpacers[[1]]) - AlignmentScoreBoundary
  
  print(paste("Task started: mismatchscore", MismatchScore))
  Score = sum(vcountPDict(SampleSpacers, OtherSampleSpacers, with.indels = T, collapse = 1, max.mismatch = MismatchScore))
  
  Result <- list(result = Score, SampleNumber = task$SampleNumber, OtherSampleNumber = task$OtherSampleNumber)
}

SaveResults = function(HitMatrix, SampleNames)
{
  colnames(HitMatrix) = SampleNames
  rownames(HitMatrix) = SampleNames
  
  ResDf = as.data.frame(HitMatrix)
  write.table(ResDf,file = "c:/CRISPr/ThermusToPhage/data/res_score_sampleVSsample.txt")   
}

UpdateResults = function(ResultObj, message)
{
  return = UpdateHitMatrix(ResultObj, message)
}

UpdateHitMatrix = function(HitMatrix, message)
{
  HitMatrix[message$SampleNumber, message$OtherSampleNumber] = message$result
  return = HitMatrix
}
