library(tidyverse)
library(here)
library(lubridate)

pikkused <- read_csv(here::here("pikkused.csv"), 
                     col_types = cols(kuupäev = col_date(format = "%d%m%Y")))
