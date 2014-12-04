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

GenerateEmptyMatricies = function(RowsQty, ColsQty, ScoreStart, ScoreEnd)
{
  Matricies <- vector('list')
  for (Score in ScoreStart:ScoreEnd)
  {
    Matricies[[Score - ScoreStart + 1]] = list(ExprMatrix = matrix(ncol = ColsQty, nrow = RowsQty), AlignmentScore = Score)
  }
  
  return (Matricies)
}