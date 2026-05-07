## CS2 Performance Metrics

This project uses several CS2 map-level metrics to compare team performance.

| Metric | Meaning |
  |---|---|
  | Map | The CS2 map played in each record, such as Ancient, Nuke, Mirage, Inferno, or Anubis. |
  | Total Maps | The total number of maps played by a team. A larger sample size makes the result more reliable. |
  | Wins | The number of maps a team won. This counts individual maps, not full BO3 or BO5 matches. |
  | Losses | The number of maps a team lost. |
  | Win Rate | The percentage of maps won by a team, calculated as `Wins / Total Maps`. |
  | Map-specific Win Rate | The win rate of a team on a specific map. This helps identify strong maps and weak maps. |
  | Target Score | The number of rounds won by the target team on a map. |
  | Opponent Score | The number of rounds won by the opponent on the same map. |
  | Round Difference | The difference between the team’s rounds and the opponent’s rounds, calculated as `Target Score - Opponent Score`. |
  | Average Round Difference | The average round difference across maps. A higher value suggests stronger map control and dominance. |
  | Maps Played | The number of different maps a team has played. This reflects the width of the team’s map pool. |
  | Map Pool Coverage | The percentage of the full map pool covered by a team. It shows whether a team has a wide or narrow map pool. |
  | Overall Score | A custom final rating used in this project. It combines win rate, map pool coverage, and sample size. |
  
  In this report, **map win rate** is the most important metric because it directly measures how often a team wins individual maps. **Average round difference** adds more detail by showing whether a team wins maps comfortably or only by close margins. **Map pool coverage** is also important because a stronger team should usually perform well across multiple maps instead of relying on only one or two strong maps.