##################################
#### This is learning about lubridate: date & times ####
#### Created by: Sophia Boyd ####
#### Created on: 2022-02-24 ####
##################################

### Load libraries ####
library(tidyverse)
library(here)
library(lubridate)

### Load data ####
now() # what time is it now
now(tzone = "EST") # what time is it on the east coast
now(tzone = "GMT") # what time in GMT
today() # tells us only the date, not time
today(tzone = "GMT")
am(now()) # is it morning?
leap_year(now()) # is it a leap year?

ymd("2021-02-24")
mdy("2/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

# making a vector of dates
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52") #make a character string
datetimes <- mdy_hms(datetimes) # convert to datetimes
month(datetimes) # tells which month
month(datetimes, label = TRUE) # only february
month(datetimes, label = TRUE, abbr = FALSE) # spell it out
day(datetimes) # extract day
wday(datetimes, label = TRUE) # extract day of the week
hour(datetimes)
minute(datetimes)
second(datetimes)
datetimes + hours(4) # this adds 4 hours #hour extracts time
datetimes + days(2) # add 2 days
round_date(datetimes, "minute") # rounds to nearest minute
round_date(datetimes, "5 mins") # rounds to nearest 5 minute

CondData <- read_csv(here("Week_5", "Data", "CondData.csv"))
View(CondData)
CondData %>% 
  mutate(datetime = mdy_hms(depth)) %>% 
  drop_na()
