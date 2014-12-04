library(ALL)
library(hgu95av2.db)
library(affy)
library(biclust)

data(ALL)
ALL

thr.gene <- 2.7
thr.cond <- 1.4
set.seed(1) # to get the same results, always
modules <- ISA(ALL, thr.gene=thr.gene, thr.cond=thr.cond)
#data(ALLModulesSmall)
#ALLModulesSmall
#modules <- ALLModulesSmall
modules

Bc = as(modules, "Biclust")
Bc

ISA2heatmap(modules, 6, ALL, norm = "sample",
            scale = "none", col = heat.colors(12))

ALL
(ExpressionSet)
