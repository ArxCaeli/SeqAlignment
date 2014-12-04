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

library(Biostrings)
library(ShortRead)


#phage fasta loading
DataFolder = "C:/CRISPr/ThermusToPhage/data/Clusters/" 
#DataFolder = "C:/CRISPr/ThermusToPhage/data/MiniCluster/" # for debug
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Test/" 
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Spacers/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/MiniSpacers/"
#DataFolder = "C:/CRISPr/ThermusToPhage/data/Clusters/Slon/"

PhageFolder = "c:/CRISPr/ThermusToPhage/data/phages/"

Phages = list.files(PhageFolder, pattern="*.f*", full.names=TRUE)
Samples = list.files(DataFolder, full.names=TRUE, recursive = F)#T)

PhageNames = list.files(PhageFolder, pattern="*.f*", full.names=F)
SampleNames = list.files(DataFolder, full.names=F, recursive = T)

#Expression_Matrix = matrix(ncol = length(Phages), nrow = length(Samples))
#TaskLength = length(Expression_Matrix)
