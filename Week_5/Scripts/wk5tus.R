##################################
#### This is learning about joins using data from Becker and Silbiger ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-22 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)
library(cowsay)

### Load data ####
# Environmental data from each site
EnviroData <- read_csv(here("Week_5","data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData <- read_csv(here("Week_5","data","Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)
View(EnviroData)
View(TPCData)

#Pivot the data
EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, #pivot the data wider
              values_from = values) %>% 
  arrange(site.letter) # arranges data by site_letter in alphabetical
View(EnviroData_wide)

#left_join()
FullData_left <- left_join(TPCData, EnviroData_wide) %>% 
  relocate(where(is.numeric), .after = where(is.character)) #changes order of columns
head(FullData_left)

sum <- FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_if(is.numeric, list(mean = mean, var = var), na.rm = TRUE)

#Making our own tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"),
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T2 <- tibble(Site.ID = c("A", "B", "D", "E"),
             pH = c(7.3, 7.8, 8.1, 7.9))
left_join(T1, T2)
right_join(T1, T2)
inner_join(T1, T2)
full_join(T1, T2)
semi_join(T1, T2)
anti_join(T1, T2)

say("hi its sharkie", by = "shark")
