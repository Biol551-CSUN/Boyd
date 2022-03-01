##################################
#### This is plotting using joined data frames ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-24 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)
library(lubridate)
library(ggplot2)

### Load data ####
CondData <- read_csv(here("Week_5", "Data", "CondData.csv"))
DepthData <- read_csv(here("Week_5", "Data", "DepthData.csv"))
View(CondData)
View(DepthData)

CondData_new <- CondData %>% 
  mutate(datetime = mdy_hms(depth),
         datetime = round_date(datetime, "10 secs")) %>% 
  drop_na() 
View(CondData_new)

DepthData_new <- DepthData %>% 
  mutate(datetime = ymd_hms(date),
         datetime = round_date(datetime, "10 secs")) %>% 
  drop_na()
View(DepthData_new)

FullData <- inner_join(DepthData_new, CondData_new) %>% 
  mutate(hour = hour(datetime),
         minute = minute(datetime)) %>% 
  select(datetime, Depth, TempInSitu, SalinityInSitu_1pCal, hour, minute) %>% 
  group_by(minute) %>%  
  summarise(avgdate = mean(datetime, na.rm = TRUE), # calculates averages
          avgdepth = mean(Depth, na.rm = TRUE),
          avgtemp = mean(TempInSitu, na.rm = TRUE),
          avgsal = mean(SalinityInSitu_1pCal, na.rm = TRUE))
View(FullData)

FullData %>% 
  ggplot(aes(x = minute)) +
  geom_line(aes(y = avgdepth, color = "Depth")) + # creates line for depth
  geom_line(aes(y = avgtemp, color = "Temperature"))+ # creates line for temperature 
  geom_line(aes(y = avgsal, color = "Salinity")) + # creates line for salinity
  labs(title = "Average vs Minute", # changes title
       x = "Minutes", # changes x axis title
       y = "Averages") + # changes y axis title
  theme(plot.title = element_text(hjust = 0.5), #changes size of plot title
        axis.text = element_text(size = 8), #changes size of text on graph
        axis.title = element_text(size = 12), #changes size of axis titles
        panel.border = element_rect(fill = NA, color = "black")) # puts border around graph

