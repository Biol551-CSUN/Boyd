##################################
#### This is lab work using tidy ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-17 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)
library(beyonce)

### Load data ####
ChemData<-read_csv(here("Week_4","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)
ChemData_clean<-ChemData %>% 
  filter(complete.cases(.),
         Site == "BP") %>% #filters out everything that isn't a complete row
  separate(col = Tide_time, # choose the tide time column
           into = c("Tide","Time"), # separate into a tide column and time column
           sep = "_", #separates by _
           remove = FALSE) %>%   #keeps original tide_time column
  pivot_longer(cols = Salinity:TA, #columns you want to pivot
               names_to = "Variables", #names of new columns with column names
               values_to = "Values") 
View(ChemData_clean)  
ChemData_short<-ChemData_clean %>% 
  group_by(Variables, Season, Tide, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE))
View(ChemData_short)
ChemData_clean %>% 
  ggplot(aes(x=Season, y=Values, fill=Season)) + #x axis are seasons and y axis are the found values
  geom_violin() + #to  create a violin plot
  facet_wrap(~Variables, scales = "free") +
  scale_fill_manual(values = beyonce_palette(101)) + #fills in graph with color
  labs(title = "Effects of Seasons on each Variable") + #rewrites title
  theme(plot.title = element_text(hjust = 0.5), #changes size of plot title
        axis.text = element_text(size = 8), #changes size of text on grqph
        axis.title = element_text(size = 12), #changes size of axis titles
        panel.border = element_rect(fill = NA, color = "black")) #puts black border
ggsave(here("Week_4","Output","thuswk4labplot.png"))
        
                      
