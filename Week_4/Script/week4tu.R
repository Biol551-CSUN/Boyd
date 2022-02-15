##################################
#### This is practicing dplyr ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-15 ####
##################################

### Load libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ####
glimpse(penguins)
head(penguins)
filter(.data = penguins, sex == "female") #2 equal signs is a question, 1 is an argument
filter(.data = penguins,
       year == "2008")
filter(.data = penguins,
       sex == "female",
       body_mass_g > 5000)
filter(.data = penguins,
       year == 2008 | year == 2009) ## 2008 or 2009
filter(.data = penguins,
       island != "Dream")
filter(.data = penguins,
       species == "Adelie" | species == "Gentoo")
filter(.data = penguins,
       species %in% c("Adelie", "Gentoo"))
filter(.data = penguins,
       body_mass_g <5000,
       body_mass_g >3000) #penguins b/w 3000 and 5000
data2<-mutate(.data = penguins,
              body_mass_kg = body_mass_g/1000)
View(data2)
data2<-mutate(.data = penguins,
      body_mass_kg = body_mass_g/1000,
      bill_length_depth = bill_length_mm/bill_depth_mm)
data2<-mutate(.data = penguins,
              after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
View(data2) #case_when: more than 2 outcomes
data2<-mutate(.data = penguins,
              length_mass = flipper_length_mm + body_mass_g)
data2<-mutate(.data = penguins,
              mass_big_small = ifelse(body_mass_g >4000, "big", "small"))
penguins %>%
  filter(sex == "female") %>%
  mutate(log_mass = log(body_mass_g)) %>% 
  select(Species = species, island, sex, log_mass) 

penguins %>% 
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE))

penguins %>% 
  group_by(island, sex) %>% 
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length = max(bill_length_mm, na.rm = TRUE ))
penguins %>% 
  drop_na(sex) %>% 
  group_by(island, sex) %>% 
  summarise (mean_bill_length = mean(bill_length_mm, na.rm = TRUE))
penguins %>% 
  drop_na(sex) %>% 
  ggplot(aes(x=sex, y = flipper_length_mm)) + 
  geom_boxplot()
