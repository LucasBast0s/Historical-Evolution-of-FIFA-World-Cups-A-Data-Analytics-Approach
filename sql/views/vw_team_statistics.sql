-- public.vw_team_statistics source

CREATE OR REPLACE VIEW public.vw_team_statistics
AS WITH team_matches AS (
         SELECT m.tournament_id,
            m.tournament_name,
            m.home_team_name AS team,
            m.home_team_score AS goals_for,
            m.away_team_score AS goals_against,
            m.home_team_win AS wins,
            m.draw AS draws,
            m.away_team_win AS losses
           FROM matches m
        UNION ALL
         SELECT m.tournament_id,
            m.tournament_name,
            m.away_team_name AS team,
            m.away_team_score AS goals_for,
            m.home_team_score AS goals_against,
            m.away_team_win AS wins,
            m.draw AS draws,
            m.home_team_win AS losses
           FROM matches m
        ), team_summary AS (
         SELECT t.year,
            tm.tournament_id,
            tm.tournament_name,
            t.host_country,
            tr.champion,
            tr.runner_up,
            tr.third_place,
            tr.fourth_place,
            tm.team,
            te.confederation_name,
                CASE
                    WHEN tm.team::text = tr.champion::text THEN true
                    ELSE false
                END AS is_champion,
                CASE
                    WHEN tm.team::text = tr.runner_up::text THEN true
                    ELSE false
                END AS is_runner_up,
                CASE
                    WHEN tm.team::text = tr.third_place::text THEN true
                    ELSE false
                END AS is_third_place,
                CASE
                    WHEN tm.team::text = tr.fourth_place::text THEN true
                    ELSE false
                END AS is_fourth_place,
            count(*) AS matches_played,
            sum(tm.wins) AS wins,
            sum(tm.draws) AS draws,
            sum(tm.losses) AS losses,
            sum(tm.goals_for) AS goals_for,
            sum(tm.goals_against) AS goals_against,
            sum(tm.goals_for) - sum(tm.goals_against) AS goal_difference,
            round(100.0 * sum(tm.wins)::numeric / count(*)::numeric, 2) AS win_percentage,
            round(sum(tm.goals_for)::numeric / count(*)::numeric, 2) AS goals_per_match,
            round(sum(tm.goals_against)::numeric / count(*)::numeric, 2) AS goals_conceded_per_match,
            sum(tm.wins) * 3 + sum(tm.draws) AS points,
            round((sum(tm.goals_for) - sum(tm.goals_against))::numeric / count(*)::numeric, 2) AS goal_difference_per_match,
            round((sum(tm.wins) * 3 + sum(tm.draws))::numeric / count(*)::numeric, 2) AS points_per_match
           FROM team_matches tm
             JOIN tournaments t ON tm.tournament_id::text = t.tournament_id::text
             LEFT JOIN vw_tournament_results tr ON tm.tournament_id::text = tr.tournament_id::text
             JOIN teams te ON tm.team::text = te.team_name::text
          GROUP BY t.year, tm.tournament_id, tm.tournament_name, t.host_country, tr.champion, tr.runner_up, tr.third_place, tr.fourth_place, tm.team, te.confederation_name
        )
 SELECT year,
    tournament_id,
    tournament_name,
    host_country,
    champion,
    runner_up,
    third_place,
    fourth_place,
    is_champion,
    is_runner_up,
    is_third_place,
    is_fourth_place,
    team,
    confederation_name,
    matches_played,
    wins,
    draws,
    losses,
    goals_for,
    goals_against,
    goal_difference,
    win_percentage,
    goals_per_match,
    goals_conceded_per_match,
    points,
    goal_difference_per_match,
    points_per_match,
    dense_rank() OVER (PARTITION BY tournament_id ORDER BY points DESC, goal_difference DESC, goals_for DESC) AS overall_rank,
    dense_rank() OVER (PARTITION BY tournament_id ORDER BY points DESC) AS points_rank,
    dense_rank() OVER (PARTITION BY tournament_id ORDER BY goal_difference DESC) AS goal_difference_rank,
    dense_rank() OVER (PARTITION BY tournament_id ORDER BY goals_for DESC) AS attack_rank,
    dense_rank() OVER (PARTITION BY tournament_id ORDER BY goals_against) AS defense_rank
   FROM team_summary;