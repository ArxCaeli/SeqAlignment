Samples[1:3]
Samples[4:10]
Samples[11:14]
Samples[15:17]
Samples[18:24]
Samples[25:31]
Samples[32]
Samples[33:39]

MergedScores = matrix(nrow = 8, ncol = 8)

MergedSource = AlignmentScoresMatrix[1,] + AlignmentScoresMatrix[2,] + AlignmentScoresMatrix[3,] 
MergedScores[1,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[4,] + AlignmentScoresMatrix[5,] + AlignmentScoresMatrix[6,] + AlignmentScoresMatrix[7,] +
  AlignmentScoresMatrix[8,] + AlignmentScoresMatrix[9,] + AlignmentScoresMatrix[10,]
MergedScores[2,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[11,] + AlignmentScoresMatrix[12,] + AlignmentScoresMatrix[13,] + AlignmentScoresMatrix[14,]
MergedScores[3,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[15,] + AlignmentScoresMatrix[16,] + AlignmentScoresMatrix[17,]
MergedScores[4,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[18,] + AlignmentScoresMatrix[19,] + AlignmentScoresMatrix[20,] + AlignmentScoresMatrix[21,] +
  AlignmentScoresMatrix[22,] + AlignmentScoresMatrix[23,] + AlignmentScoresMatrix[24,]
MergedScores[5,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[25,] + AlignmentScoresMatrix[26,] + AlignmentScoresMatrix[27,] + AlignmentScoresMatrix[28,] +
  AlignmentScoresMatrix[29,] + AlignmentScoresMatrix[30,] + AlignmentScoresMatrix[31,]
MergedScores[6,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[32,]
MergedScores[7,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

MergedSource = AlignmentScoresMatrix[33,] + AlignmentScoresMatrix[34,] + AlignmentScoresMatrix[35,] + AlignmentScoresMatrix[36,] +
  AlignmentScoresMatrix[37,] + AlignmentScoresMatrix[38,] + AlignmentScoresMatrix[39,]
MergedScores[8,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:10]), sum(MergedSource[11:14]), sum(MergedSource[15:17]),
                     sum(MergedSource[18:24]), sum(MergedSource[25:31]), MergedSource[32], sum(MergedSource[33:39]))

Samples[1:3]
Samples[4:10]
Samples[11:14]
Samples[15:17]
Samples[18:24]
Samples[25:31]
Samples[32]
Samples[33:39]

colnames(MergedScores) = c("12", "3", "4", "9", "gr", "mud", "random", "water")
rownames(MergedScores) = colnames(MergedScores)  
MergedScores

AlignmentScoresMatrix = MergedScores


Samples[1:3]
Samples[4:10]
Samples[11:14]
Samples[15:17]
Samples[18:24]
Samples[25:31]
Samples[32]
Samples[33:39]

Samples

MergedScores = matrix(nrow = 11, ncol = 11)
#blue
MergedSource = AlignmentScoresMatrix[1,] + AlignmentScoresMatrix[15,] + AlignmentScoresMatrix[19,] + AlignmentScoresMatrix[26,]  + AlignmentScoresMatrix[34,]  
MergedSource
MergedScores[1,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#red
MergedSource = AlignmentScoresMatrix[3,] + AlignmentScoresMatrix[17,] + AlignmentScoresMatrix[29,] + AlignmentScoresMatrix[37,]  + AlignmentScoresMatrix[22,]  
MergedSource
MergedScores[2,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

MergedScores

#2_5
MergedSource = AlignmentScoresMatrix[5,] + AlignmentScoresMatrix[11,]  
MergedScores[3,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#CCB
MergedSource = AlignmentScoresMatrix[7,] + AlignmentScoresMatrix[12,]  
MergedScores[4,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#orange
MergedSource = AlignmentScoresMatrix[9,] + AlignmentScoresMatrix[14,] + AlignmentScoresMatrix[21,] + AlignmentScoresMatrix[28,]  + AlignmentScoresMatrix[36,]  
MergedScores[5,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#green
MergedSource = AlignmentScoresMatrix[2,] + AlignmentScoresMatrix[8,] + AlignmentScoresMatrix[13,] + AlignmentScoresMatrix[16,] + AlignmentScoresMatrix[20,] + 
  AlignmentScoresMatrix[27,] + AlignmentScoresMatrix[35,]
MergedScores[6,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#scotoductus
MergedSource = AlignmentScoresMatrix[23,] + AlignmentScoresMatrix[30,] + AlignmentScoresMatrix[38,]  
MergedScores[7,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#18_6
MergedSource = AlignmentScoresMatrix[4,] + AlignmentScoresMatrix[18,] + AlignmentScoresMatrix[25,] + AlignmentScoresMatrix[33,]  
MergedScores[8,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#SGO
MergedSource = AlignmentScoresMatrix[10,] + AlignmentScoresMatrix[24,] + AlignmentScoresMatrix[31,] + AlignmentScoresMatrix[39,]  
MergedScores[9,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#brown
MergedSource = AlignmentScoresMatrix[6,]
MergedScores[10,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

#random
MergedSource = AlignmentScoresMatrix[32,]
MergedScores[11,] = c(
  MergedSource[1] + MergedSource[15] + MergedSource[19] + MergedSource[26]  + MergedSource[34],
  MergedSource[3] + MergedSource[17] + MergedSource[29] + MergedSource[37]  + MergedSource[22],
  MergedSource[5] + MergedSource[11],
  MergedSource[7] + MergedSource[12],
  MergedSource[9] + MergedSource[14] + MergedSource[21] + MergedSource[28]  + MergedSource[36],
  MergedSource[2] + MergedSource[8] + MergedSource[13] + MergedSource[16] + MergedSource[20] + MergedSource[27] + MergedSource[35],
  MergedSource[23] + MergedSource[30] + MergedSource[38],
  MergedSource[4] + MergedSource[18] + MergedSource[25] + MergedSource[33],
  MergedSource[10] + MergedSource[24] + MergedSource[31] + MergedSource[39],
  MergedSource[6],
  MergedSource[32])

MergedScores
colnames(MergedScores) = c("blue", "red", "2_5", "CCB", "orange", "green", "scotoductus", "18_6", "SGO", "brown", "random");
rownames(MergedScores) = colnames(MergedScores)

AlignmentScoresMatrix = MergedScores


SampleNames = c(
  "ETNA 12/ hybr spacers",
  "ETNA 12/ I-E spacers",
  "ETNA 12/ III spacers",
  "CHILE 3/ 2-5 spacers",
  "CHILE 3/ I-A spacers",
  "CHILE 3/ CCB spacers",  
  "CHILE 3/ I-E spacers",
  "CHILE 3/ I-C spacers",
  "CHILE 3/ I-U spacers",
  "CHILE 4/ 2-5 spacers",
  "CHILE 4/ CCB spacers",
  "CHILЕ 4/ I-E spacers",
  "CHILE 4/ I-C spacers",
  "ETNA 9/ hybr spacers",
  "ETNA 9/ I-E spacers",
  "ETNA 9/ III_spacers",
  "VESUVIO mud*/ hybr spacers",
  "VESUVIO mud*/ I-E spacers",
  "VESUVIO mud*/ I-C spacers",
  "VESUVIO mud*/ III spacers",
  "VESUVIO mud*/ Unknown SA spacers",
  "VESUVIO mud*/ I-U spacers",
  "VESUVIO 1/ hybr spacers",
  "VESUVIO 1/ I-E spacers",
  "VESUVIO 1/ I-C spacers",
  "VESUVIO 1/ III spacers",
  "VESUVIO 1/ SA spacers",
  "VESUVIO 1/ I-U spacers",
  "Random spacers",
  "VESUVIO 2/ Hybr spacers",
  "VESUVIO 2/ I-E spacers",
  "VESUVIO 2/ I-C spacers",
  "VESUVIO 2/ III spacers",
  "VESUVIO 2/ SA spacers",
  "VESUVIO 2/ I-U spacers",
  "Unknown 2_5 system repeats",
  "Unknown CCB system repeats",
  "Hybrid repeats",
  "I-A repeats",      
  "I-C repeats",      
  "I-E repeats",      
  "III repeats",    
  "Unknown SA repeats",     
  "I-U repeats",
  "Hybrid leaders",
  "I-A leaders",      
  "I-B leaders",
  "I-C leaders",      
  "I-E leaders",
  "I-U leaders",
  "III leaders",    
  "Unknown 2_5 system leaders",
  "Unknown CCB system leaders",
  "Unknown SA system leaders")


MatRowNames = rownames(AlignmentScoresMatrix) 
MatRowNames
SampleNames
rownames(AlignmentScoresMatrix) = SampleNames
colnames(AlignmentScoresMatrix) = rownames(AlignmentScoresMatrix)

Sep = AlignmentScoresMatrix[c(1:3, 4:13, 14:16, 17:28, 30:35), c(1:3, 4:13, 14:16, 17:28, 30:35)]
Sep = AlignmentScoresMatrix[-c(2, 17:22), -c(2, 17:22)]
Sep = AlignmentScoresMatrix[-c(2, 17:22, 29, 36:54), -c(2, 17:22, 29, 36:54)]

AlignmentScoresMatrix = Sep

ETNA 9
ETNA 12
VESUVIO mud 2012
VESUVIO mud 2014
VESUVIO water 2014
CHILE 3
CHILE 4

MergedScores = matrix(nrow = 7, ncol = 7)
MergedSource = colSums(AlignmentScoresMatrix[1:3,])
MergedSource
MergedScores[1,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))
MergedScores

MergedSource = colSums(AlignmentScoresMatrix[4:9,])
MergedScores[2,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedSource = colSums(AlignmentScoresMatrix[10:13,])
MergedScores[3,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedSource = colSums(AlignmentScoresMatrix[14:16,])
MergedScores[4,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedSource = colSums(AlignmentScoresMatrix[17:22,])
MergedScores[5,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedSource = colSums(AlignmentScoresMatrix[23:28,])
MergedScores[6,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedSource = colSums(AlignmentScoresMatrix[30:35,])
MergedScores[7,] = c(sum(MergedSource[1:3]), sum(MergedSource[4:9]), sum(MergedSource[10:13]), sum(MergedSource[14:16]),
                     sum(MergedSource[17:22]), sum(MergedSource[23:28]), sum(MergedSource[30:35]))

MergedScores

rownames(MergedScores) = c("ETNA 12", "CHILE 3", "CHILE 4", "ETNA 9", "VESUVIO mud 2012", "VESUVIO mud 2014", "VESUVIO water 2014")
colnames(MergedScores) = rownames(MergedScores)
                           
AlignmentScoresMatrix = MergedScores
