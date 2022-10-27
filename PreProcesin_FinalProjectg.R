# Preprocessing script for Final Project
# Data: Pgatour stats 2010-2018
# Project: Final Project
# Subject: Bayesian Statistic - MATH 2269
# Author: Charles Stewart - s3628786
# Date: 02/10/22

# Libraries to import
library(visdat)
library(tidyverse)
library(gtsummary)
library(gapminder)
library(Hmisc)
library(pastecs)
library(psych)
library(summarytools)


# Read in raw dataset
pga_data_raw <- read.csv('pgaTourData.csv')

# Remove unwanted columns
pgatour_slim <- subset(pga_data_raw, select=c(Rounds, Fairway.Percentage, Avg.Distance, gir, Average.Putts, Average.Scrambling, Average.Score))

# Reorder and renames columns in dataframe
pgatour_slim <- pgatour_slim[,c(1,3,2,6,4,5,7)]
colnames(pgatour_slim) <- c('rounds','dis','accuracy','scrambling','gir','putts','score')

# Remove player entries with no stats
pgatour_slim <- pgatour_slim[1:1678,]

# Visuals to explore data set
vis_dat(pga_data_raw)
pga_sum <- as.data.frame(summarytools::descr(pgatour_slim))

write.csv(pga_sum, 'pga_sum.csv')