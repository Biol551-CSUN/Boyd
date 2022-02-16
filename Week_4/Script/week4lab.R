##################################
#### This is my Tuesday lab group plot  #####
#### Created by: Sophia Boyd ####
#### Created on: 2002-02-15 ####
#################################

#### Load libraries #####
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)

#### Load data ####
glimpse(penguins)
view(penguins)

### data analysis ####
#mean and variance of penguin data set
penguinset<-penguins %>% 
  drop_na(species,island,sex) %>%  
  group_by(species, island, sex) %>%  
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
            variance = var(body_mass_g, na.rm = TRUE))
view(penguinset)

#plot for penguin data set
penguinplot<-penguins %>% 
  drop_na(island,sex,body_mass_g) %>% 
  filter(sex != "male") %>%  # excludes male species
  mutate(log_mass = log(body_mass_g)) %>% # calculates the log body mass
  select(species,island,sex,log_mass) # what is included in the plot
ggplot(data=penguinplot,
      mapping = aes(x= species, # x axis is species
                     y= log_mass))+ # y axis is the log mass
      geom_boxplot(aes(fill=species))+
      scale_fill_manual(values = beyonce_palette(101))+ # changes color of each species plot
      labs(title = "Body Mass Comparison of Penguin Species",
       x = "Species",
       y = "Log Body Mass (g)", # changes title of axes 
       caption = "Source: Palmer Penguins LTER/ palmerpenguin paxkage",
       fill = "Species") + # changes title of legend
      theme(plot.title = element_text(hjust = 0.5), # centers plot title
            axis.text = element_text(size = 9), # changes size of text on axis
            panel.border = element_rect(fill = NA, color = "black")) # creates border around plot

