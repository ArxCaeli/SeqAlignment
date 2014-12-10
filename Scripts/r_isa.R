library(isa2)
library(eisa)
library(gplots)
library(ggplot2)
library(RColorBrewer);

AlignmentScores = read.table("c:/CRISPr/ThermusToPhage/data/res_score_slon2_valid.txt")
AlignmentScoresMatrix = data.matrix(AlignmentScores)


AlignmentScoresMatrix[lower.tri(AlignmentScoresMatrix)] = 0
AlignmentScoresMatrix = AlignmentScoresMatrix + t(AlignmentScoresMatrix)
diag(AlignmentScoresMatrix) = 0
diag(AlignmentScoresMatrix) = max(AlignmentScoresMatrix) * 2

AlignmentScoresMatrix

Zoomed = log(AlignmentScoresMatrix + 1)

my_palette <- colorRampPalette(c("black", "yellow", "red"))(n = 1000)
DrawMatrix = AlignmentScoresMatrix # 
DrawMatrix = Zoomed #

heatmap.2(DrawMatrix, trace = "none", scale = "none", Rowv = T, symm = T,
          dendrogram = "row", margins=c(16,16), rowsep=1:nrow(DrawMatrix), sepcolor="slategray1",#"gray90",
          col = brewer.pal(9,"Reds")) #col=my_palette



#norm by qty
for (i in 1:(length(Samples)-1)) 
{     
  for (j in (i + 1):length(Samples))
  {
    if (i != j)
    {
      AlignmentScoresMatrix[i, j] = AlignmentScoresMatrix[i, j] / 
        (length(readDNAStringSet(Samples[i])) * length(readDNAStringSet(Samples[j])))
    }
  }  
}


#isa stuff

colnames(AlignmentScoresMatrix)

TransposedScores = t(AlignmentScoresMatrix)

NormScores = isa.normalize(TransposedScores)
NormScores = isa.normalize(AlignmentScoresMatrix)

NormScores[[2]]

image(NormScores[[2]], strip = F)
heatmap(NormScores[[1]])
heatmap(NormScores[[2]])
heatmap(AlignmentScoresMatrix)

heatmap(AlignmentScoresMatrix)
heatmap(AlignmentScoresMatrix)

heatmap.2(AlignmentScoresMatrix,#NormScores[[2]], 
          sepwidth=c(0.05, 0.05),  # width of the borders
          sepcolor='black',        # color of the separation lines
)
  
image(NormScores[[1]], col = heat.colors(20), axes=FALSE,xlab="",ylab="",srt=45)
axis(3, at = 1:ncol(data), labels=colnames(data),srt=45,tick=FALSE)
axis(2, at = 1:nrow(data), labels=rownames(data),srt=45,tick=FALSE))



image(AlignmentScoresMatrix)

modules = isa(NormScores[[1]])
isa.biclust(modules)

plotModules(modules, xlab = "xxx")







PhageNames = list.files(PhageFolder, pattern="*.f*", full.names=F)
SampleNames = list.files(DataFolder, full.names=F, recursive = T)
Phages = list.files(PhageFolder, pattern="*.f*", full.names=TRUE)
Samples = list.files(DataFolder, full.names=TRUE, recursive = T)

NewMatrix = data.matrix(AlignmentScoresMatrix)

for (i in 1:length(SampleNames))
{
  Spacers = readDNAStringSet(Samples[i])
  NewMatrix[i,] = NewMatrix[i,]/length(Spacers)
}

heatmap(AlignmentScoresMatrix)
heatmap(NewMatrix)

NewMatrixNorm = isa.normalize(NewMatrix)
NewMatrixNorm = NewMatrixNorm[[2]]
image(NewMatrixNorm)
heatmap(NewMatrixNorm)

modules = isa(NewMatrixNorm)
bc = isa.biclust(modules)
bc
drawHeatmap(NewMatrixNorm, bicResult = bc)

plotModules(modules, xlab = "xxx")


install.packages("gplots")
library(gplots)
library(ggplot2)
my_palette <- colorRampPalette(c("black", "yellow", "red"))(n = 1000)
tAlignmentScoresMatrix = t(AlignmentScoresMatrix)
heatmap.2(AlignmentScoresMatrix, symm = T, col=my_palette, #cellnote = AlignmentScoresMatrix,
          margins=c(12,8))



drawHeatmap(NewMatrixNorm, bc, 1)
bubbleplot(NewMatrixNorm, bc)
plotclust(bc, NewMatrixNorm)
## Plot profiles of bicluster elements
parallelCoordinates(data[[1]], bc, number=1)



#  
# ## Coherence measures vs. ISA robustness
# cV <- sapply(seq(bc@Number), function(x)
# constantVariance(data[[1]], bc, x, dimension="both"))
# aV <- sapply(seq(bc@Number), function(x)
# additiveVariance(data[[1]], bc, x, dimension="both"))
# mV <- sapply(seq(bc@Number), function(x)
# multiplicativeVariance(data[[1]], bc, x, dimension="both"))
# sV <- sapply(seq(bc@Number), function(x)
# signVariance(data[[1]], bc, x, dimension="both"))
# 
# rob <- robustness(isa.normalize(data[[1]]), modules$rows,
#                   modules$columns)
# 
# cor( cbind(cV, aV, mV, sV, rob) )
