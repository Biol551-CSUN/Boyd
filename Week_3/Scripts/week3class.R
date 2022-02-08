#############################################
### This is my ggplot2 for week3 ####
### Created by: Sophia Boyd ####
### Created on: 2022-02-08 ####
#############################################

### Load libraries ####
library(tidyverse)
library(palmerpenguins)

### Data analysis ####
glimpse(penguins)

### Penguin dataframe ####
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,  ### x axis
                     y = bill_length_mm,   ### y axis
                     color = species,
                     shape = species,
                     size = body_mass_g,
                     alpha = flipper_length_mm)) +
       geom_point(size = 2, alpha = 0.5) +
       facet_wrap(~ species, ncol=2) +
       guides(color = FALSE)
        labs(title = "Bill depth and length",
             subtitle = "Dimensions for species",
             x = "Bill depth (mm)", y = "Bill length (mm)",
             color = "Species",
             shape = "Species",
             caption = "Source: Palmer Station LTER / palmerpenguins package") +
       scale_color_viridis_d()
  
             
             
               
  
