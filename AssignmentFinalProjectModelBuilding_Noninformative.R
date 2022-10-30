# Final Project - NonInformative Model Building
# Author: Charles Stewart
# Student: s3628786
# Date: 15/10/22

# Code inspire by that done in Lab work

graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
library(ggplot2)
library(ggpubr)
library(ks)
library(rjags)
library(runjags)
library(ggplot2)
library(data.table)

myData <- read.csv("pgatour_slim.csv")
myDataSample <- data.table(myData)
myDataSample <- data.frame(myDataSample[sample(.N,250)])

yName = "score"
xName = c("rounds",	"dis",	"accuracy", 	"scrambling", "gir", "putts")

fileNameRoot = "BayStat_FinalProject_s3628786_Repo_NonInformative_Run1"


# Run 1
# NSS = 1000
# ThinS = 7
# NCahins = 3
# Adapt Steps = 1500
# NurnInSteps = 1000

numSavedSteps = 1000
thinSteps = 7
nChains = 3

graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("AssignmentFinalProjectModelFoundationCode_Noninformative.R")
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
startTime = proc.time()
xPred = c(60, 290, 75, 50, 60, 30)

mcmcCoda = genMCMC( data=myDataSample , xName=xName , yName=yName , 
                    numSavedSteps=numSavedSteps , thinSteps=thinSteps , 
                    saveName=fileNameRoot , nChains = nChains , xPred = xPred )

stopTime = proc.time()
duration = stopTime - startTime
show(duration)

save.image(file='A2ChainsRun1.RData')
load('A2ChainsRun1.RData')


#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names
for ( parName in parameterNames ) {
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
            saveName=fileNameRoot , saveType=graphFileType )
}

graphics.off()
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:

summaryInfo = smryMCMC( mcmcCoda , 
                        saveName=fileNameRoot  )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , data=myDataSample , xName=xName , yName=yName , 
          pairsPlot=TRUE , showCurve=FALSE ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 





