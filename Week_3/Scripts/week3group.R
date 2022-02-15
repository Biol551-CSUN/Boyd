######################################
#### This will be my penguin plot ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-10 ####
######################################

### Load libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)

### Load data ####
glimpse(penguins)

#Functions 
ggplot(data = penguins,
       mapping = aes(x = species,
                    y = body_mass_g)) +
       geom_boxplot(aes(fill = species)) +
       geom_dotplot(binaxis = "y",
                    dotsize = 0.1,
                    stackdir = "center")+
       scale_fill_manual(values = beyonce_palette(101)) +
       labs(title = "Body Mass of Penguin Species",
            x = "Species",
            y = "Body Mass (g)") +
       theme(plot.title = element_text(hjust = 0.5),
             panel.border = element_rect(fill = NA, color = "black")) 
      ggsave(here("Week_3","Output","penguins.png"))   
