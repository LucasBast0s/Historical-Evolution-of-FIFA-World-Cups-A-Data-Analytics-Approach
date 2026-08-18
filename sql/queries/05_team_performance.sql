SELECT
    t.year,
    tm.team,
    tm.matches_played,
    tm.wins,
    tm.draws,
    tm.losses,
    tm.goals_for,
    tm.goals_against,
    tm.goal_difference,
    tm.points
FROM vw_team_statistics tm
JOIN tournaments t
    ON tm.tournament_id = t.tournament_id
WHERE t.year = 2022
ORDER BY
    tm.points DESC,
    tm.goal_difference DESC,
    tm.goals_for DESC;