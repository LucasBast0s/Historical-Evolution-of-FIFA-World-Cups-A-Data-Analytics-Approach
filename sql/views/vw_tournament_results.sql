-- public.vw_tournament_results source

CREATE OR REPLACE VIEW public.vw_tournament_results
AS WITH tournament_metrics AS (
         SELECT matches.tournament_id,
            count(*) AS matches_played,
            count(DISTINCT matches.stadium_name) AS stadiums_used,
            sum(matches.home_team_score + matches.away_team_score) AS total_goals,
            round(sum(matches.home_team_score + matches.away_team_score)::numeric / count(*)::numeric, 2) AS goals_per_match
           FROM matches
          GROUP BY matches.tournament_id
        ), team_participants AS (
         SELECT teams.tournament_id,
            count(DISTINCT teams.team) AS teams_participating
           FROM ( SELECT matches.tournament_id,
                    matches.home_team_name AS team
                   FROM matches
                UNION
                 SELECT matches.tournament_id,
                    matches.away_team_name AS team
                   FROM matches) teams
          GROUP BY teams.tournament_id
        ), final_match AS (
         SELECT m.tournament_id,
            t.year,
            m.tournament_name,
                CASE
                    WHEN m.home_team_win = 1 THEN m.home_team_name
                    ELSE m.away_team_name
                END AS champion,
                CASE
                    WHEN m.home_team_win = 1 THEN m.away_team_name
                    ELSE m.home_team_name
                END AS runner_up
           FROM matches m
             JOIN tournaments t ON m.tournament_id::text = t.tournament_id::text
          WHERE m.stage_name::text = 'final'::text
        ), third_place_match AS (
         SELECT matches.tournament_id,
                CASE
                    WHEN matches.home_team_win = 1 THEN matches.home_team_name
                    ELSE matches.away_team_name
                END AS third_place,
                CASE
                    WHEN matches.home_team_win = 1 THEN matches.away_team_name
                    ELSE matches.home_team_name
                END AS fourth_place
           FROM matches
          WHERE matches.stage_name::text = 'third-place match'::text
        ), tournament_places AS (
         SELECT fm.year,
            fm.tournament_id,
            fm.tournament_name,
            fm.champion,
            fm.runner_up,
            COALESCE(tpm.third_place,
                CASE
                    WHEN fm.tournament_id::text = 'WC-1930'::text THEN 'United States'::text
                    ELSE NULL::text
                END::character varying) AS third_place,
            COALESCE(tpm.fourth_place,
                CASE
                    WHEN fm.tournament_id::text = 'WC-1930'::text THEN 'Yugoslavia'::text
                    ELSE NULL::text
                END::character varying) AS fourth_place
           FROM final_match fm
             LEFT JOIN third_place_match tpm ON fm.tournament_id::text = tpm.tournament_id::text
        UNION ALL
         SELECT 1950 AS year,
            'WC-1950'::character varying AS tournament_id,
            '1950 FIFA World Cup'::character varying AS tournament_name,
            'Uruguay'::character varying AS champion,
            'Brazil'::character varying AS runner_up,
            'Sweden'::character varying AS third_place,
            'Spain'::character varying AS fourth_place
        )
 SELECT tp.year,
    tp.tournament_id,
    tp.tournament_name,
    tm.matches_played,
    tpart.teams_participating,
    tm.stadiums_used,
    tm.total_goals,
    tm.goals_per_match,
    tp.champion,
    champion_team.confederation_name AS champion_confederation,
    tp.runner_up,
    runner_team.confederation_name AS runner_up_confederation,
    tp.third_place,
    third_team.confederation_name AS third_place_confederation,
    tp.fourth_place,
    fourth_team.confederation_name AS fourth_place_confederation
   FROM tournament_places tp
     LEFT JOIN tournament_metrics tm ON tp.tournament_id::text = tm.tournament_id::text
     LEFT JOIN team_participants tpart ON tp.tournament_id::text = tpart.tournament_id::text
     LEFT JOIN teams champion_team ON tp.champion::text = champion_team.team_name::text
     LEFT JOIN teams runner_team ON tp.runner_up::text = runner_team.team_name::text
     LEFT JOIN teams third_team ON tp.third_place::text = third_team.team_name::text
     LEFT JOIN teams fourth_team ON tp.fourth_place::text = fourth_team.team_name::text;