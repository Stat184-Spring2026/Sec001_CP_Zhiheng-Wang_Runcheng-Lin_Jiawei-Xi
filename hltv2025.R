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

# Plot 1: all 5 teams on one chart
p1 <- ggplot(plot_data,
             aes(x = Map, y = WinRatePlot,
                 group = TargetTeam, color = TargetTeam, fill = TargetTeam)) +
  geom_polygon(alpha = 0.12, linewidth = 1.2) +
  geom_point(size = 2.5) +
  coord_radar() +
  scale_y_continuous(
    limits = c(0, 1),
    breaks = c(0.2, 0.4, 0.6, 0.8, 1.0),
    labels = percent_format(accuracy = 1)
  ) +
  scale_color_manual(values = team_colors) +
  scale_fill_manual(values = team_colors) +
  labs(
    title    = "2025 Big Events: Map Win Rate Comparison",
    subtitle = "Vitality, Falcons, Spirit, FURIA, MOUZ",
    color    = "Team",
    fill     = "Team",
    x = NULL, y = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.background   = element_rect(fill = "#2B2B2B", color = NA),
    panel.background  = element_rect(fill = "#1F1F1F", color = NA),
    panel.grid.major  = element_line(color = "#555555", linewidth = 0.4),
    panel.grid.minor  = element_blank(),
    axis.text.x       = element_text(color = "white", face = "bold", size = 12),
    axis.text.y       = element_text(color = "#888888", size = 9),
    plot.title        = element_text(color = "white", face = "bold",
                                     size = 18, hjust = 0.5),
    plot.subtitle     = element_text(color = "#CCCCCC", size = 12, hjust = 0.5),
    legend.background = element_rect(fill = "#2B2B2B", color = NA),
    legend.text       = element_text(color = "white", size = 11),
    legend.title      = element_text(color = "white", face = "bold")
  )

print(p1)
ggsave("radar_overlay.png", p1,
       width = 11, height = 10, dpi = 300, bg = "#2B2B2B")
          
          
