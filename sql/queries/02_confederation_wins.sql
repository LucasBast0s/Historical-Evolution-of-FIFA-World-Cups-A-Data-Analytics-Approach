SELECT
    confederation_name,
    sum (wins) AS total_wins
FROM (
select
t.confederation_name,
count (*) as wins
from matches m 
JOIN teams t
    ON m.home_team_name = t.team_name
WHERE m.home_team_win = 1
GROUP BY t.confederation_name
union all
SELECT
t.confederation_name,
    count (*) AS wins
FROM matches m
JOIN teams t
    ON m.away_team_name = t.team_name
WHERE m.away_team_win = 1
GROUP BY t.confederation_name
) as confederation_wins
GROUP BY confederation_name
ORDER BY total_wins DESC;