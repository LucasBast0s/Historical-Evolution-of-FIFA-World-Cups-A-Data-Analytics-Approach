-- public.vw_team_history source

CREATE OR REPLACE VIEW public.vw_team_history
AS WITH team_history AS (
         SELECT vw_team_statistics.team,
            vw_team_statistics.confederation_name,
            count(*) AS world_cups_played,
            sum(vw_team_statistics.matches_played) AS matches_played,
            sum(vw_team_statistics.wins) AS wins,
            sum(vw_team_statistics.draws) AS draws,
            sum(vw_team_statistics.losses) AS losses,
            sum(vw_team_statistics.goals_for) AS goals_for,
            sum(vw_team_statistics.goals_against) AS goals_against,
            sum(vw_team_statistics.goal_difference) AS goal_difference,
            sum(vw_team_statistics.points) AS points,
            sum(
                CASE
                    WHEN vw_team_statistics.is_champion THEN 1
                    ELSE 0
                END) AS world_cup_titles,
            sum(
                CASE
                    WHEN vw_team_statistics.is_runner_up THEN 1
                    ELSE 0
                END) AS runner_up,
            sum(
                CASE
                    WHEN vw_team_statistics.is_third_place THEN 1
                    ELSE 0
                END) AS third_place,
            sum(
                CASE
                    WHEN vw_team_statistics.is_fourth_place THEN 1
                    ELSE 0
                END) AS fourth_place,
            sum(
                CASE
                    WHEN vw_team_statistics.is_champion OR vw_team_statistics.is_runner_up THEN 1
                    ELSE 0
                END) AS finals,
            sum(
                CASE
                    WHEN vw_team_statistics.is_champion OR vw_team_statistics.is_runner_up OR vw_team_statistics.is_third_place OR vw_team_statistics.is_fourth_place THEN 1
                    ELSE 0
                END) AS semifinals,
            round(sum(vw_team_statistics.goals_for) / sum(vw_team_statistics.matches_played), 2) AS goals_per_match,
            round(sum(vw_team_statistics.goals_against) / sum(vw_team_statistics.matches_played), 2) AS goals_conceded_per_match,
            round(100.0 * sum(vw_team_statistics.wins) / sum(vw_team_statistics.matches_played), 2) AS win_percentage,
            round(sum(vw_team_statistics.points) / sum(vw_team_statistics.matches_played), 2) AS points_per_match,
            round(sum(vw_team_statistics.goal_difference) / sum(vw_team_statistics.matches_played), 2) AS goal_difference_per_match
           FROM vw_team_statistics
          GROUP BY vw_team_statistics.team, vw_team_statistics.confederation_name
        )
 SELECT team,
    confederation_name,
    world_cups_played,
    matches_played,
    wins,
    draws,
    losses,
    goals_for,
    goals_against,
    goal_difference,
    points,
    world_cup_titles,
    runner_up,
    third_place,
    fourth_place,
    finals,
    semifinals,
    goals_per_match,
    goals_conceded_per_match,
    win_percentage,
    points_per_match,
    goal_difference_per_match,
    dense_rank() OVER (ORDER BY world_cup_titles DESC, runner_up DESC, third_place DESC, points DESC, wins DESC, goal_difference DESC, goals_for DESC) AS overall_rank,
    dense_rank() OVER (ORDER BY world_cup_titles DESC, runner_up DESC, third_place DESC) AS titles_rank,
    dense_rank() OVER (ORDER BY goals_for DESC) AS attack_rank,
    dense_rank() OVER (ORDER BY goals_against) AS defense_rank,
    dense_rank() OVER (ORDER BY points DESC, wins DESC) AS points_rank,
    dense_rank() OVER (ORDER BY wins DESC, points DESC) AS wins_rank,
    dense_rank() OVER (ORDER BY goal_difference DESC) AS goal_difference_rank
   FROM team_history;