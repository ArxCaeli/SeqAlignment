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
  "Etna_12_hybrid_system",
  "Etna_12_I-E_system",
  "Etna_12_III_system",
  "Chile_3_unknown_2_5_system",
  "Chile_3_I-A_system",
  "Chile_3_unknown_CCB_system",  
  "Chile_3_I-E_system",
  "Chile_3_I-C_system",
  "Chile_3_I-U_system",
  "Chile_4_unknown_2_5_system",
  "Chile_4_unknown_CCB_system",
  "Chile_4_I-E_system",
  "Chile_4_I-C_system",
  "Etna_9_hybrid_system",
  "Etna_9_I-E_system",
  "Etna_9_III_system",
  "Vesuvio_2012_hybrid_system",
  "Vesuvio_2012_I-E_system",
  "Vesuvio_2012_I-C_system",
  "Vesuvio_2012_III_system",
  "Vesuvio_2012_unknown_scot_system",
  "Vesuvio_2012_I-U_system",
  "Vesuvio_2014_mud_hybrid_system",
  "Vesuvio_2014_mud_I-E_system",
  "Vesuvio_2014_mud_I-C_system",
  "Vesuvio_2014_mud_III_system",
  "Vesuvio_2014_mud_unknown_scot_system",
  "Vesuvio_2014_mud_I-U_system",
  "Random spacers",
  "Vesuvio_2014_water_hybrid_system",
  "Vesuvio_2014_water_I-E_system",
  "Vesuvio_2014_water_I-C_system",
  "Vesuvio_2014_water_III_system",
  "Vesuvio_2014_water_unknown_scot_system",
  "Vesuvio_2014_water_I-U_system",
  "Unknown 2_5 system leader and repeats",
  "Unknown CCB system leader and repeats",
  "Hybrid leader and repeats",
  "I-A leader and repeats",      
  "I-C leader and repeats",      
  "I-E leader and repeats",      
  "III leader and repeats",    
  "Scotoductus leader and repeats",     
  "SGO leader and repeats")

MatRowNames = rownames(AlignmentScoresMatrix) 
MatRowNames
rownames(AlignmentScoresMatrix) = SampleNames
colnames(AlignmentScoresMatrix) = rownames(AlignmentScoresMatrix)

