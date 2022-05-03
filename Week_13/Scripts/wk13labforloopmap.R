##################################
### This is practicing with for loops and map() ####
### Created by: Sophia Boyd ####
### Created on: 2022-04-26 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)

# Calculate the mean and standard deviation of temperature and light

# for loop

hw_path <- here("Week_13", "Data", "homework") #creating a file path
hw_files <- dir(path = hw_path, pattern = ".csv")
hw_files

homework <-data.frame(matrix(nrow = length(hw_files), ncol = 5)) # making a dataframe w/ 5 columns

colnames(homework)<-c("filename","mean_temp", "stdev_temp", "mean_intensity", "stdev_intensity") # label column names
homework

rawdata <- read_csv(paste0(hw_path,"/",hw_files[1]))
head(rawdata)

for (i in 1:length(hw_files)){
  rawdata <- read_csv(paste0(hw_path,"/",hw_files[i]))
  homework$filename[i]<-hw_files[i] 
  homework$mean_temp[i]<-mean(rawdata$Temp.C, na.rm = TRUE) # finds mean of temp data
  homework$stdev_temp[i]<-sd(rawdata$Temp.C, na.rm = TRUE) # finds standard deviation of temp data
  homework$mean_intensity[i]<-mean(rawdata$Intensity.lux, na.rm = TRUE) # finds mean of light level data
  homework$stdev_intensity[i]<-sd(rawdata$Intensity.lux,na.rm = TRUE) # finds standard deviation of light level data
}

homework

# map()
map_files <- dir(path = hw_path, pattern = ".csv", full.names = TRUE)
map_files

data_map <- map_files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename")%>%  # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>% 
  summarise(meanof_temp = mean(Temp.C, na.rm = TRUE), # finds mean of temp
            stddev_temp = sd(Temp.C, na.rm = TRUE), # finds standard deviation of temp
            meanof_intensity = mean(Intensity.lux, na.rm = TRUE), # finds mean of light level
            stddev_intensity = sd(Intensity.lux, na.rm = TRUE)) # finds standard deviation of light level
data_map




