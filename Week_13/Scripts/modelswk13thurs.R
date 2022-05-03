##################################
### This is an intro to models ####
### Created by: Sophia Boyd ####
### Created on: 2022-04-28 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance) 
library(modelsummary)
library(tidymodels)
library(wesanderson)

# Linear model of Bill depth ~ Bill length by species
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

check_model(Peng_mod) # can check the assumption of an lm model

# To view results
## ANOVA table
anova(Peng_mod)

## Coefficients with error (effect size)
summary(Peng_mod)

## Using broom
coeffs<-tidy(Peng_mod) # just put tidy() around it
coeffs

results<-glance(Peng_mod) 
results

resid_fitted<-augment(Peng_mod)
resid_fitted

# Results in modelsummary
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
modelsummary(models, output = here("Week_13","Output","table.docx"))

# Modelplot
modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = wes_palette('Darjeeling1'))

models<- penguins %>%
  ungroup()%>% # ungroup
  nest(-species) %>%  # nest all the data by species
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))
models
models$fit # shows each of the 3 models

results<-models %>%
  mutate(coeffs = map(fit, tidy), # looks at coefficients
         modelresults = map(fit, glance)) %>% 
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest()  # R2 and others
view(results) 
