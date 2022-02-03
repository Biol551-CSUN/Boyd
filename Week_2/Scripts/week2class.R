##############################
### My first script. Yay
### Created by: Sophia Boyd
### Created on: 2022-02-03
##############################

### load libraries #####
library(tidyverse)
library(here)

### Read in data ####
WeightData<-read_csv(here("Week_2","Data","weightdata.csv")) # weight data

# Data analysis ####
head(WeightData) # looks at top 6 lines 
tail(WeightData) # looks at bottom 6 lines of dataframe
View(WeightData) # view the dataset