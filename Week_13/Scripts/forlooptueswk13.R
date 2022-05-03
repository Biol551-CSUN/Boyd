##################################
### This is practicing iterative coding ####
### Created by: Sophia Boyd ####
### Created on: 2022-04-26 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)

# For loops command
for(index in sequence){
  command to repeat}

# Simple for loop
## Simple code
print(paste("The year is", 2000))
## Put it in a loop
years<-c(2015:2021)
for (i in years){ # set up the for loop where i is the index
  print(paste("The year is", i)) # loop over i
}

# Create space to save it
## Make a data frame
#### Pre-allocate space for the for loop ; an empty matrix
year_data<-data.frame(matrix(ncol = 2, nrow = length(years)))
#### Add column names
colnames(year_data)<-c("year", "year_name")
year_data

# Add the for loop
for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over year name
  year_data$year[i]<-years[i] # loop over year
}

year_data

# Loops to read multiple .csv files
testdata<-read_csv(here("Week_13", "data", "cond_data","011521_CT316_1pcal.csv"))
glimpse(testdata)

# List files in a directory
## point to the location on the computer of the folder
CondPath<-here("Week_13", "Data", "cond_data")
# list all the files in that path with a specific pattern; .csv 
# you can use regex to be more specific if you are looking for certain patterns in filenames
files <- dir(path = CondPath,pattern = ".csv")
files

# Calculate mean temp and salinity from each file & save

##Pre-allocate space for the loop ; make a data frame
cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))

## Give the dataframe column names
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")
cond_data

# Write basic code to calculate a mean
raw_data<-read_csv(paste0(CondPath,"/",files[1]))
head(raw_data)

# Turn it into a for loop
for (i in 1:length(files)){ # loop over 1:3 the number of files
}

# Add in the loop over the raw data
for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  # glimpse(raw_data)
  cond_data$filename[i]<-files[i] # add in the filename for each row
  cond_data$mean_temp[i]<-mean(raw_data$Temperature, na.rm =TRUE)
  cond_data$mean_sal[i]<-mean(raw_data$Salinity, na.rm =TRUE)
}



# Map function

# Using a canned function that already exists
## Calculate mean from random number 10x
### Create a vector
1:10 %>%  # a vector from 1 to 10 (10x)
  map(rnorm, n = 15) %>%  # calculate 15 random numbers based on a normal distribution in a list
  map_dbl(mean) # calculate the mean. It is now a vector which is type "double"

# Make your own function
1:10 %>% # list 1:10
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)
## Use a formula to change arguments w/in the function
1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

#Bring in files using purrr
## Find files
### point to the location on the computer of the folder
CondPath<-here("Week_13", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files
### or...
files <- dir(path = CondPath,pattern = ".csv", full.names = TRUE)
files
## Read in files using map
data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") # map everything to a dataframe and put the id in a column called filename
data

# Calculate means
data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temperature, na.rm = TRUE),
            mean_sal = mean(Salinity,na.rm = TRUE))
data












