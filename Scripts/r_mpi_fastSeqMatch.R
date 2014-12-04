# Using vcountPDict instead of pairwise alignment - a lot of memory instead a lot of time
# To run: 3 - 1gb per process
# mpiexec -n 3 "C:\Program Files\R\R-3.1.1\bin\x64\Rterm.exe" --no-save -q
# source("r_mpi_iterative.R")

# only mpi related stuff
# for globals see r_loading 

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

# AllSpacers object sent via mpi
getScore <- function() {
  # Note the use of the tag for sent messages: 
  #     1=ready_for_task, 2=done_task, 3=exiting 
  # Note the use of the tag for received messages: 
  #     1=task, 2=done_tasks 
  junk <- 0 # to substitude mpi comm objects
  done <- 0 
  print("started")
  library(Biostrings)
  source("C:/CRISPr/ThermusToPhage/scripts/r_mpi_helper.R")
  
  while (done != 1) {
    # Signal being ready to receive a new task 
    mpi.send.Robj(junk,0,1) 
    # Receive a task 
    task <- mpi.recv.Robj(mpi.any.source(),mpi.any.tag()) 
    
    task_info <- mpi.get.sourcetag() 
    tag <- task_info[2] # 1 - source, 2 - tag
    
    if (tag == 1) 
    {
      Result = GetScore(task, AllSpacers)
      mpi.send.Robj(Result,0,2)      
    }    
    else if (tag == 2) {
      print("Finished")
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

# Now, send the data to the slaves
mpi.bcast.Robj2slave(AllSpacers)

# Send the function to the slaves
mpi.bcast.Robj2slave(getScore)

# Call the function in all the slaves to get them ready to
# undertake tasks
mpi.bcast.cmd(getScore())

closed_slaves <- 0
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
    print(paste(message$SampleNumber, message$OtherSampleNumber))
    HitMatrix[message$SampleNumber, message$OtherSampleNumber] = message$result
  } 
  else if (tag == 3) { 
    # A slave has closed down. 
    closed_slaves <- closed_slaves + 1 
  }   
}

SaveResults(HitMatrix, SampleNames)

mpi.close.Rslaves()
mpi.quit(save="no")
