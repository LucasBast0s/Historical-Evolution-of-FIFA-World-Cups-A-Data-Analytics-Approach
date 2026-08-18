SELECT
    tournament_name,
    year,
    host_country,
    matches,
    total_goals,
    total_goals::numeric / matches AS goals_per_match
FROM (
    SELECT
        t.tournament_name,
        t.year,
        t.host_country,
        COUNT(*) AS matches,
        SUM(
            m.home_team_score + m.away_team_score
        ) AS total_goals
    FROM matches m
    JOIN tournaments t
        ON m.tournament_id = t.tournament_id
    GROUP BY
        t.tournament_id,
        t.tournament_name,
        t.year,
        t.host_country
) AS tournament_stats
ORDER BY goals_per_match DESC;