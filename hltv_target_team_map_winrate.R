library(tidyverse)

target_team_maps <- read_csv("hltv_target_team_maps_clean.csv")

target_teams <- c("Vitality", "Spirit", "Falcons", "FURIA", "MOUZ")

map_order <- c(
  "Ancient", "Anubis", "Dust2", "Inferno",
  "Mirage", "Nuke", "Overpass", "Train"
)

map_winrate <- target_team_maps %>%
  filter(TargetTeam %in% target_teams) %>%
  group_by(TargetTeam, Map) %>%
  summarize(
    MapsPlayed = n(),
    Wins = sum(Result == "Win"),
    Losses = sum(Result == "Loss"),
    Draws = sum(Result == "Draw"),
    WinRate = Wins / MapsPlayed,
    .groups = "drop"
  ) %>%
  complete(
    TargetTeam = target_teams,
    Map = map_order,
    fill = list(
      MapsPlayed = 0,
      Wins = 0,
      Losses = 0,
      Draws = 0
    )
  ) %>%
  mutate(
    WinRate = if_else(MapsPlayed == 0, NA_real_, WinRate),
    WinRatePlot = replace_na(WinRate, 0),
    Map = factor(Map, levels = map_order)
  ) %>%
  arrange(TargetTeam, Map)

write_csv(map_winrate, "hltv_target_team_map_winrate.csv")
