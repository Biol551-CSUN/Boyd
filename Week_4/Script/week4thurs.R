##################################
#### This is practicing tidy with biogeochemistry data from Hawaii ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-17 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)

### Load data ####
ChemData<-read_csv(here("Week_4","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)
ChemData_clean<-ChemData %>% 
  filter(complete.cases(.)) %>% #filters out everything that isn't a complete row
  separate(col = Tide_time, # choose the tide time column
           into = c("Tide","Time"), # separate into a tide column and time column
           sep = "_", #separates by _
           remove = FALSE) %>%  #keeps original tide_time column
  unite(col = "Site_Zone", #name of new column
        c(Site,Zone), #columns unite
        sep = ".", #puts a . in the middle
        remove = FALSE) #keeps the original
head(ChemData_clean)
View(ChemData_clean)
ChemData_long <-ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd, #columns you want to pivot
               names_to = "Variables", #names of new columns with column names
               values_to = "Values") #names of new columns with values
View(ChemData_long)
ChemData_long %>% 
  group_by(Variables, Site, Zone, Tide) %>% 
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars = var(Values, na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))
ChemData_long %>% 
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")
ChemData_wide<-ChemData_long %>% 
  pivot_wider(names_from = Variables, #column with names for new columns
              values_from = Values) #column with the values
View(ChemData_wide)
ChemData_clean<-ChemData %>% 
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time,
           into = c("Tide", "Time"),
           sep = "_",
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>% 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% 
  write_csv(here("Week_4","output","summary.csv"))
View(ChemData_clean)

