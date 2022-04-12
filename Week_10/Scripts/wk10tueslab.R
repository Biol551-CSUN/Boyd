library(tidyverse)
library(palmerpenguins)
library(here)
library(beyonce)

View(penguins)

penguin %>%
  ggplot(aes(x = bill_depth_mm,
             y = bill_depth_mm),
             color = islands)+
  geom_point()+
  geom_smooth(method=lm) +
  labs(title = "Bill depth compared to bill length", 
       x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       color = "Island")

stars <- tibble::tribble(
  ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
  33.46, -117.671,       8L,
  33.548, -117.805,       3L,
  33.603, -117.879,      15L,
  34.39, -119.511,      23L,
  35.156, -120.674,       4L,
  35.316, -120.845,       7L,
  35.534, -121.083,      35L,
  36.623, -121.919,      21L,
  38.306, -123.014,      14L,
  41.78, -124.234,      17L
)

stars%>%
  ggplot(aes(x = lat,
             y = long))+
  geom_point()+
  theme(axis.title = element_text(size = 2), 
        panel.background = element_rect(fill = 'blue'),
        plot.background = element_rect(fill = 'white'))+ 
  labs( x = "Latitude",
        y = "Longitude")       


microplastics<-tibble::tribble(
  ~Sample.ID, ~Clear.Fiber, ~Film, ~Blue.Fiber, ~Fragments,
  "NA122-005-50A",          13L,    3L,         12L,        15L,
  "NA122-011-50A",           0L,   13L,          2L,        40L,
  "NA122-012-50B",           2L,    6L,          4L,        24L,
  "NA122-013-1L",         143L,   18L,         40L,        54L,
  "NA122-014-3.5L",          21L,    3L,          6L,        25L,
  "NA122-017-50A",          26L,    6L,          4L,         3L,
  "NA122-028-50B",           4L,    0L,          3L,         2L,
  "NA122-040-50B",           5L,    0L,          3L,         2L,
  "NA122-041-50B",           5L,    1L,          4L,         0L,
  "NA122-042-50B",           2L,    6L,          5L,         6L,
  "NA122-043-50A",           1L,    3L,          1L,         2L,
  "NA122-044-50A",           0L,    3L,          1L,         0L
)

microplastics %>% 
  ggplot(aes(x=Sample.ID,
             y = Fragments, 
             fill= Sample.ID))+
  geom_col() + 
  scale_fill_manual(values = beyonce_palette(88))+
  labs(x = "Sample ID", 
       y = "Number of Fragments",
       title = "Number of fragments found in deep-sea waters")+
  theme(legend.position = "none", axis.text.x = element_text(angle = 90))
