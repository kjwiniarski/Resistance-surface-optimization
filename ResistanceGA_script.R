#script for optimizing multi-surface resistance models
library(ResistanceGA) #load ResistanceGA
ascii.dir <- "Z:/Users/asciis/"   # directory where all the relevant spatial layers ascii files are stored
pools.file <- "Z:/users/AMOP_pools_CC.txt"  # text files with vernal pool locations 
genetic.dist.file <- "Z:/Users/amop_chord_CC.csv" #matrix of chord distances
CS.program <- paste('"C:/Program Files/Circuitscape/cs_run.exe"') #location of Circuitscape

# Preprocess genetic distance
#Load in Genetic Distance Data
Chord_distance <- read.csv("amop_chord_CC.csv", header = FALSE)
CS.response <- lower(Chord_distance)

#ResistanceGA
#Multi surface model
GA.inputs <- GA.prep(ASCII.dir=ascii.dir,
                     select.trans = list("M","M"), #only allowing monomolecular functions for both surfaces
                     max.cat=500,
                     max.cont=500) 

CS.inputs <- CS.prep(n.POPS= 22, #number of vernal pools
                     response=CS.response,
                     CS_Point.File=(pools.file),
                     CS.program=CS.program)

#This will optimize each surface in the ASCII.dir.
MS_RESULTS <- MS_optim(CS.inputs=CS.inputs,
                       GA.inputs=GA.inputs)
