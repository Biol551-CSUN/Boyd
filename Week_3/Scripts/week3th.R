############################################
#### This will be my ggplot for penguin data ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-10 ####
############################################

### Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggthemes)

#### Load data ####
#The data is part of the package and is called penguins
glimpse(penguins)

#Functions
plot1<-ggplot(data=penguins,
       mapping = aes(x= bill_depth_mm,
                     y=bill_length_mm,
                     group = species,
                     color = species)) +
       geom_point()+
       geom_smooth(method = "lm") +
         labs(x= "Bill depth (mm)",
              y= "Bill length (mm)") +
       #scale_color_viridis_d() +
       #scale_x_continuous(breaks = c(14, 17, 21),
                          #labels = c("low", "medium", "high"))
       scale_color_manual(values = beyonce_palette(44)) +
       coord_flip() + # flip x and y axes 
       coord_fixed() + # fix axes 
       coord_trans(x = "log10", y = "log10") +
       coord_polar("x") + # spiral 
       theme_bw() +
       theme(axis.title = element_text(size = 20,
                                       color = "grey"),
             panel.background = element_rect(fill = "linen"),
             strip.text = element_text(size = 30))
       ggsave(here("Week_3","Output","penguin.png"),
              width = 7, height = 5) # in inches

             