library(tidyverse)

hltv <- read_csv("hltv_2025_bigevents_matches_all.csv")

target_teams <- c("Vitality", "Spirit", "Falcons", "FURIA", "MOUZ")

target_matches <- hltv %>%
  filter(Team1 %in% target_teams | Team2 %in% target_teams)

team1_view <- target_matches %>%
  filter(Team1 %in% target_teams) %>%
  transmute(
    Date,
    TargetTeam = Team1,
    Opponent = Team2,
    TargetScore = Team1Score,
    OpponentScore = Team2Score,
    Map,
    Event,
    MatchURL
  )

team2_view <- target_matches %>%
  filter(Team2 %in% target_teams) %>%
  transmute(
    Date,
    TargetTeam = Team2,
    Opponent = Team1,
    TargetScore = Team2Score,
    OpponentScore = Team1Score,
    Map,
    Event,
    MatchURL
  )

target_team_maps <- bind_rows(team1_view, team2_view) %>%
  mutate(
    Result = case_when(
      TargetScore > OpponentScore ~ "Win",
      TargetScore < OpponentScore ~ "Loss",
      TRUE ~ "Draw"
    )
  ) %>%
  arrange(TargetTeam, Date, Map)

write_csv(target_matches, "hltv_target_matches_raw.csv")
write_csv(target_team_maps, "hltv_target_team_maps_clean.csv")
