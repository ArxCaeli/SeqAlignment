# Too long to execute
# To run:
# mpiexec -n 6 "C:\Program Files\R\R-3.1.1\bin\x64\Rterm.exe" --no-save -q
# source("r_mpi_iterative.R")

# only mpi related stuff
# for globals see r_loading 

library("Rmpi")
source("C:/CRISPr/ThermusToPhage/scripts/r_loading.R")
source("C:/CRISPr/ThermusToPhage/scripts/r_scores.R")
source("C:/CRISPr/ThermusToPhage/scripts/r_mpi_helper.R")


CPUSlaves = 6

# Notice we just say "give us all the slaves you've got."
#mpi.spawn.Rslaves(nslaves = CPUSlaves) # 6 processes 

print(mpi.comm.size())

if (mpi.comm.size() < 2) {
  print("More slave processes are required.")
  mpi.quit()
}

.Last <- function(){
  if (is.loaded("mpi_initialize")){
    if (mpi.comm.size(1) > 0){
      print("Please use mpi.close.Rslaves() to close slaves.")
      mpi.close.Rslaves()
    }
    print("Please use mpi.quit() to quit R")
    .Call("mpi_finalize")
  }
}


# Pairwise Alignment per sample per phage
# Assumes: thedata,fold,foldNumber,p
getScore <- function() {
  # Note the use of the tag for sent messages: 
  #     1=ready_for_task, 2=done_task, 3=exiting 
  # Note the use of the tag for received messages: 
  #     1=task, 2=done_tasks 
  junk <- 0 # to substitude mpi comm objects
  done <- 0 
  print("started")
  library(Biostrings)
  mat <- nucleotideSubstitutionMatrix(match = 1, mismatch = -1, baseOnly = TRUE)
  
  
  while (done != 1) {
    # Signal being ready to receive a new task 
    mpi.send.Robj(junk,0,1) 
    # Receive a task 
    task <- mpi.recv.Robj(mpi.any.source(),mpi.any.tag()) 
    
    task_info <- mpi.get.sourcetag() 
    tag <- task_info[2] # 1 - source, 2 - tag
    
    if (tag == 1) 
    {
      SampleSpacers = AllSpacers[AllSpacers$FileName == task$SampleFileName,]
      OtherSampleSpacers = AllSpacers[AllSpacers$FileName == task$OtherSampleFileName,]
      AlignmentScoreBoundary = task$AlignmentScore
      
      Score = 0
      for (i in 1:nrow(SampleSpacers))
      {
        for (j in 1:nrow(OtherSampleSpacers))
        {
          Aligment = pairwiseAlignment(SampleSpacers[i,]$Spacers, OtherSampleSpacers[j,]$Spacers,
                                       scoreOnly = T, type = "local", substitutionMatrix = mat)
          if (Aligment[1] >= AlignmentScoreBoundary)
            Score = Score + 1
        }
      }
      
      print("Score calculated")
      Result <- list(result=Score, SampleFileName = task$SampleFileName, OtherSampleFileName = task$OtherSampleFileName)
      mpi.send.Robj(Result,0,2)      
    }    
    else if (tag == 2) {
      print("Done received")
      done <- 1
    }
    # We'll just ignore any unknown messages
  }
  
  mpi.send.Robj(junk,0,3)
}

# We're in the parent.  
# data loaded in r_loading

print("Sending data to slaves")

junk <- 0 

AllSpacers = data.frame()

for (i in 1:length(Samples)) 
{  
  Spacers = readDNAStringSet(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
  SpacersDF$FileName = Samples[i]
  
  AllSpacers = rbind(AllSpacers, SpacersDF)  
}

Score = 24
tasks = GenerateTasksForSpacersVsSpacers(Samples, Score)
HitMatrix = matrix(ncol = length(Samples), nrow = length(Samples))

# Now, send the data to the slaves
mpi.bcast.Robj2slave(AllSpacers)

# Send the function to the slaves
mpi.bcast.Robj2slave(getScore)

# Call the function in all the slaves to get them ready to
# undertake tasks
mpi.bcast.cmd(getScore())

junk <- 0 
closed_slaves <- 0
n_slaves = 0
n_slaves <- mpi.comm.size() - 1 
print(paste("Slaves: ",n_slaves))

print("Master Started")

while (closed_slaves < n_slaves) 
{ 
  # Receive a message from a slave  
  message <- mpi.recv.Robj(mpi.any.source(),mpi.any.tag()) 
  message_info <- mpi.get.sourcetag() 
  
  slave_id <- message_info[1] 
  tag <- message_info[2] 
  
  if (tag == 1) { 
    # slave is ready for a task. Give it the next task, or tell it tasks 
    # are done if there are none. 
    if (length(tasks) > 0) { 
      # Send a task, and then remove it from the task list 
      mpi.send.Robj(tasks[[1]], slave_id, 1); 
      tasks[[1]] <- NULL      
    } 
    else { 
      paste("Slave", slave_id, "finished")
      mpi.send.Robj(junk, slave_id, 2) 
    } 
  } 
  else if (tag == 2) { 
    # The message contains results. Do something with the results. 
    # Store them in the data structure
    print(paste(which(Samples == message$SampleFileName), which(Samples == message$OtherSampleFileName)))
    HitMatrix[which(Samples == message$SampleFileName), which(Samples == message$OtherSampleFileName)] = message$result
  } 
  else if (tag == 3) { 
    # A slave has closed down. 
    closed_slaves <- closed_slaves + 1 
  }   
} 


Expression_Matrix = HitMatrix

colnames(Expression_Matrix) <- SampleNames
rownames(Expression_Matrix) = SampleNames

ResDf = as.data.frame(Expression_Matrix)
write.table(ResDf,file = "c:/CRISPr/ThermusToPhage/data/res_score_sampleVSsample.txt")  

mpi.close.Rslaves()
mpi.quit(save="no")
