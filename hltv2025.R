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

# Fix coord_polar so the radar shape closes properly
coord_radar <- function(theta = "x", start = 0, direction = 1) {
  theta <- match.arg(theta, c("x", "y"))
  r <- if (theta == "x") "y" else "x"
  ggproto("CoordRadar", CoordPolar,
          theta = theta, r = r, start = start,
          direction = sign(direction),
          is_linear = function() TRUE)
}

# Add labels for each point
plot_data <- map_winrate %>%
  mutate(
    Map        = factor(Map, levels = map_order),
    TargetTeam = factor(TargetTeam, levels = team_order),
    label_text = ifelse(is.na(WinRate), "NA",
                        paste0(round(WinRatePlot * 100), "%"))
  )

          
          
