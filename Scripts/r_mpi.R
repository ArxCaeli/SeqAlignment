# Initialize MPI
# To run:
# mpiexec -n 6 "C:\Program Files\R\R-3.1.1\bin\x64\Rterm.exe" --no-save -q
# only mpi related stuff
# for globals see r_loading 

library("Rmpi")
source("C:/CRISPr/ThermusToPhage/scripts/r_loading.R")
source("C:/CRISPr/ThermusToPhage/scripts/r_scores.R")

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
    #print("Ready To Receive")
    # Receive a task 
    task <- mpi.recv.Robj(mpi.any.source(),mpi.any.tag()) 
    
    #print("Received")
    task_info <- mpi.get.sourcetag() 
    tag <- task_info[2] # 1 - source, 2 - tag
    
    #print(paste("Tag: ",tag))
    
    if (tag == 1) 
    {
      SampleSpacers = AllSpacers[AllSpacers$FileName == task$SampleFileName,]
      Phage = AllPhages[AllPhages$FileName == task$PhageFileName,]      
      Score = 0
      for (i in 1:nrow(SampleSpacers))
      {
        #print(paste("Spacer No:", i)) 
        Aligment = pairwiseAlignment(SampleSpacers[i,]$Spacers, Phage[1,]$Phage, scoreOnly = T, type = "local", substitutionMatrix = mat)
        if (Aligment[1] > 26)
          Score = Score + 1#Aligment / nchar(as.character(SampleSpacers[i,]$Spacers)) / 2        
      }
      
      #return (GetAlignmentScore(SpacersDF, Spacers))
      
      # slave do not know about matrix or etc
      #Score = 3#GetSamplePhageScore(task$SampleFileName, task$PhageFileName)
      print("Score calculated")
      Result <- list(result=Score, SampleFileName = task$SampleFileName, PhageFileName = task$PhageFileName)
      mpi.send.Robj(Result,0,2)
      #print(paste("Task done: ",Result))      
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
AllPhages = data.frame()

# Create task list
tasks <- vector('list')
n = 1

for (j in 1:length(Phages))
{    
  Phage = readDNAStringSet(Phages[j])
  PTable = table(Phage)
  Pdf = as.data.frame(PTable)
  Pdf$FileName = Phages[j]
  
  AllPhages = rbind(AllPhages, Pdf)
}

for (i in 1:length(Samples)) 
{  
  Spacers = readDNAStringSet(Samples[i])
  Table = table(Spacers)
  SpacersDF = as.data.frame(Table) 
  SpacersDF$FileName = Samples[i]
  
  AllSpacers = rbind(AllSpacers, SpacersDF)
  
  for (j in 1:length(Phages))
  {    
    tasks[[n]] <- list(SampleFileName=Samples[i], PhageFileName = Phages[j])  
    n = n + 1  
  }  
}


# Now, send the data to the slaves
mpi.bcast.Robj2slave(AllSpacers)
mpi.bcast.Robj2slave(AllPhages)

# Send the function to the slaves
mpi.bcast.Robj2slave(getScore)

# Call the function in all the slaves to get them ready to
# undertake tasks
mpi.bcast.cmd(getScore())

# data structure to store the results
print(Expression_Matrix)

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
      #print(paste("Task sent: ",tasks[[1]]))
      tasks[[1]] <- NULL      
    } 
    else { 
      print("Send done")
      mpi.send.Robj(junk, slave_id, 2) 
    } 
  } 
  else if (tag == 2) { 
    # The message contains results. Do something with the results. 
    # Store them in the data structure
    print(paste(which(Samples == message$SampleFileName), which(Phages == message$PhageFileName)))
    Expression_Matrix[which(Samples == message$SampleFileName), which(Phages == message$PhageFileName)] = message$result
    
  } 
  else if (tag == 3) { 
    # A slave has closed down. 
    closed_slaves <- closed_slaves + 1 
  } 
  
} 

colnames(Expression_Matrix) <- PhageNames
rownames(Expression_Matrix) = SampleNames

ResDf = as.data.frame(Expression_Matrix)
write.table(ResDf,file = "c:/CRISPr/ThermusToPhage/data/res.txt")

#, file = "c:/CRISPr/ThermusToPhage/data/res.txt")

mpi.close.Rslaves()
mpi.quit(save="no")
