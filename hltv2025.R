library(tidyverse)
library(scales)
   
# Load data
map_winrate <- read_csv("hltv2025.csv")
   
# Quick check
glimpse(map_winrate)


# Map and team order
map_order  <- c("Ancient", "Anubis", "Dust2", "Inferno",
                "Mirage", "Nuke", "Overpass", "Train")
team_order <- c("Vitality", "Falcons", "Spirit", "FURIA", "MOUZ")

# Team colors
team_colors <- c(
  "Vitality" = "#FFD700",
  "Falcons"  = "#2E8B57",
  "Spirit"   = "#E0E0E0",
  "FURIA"    = "#8B0000",
  "MOUZ"     = "#FF4444"
)
