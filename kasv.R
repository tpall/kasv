library(tidyverse)
library(here)
library(lubridate)

pikkused <- read_csv(here::here("pikkused.csv"), 
                     col_types = cols(kuupäev = col_date(format = "%d-%m-%Y")))

pikkused %>% 
  ggplot() +
  geom_line(aes(kuupäev, pikkus)) +
  facet_wrap(~laps, scales = "free_x")

pikkused <- pikkused %>% 
  mutate(vanus = case_when(
    laps == "KM" ~ interval(dmy("27-08-2002"), kuupäev) / years(1),
    laps == "A" ~ interval(dmy("13-04-2013"), kuupäev)  / years(1)
  ))

pikkused %>% 
  ggplot() +
  geom_line(aes(vanus, pikkus / 1000, color = laps)) +
  labs(y = "Pikkus, m", x = "Vanus, aastat") +
  theme(legend.title = element_blank())
ggsave("kasv.svg", width = 4, height = 3)
