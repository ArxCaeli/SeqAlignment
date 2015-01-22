#Data Loading

#source("http://bioconductor.org/biocLite.R")
# biocLite()
# biocLite("eisa")
# biocLite("ALL")
# biocLite("hgu95av2.db")
# biocLite("affy")
# biocLite("biclust")
# biocLite("Biostrings")
# biocLite("ShortRead")
# biocLite("org.Mm.eg.db")
#biocLite("BiocParallel")
library("Rmpi")
library(Biostrings)
library(ShortRead)
source("./r_mpi_helper.R")

library(preprocessCore)


#phage fasta loading
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Clusters/" 
#DataFolder = "C:/CRISPr/ThermusToPhage/data/MiniCluster/" # for debug
#DataFolder = "C:/CRISPr/ThermusToPhage/data/ClustersWeightedTest/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/ClustersWeighted/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Test/" 
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Spacers/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/MiniSpacers/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Clusters/Slon/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/extra/Slon3/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/SummaryClusters/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Spacers/fasta/"

#DataFolder = "C:/CRISPr/ThermusToPhage/data/MiniWeighted/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/extra/SlonWeighted/"
DataFolder = "C:/CRISPr/ThermusToPhage/data/extra/spacers_tables/"

#LeadersDataFolder = "C:/CRISPr/ThermusToPhage/data/leaders/"
#LeadersDataFolder = "C:/CRISPr/ThermusToPhage/data/LeadersCsv/"


#PhageFolder = "c:/CRISPr/ThermusToPhage/data/phages/"

#Phages = list.files(PhageFolder, pattern="*.f*", full.names=TRUE)
Samples = list.files(DataFolder, full.names=TRUE, recursive = F)#T)

#PhageNames = list.files(PhageFolder, pattern="*.f*", full.names=F)
SampleNames = list.files(DataFolder, full.names=F, recursive = T)

#Samples = append(Samples, list.files(LeadersDataFolder, full.names=TRUE, recursive = F))
#SampleNames = append(SampleNames, list.files(LeadersDataFolder, full.names=F, recursive = T))

# AllSpacers = c()
# for (i in 1:length(Samples)) 
# { 
#   AllSpacers = c(AllSpacers, readDNAStringSet(Samples[i]))  
# }

ReferenceSpacers = read.csv(Samples[1], sep = ";", header = F)
names(ReferenceSpacers) = c("Spacers", "Qty")
NormTargetVector = ReferenceSpacers$Qty

AllSpacers = loadWeightedSpacers(Samples, NormTargetVector)

ResultObject = makeFullResultObjForWeightedSpacers(AllSpacers, SampleNames)

Score = 3
tasks = GenerateTasksForFastMatching(Samples, Score)
# SampleNames
# 
# Rows = c(1:9, 11:13)
# Cols = c(10, 14)
# tasks = GenerateParticularTasksForFastMatching(Score, Rows, Cols)

#ResultObject = matrix(ncol = length(Samples), nrow = length(Samples))

