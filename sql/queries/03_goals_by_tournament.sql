select
tournament_name,
year,
host_country,
matches,
total_goals,
total_goals::numeric / matches as goals_per_match
from (SELECT
    t.tournament_name,
    t.year,
    t.host_country,
    COUNT(*) AS matches,
    SUM(m.home_team_score + m.away_team_score) AS total_goals
FROM matches m
JOIN tournaments t
    ON m.tournament_id = t.tournament_id
GROUP BY
    t.tournament_id,
    t.tournament_name,
    t.year,
    t.host_country
) as world_cup_stats
order by goals_per_match desc