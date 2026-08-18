/*
==========================================================
Query: Matches Played by National Team
Author: Lucas Bastos
Project: World Cup Analytics
Date: 2026-07-16

Description:
Calculates the total number of FIFA World Cup matches
played by each national team, considering both home
and away appearances.

Tables:
- matches

Expected Output:
- team_name
- total_matches
==========================================================
*/

SELECT
    team_name,
    SUM(matches_played) AS total_matches
FROM (
    SELECT
        home_team_name AS team_name,
        COUNT(*) AS matches_played
    FROM matches
    GROUP BY home_team_name

    UNION ALL

    SELECT
        away_team_name AS team_name,
        COUNT(*) AS matches_played
    FROM matches
    GROUP BY away_team_name
) AS appearances

GROUP BY team_name
ORDER BY total_matches DESC;