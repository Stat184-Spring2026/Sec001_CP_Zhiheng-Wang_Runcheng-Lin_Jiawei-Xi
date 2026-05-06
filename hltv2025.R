   library(tidyverse)
   library(scales)
   
   # Load data
   map_winrate <- read_csv("hltv2025.csv")
   
   # Quick check
   glimpse(map_winrate)
