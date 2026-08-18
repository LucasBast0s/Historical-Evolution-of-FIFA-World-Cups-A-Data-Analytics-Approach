\# Data Dictionary



\## Overview



This document describes the main tables, fields, relationships, and analytical views used in the FIFA World Cup data analytics project.



The project is based on \*\*A Comprehensive Database on the FIFA World Cup\*\*, created by \*\*Josh Fjelstul\*\*, with selected tables manually updated to extend the original dataset through the 2022 and 2026 FIFA World Cups.



The main tables updated and used in the project are:



\- `matches`

\- `stadiums`

\- `teams`

\- `tournaments`



The database was imported into PostgreSQL and analyzed using SQL through DBeaver. Analytical views were subsequently created for use in Power BI.



\---



\# 1. Core Tables



\## 1.1 Matches



The `matches` table contains match-level information for FIFA World Cup tournaments.



Each record represents an individual World Cup match.



\### Main Fields



| Field | Description |

|---|---|

| `key\\\_id` | Unique identifier for the database record. |

| `tournament\\\_id` | Identifier of the World Cup tournament. |

| `tournament\\\_name` | Name of the tournament. |

| `match\\\_id` | Identifier of the individual match. |

| `match\\\_name` | Name or description of the match. |

| `stage\\\_name` | Stage of the tournament in which the match was played. |

| `group\\\_name` | Group associated with the match, when applicable. |

| `group\\\_stage` | Indicator identifying whether the match belongs to the group stage. |

| `knockout\\\_stage` | Indicator identifying whether the match belongs to the knockout stage. |

| `replayed` | Indicates whether the match was replayed. |

| `replay` | Information related to a replayed match. |

| `match\\\_date` | Date on which the match was played. |

| `match\\\_time` | Local match time. |

| `stadium\\\_id` | Identifier of the stadium where the match was played. |

| `stadium\\\_name` | Name of the stadium. |

| `city\\\_name` | Host city. |

| `country\\\_name` | Host country. |

| `home\\\_team\\\_id` | Identifier of the home team. |

| `home\\\_team\\\_name` | Name of the home team. |

| `home\\\_team\\\_code` | Code associated with the home team. |

| `away\\\_team\\\_id` | Identifier of the away team. |

| `away\\\_team\\\_name` | Name of the away team. |

| `away\\\_team\\\_code` | Code associated with the away team. |

| `score` | Final match score. |

| `home\\\_team\\\_score` | Goals scored by the home team. |

| `away\\\_team\\\_score` | Goals scored by the away team. |

| `home\\\_team\\\_score\\\_margin` | Goal margin for the home team. |

| `away\\\_team\\\_score\\\_margin` | Goal margin for the away team. |

| `extra\\\_time` | Indicates whether the match went into extra time. |

| `penalty\\\_shootout` | Indicates whether the match was decided by a penalty shootout. |

| `score\\\_penalties` | Penalty shootout score. |

| `home\\\_team\\\_score\\\_penalties` | Penalty shootout goals scored by the home team. |

| `away\\\_team\\\_score\\\_penalties` | Penalty shootout goals scored by the away team. |

| `result` | Match result. |

| `home\\\_team\\\_win` | Indicator for a home-team victory. |

| `away\\\_team\\\_win` | Indicator for an away-team victory. |

| `draw` | Indicator for a draw. |



\### Notes



Match times were standardized using the local timezone of the host city where applicable.



Additional calculated and standardized fields were preserved or updated when necessary to maintain consistency with the original dataset.



\---



\# 1.2 Stadiums



The `stadiums` table contains information about venues used in FIFA World Cup tournaments.



\### Main Fields



| Field | Description |

|---|---|

| `stadium\\\_id` | Unique identifier for the stadium. |

| `stadium\\\_name` | Name of the stadium. |

| `city\\\_name` | City where the stadium is located. |

| `country\\\_name` | Country where the stadium is located. |



\### Data Updates



The stadium table was manually reviewed and updated to include venues used in the 2022 and 2026 FIFA World Cups.



Existing stadium records were reused when a stadium had already appeared in an earlier tournament. This avoided creating duplicate stadium entities.



For example, \*\*Estadio Azteca\*\* was already present in the original historical data and therefore did not require a new duplicate record for the 2026 tournament.



\---



\# 1.3 Teams



The `teams` table contains information about national teams that participated in FIFA World Cup tournaments.



\### Main Fields



| Field | Description |

|---|---|

| `key\\\_id` | Unique identifier for the database record. |

| `team\\\_id` | Identifier of the national team. |

| `team\\\_name` | Name of the national team. |

| `team\\\_code` | Team code. |

| `federation\\\_name` | Name of the football federation. |

| `region\\\_name` | Geographic region associated with the team. |

| `confederation\\\_id` | Identifier of the confederation. |

| `confederation\\\_name` | Name of the confederation. |

| `confederation\\\_code` | Confederation code. |

| `team\\\_wikipedia\\\_link` | Wikipedia reference for the team. |

| `federation\\\_wikipedia\\\_link` | Wikipedia reference for the team's federation. |



\### Historical Naming



Historical team names follow the naming conventions of the original dataset whenever possible.



Historical entities are not automatically merged with their modern counterparts when doing so would compromise historical accuracy.



For example:



\- `West Germany`

\- `Germany`



are treated as separate historical entities where appropriate.



This preserves the historical structure of the original dataset and prevents changes in political or national identity from being interpreted as changes to the same database entity.



\---



\# 1.4 Tournaments



The `tournaments` table contains tournament-level information about each FIFA World Cup.



\### Main Fields



| Field | Description |

|---|---|

| `tournament\\\_id` | Unique identifier for the tournament. |

| `tournament\\\_name` | Official or standardized tournament name. |

| `year` | Year in which the tournament was held. |

| `host\\\_country` | Host country or countries. |

| `champion` | Tournament winner. |

| `runner\\\_up` | Tournament runner-up. |

| `third\\\_place` | Third-place team. |

| `fourth\\\_place` | Fourth-place team. |

| `total\\\_teams` | Number of participating teams. |

| `total\\\_matches` | Number of matches played. |



\### Data Updates



The tournament table was updated to include the 2022 and 2026 FIFA World Cups.



Tournament-level information was checked against match-level data to ensure that reported match counts and tournament results were consistent with the underlying records.



\---



\# 2. Analytical Views



After the database was cleaned and validated, three analytical views were created to prepare the data for analysis and visualization.



\## 2.1 `vw\\\_team\\\_history`



This view provides a historical perspective of national team participation and performance across FIFA World Cups.



It is designed to support analyses such as:



\- World Cup participation

\- Tournament results

\- Team rankings

\- Titles

\- Wins, draws, and losses

\- Goals scored and conceded

\- Historical team performance



The view is primarily used to analyze how teams have performed across multiple World Cup editions.



\---



\## 2.2 `vw\\\_team\\\_statistics`



This view provides tournament-level statistics for individual teams.



It is used extensively by the Power BI \*\*Team Performance\*\* dashboard.



\### Main Metrics



| Field | Description |

|---|---|

| `team` | National team. |

| `tournament\\\_id` | World Cup identifier. |

| `tournament\\\_name` | World Cup name. |

| `matches\\\_played` | Number of matches played by the team. |

| `wins` | Number of wins. |

| `draws` | Number of draws. |

| `losses` | Number of losses. |

| `goals\\\_for` | Goals scored by the team. |

| `goals\\\_against` | Goals conceded by the team. |

| `goal\\\_difference` | Difference between goals scored and goals conceded. |

| `goals\\\_per\\\_match` | Average goals scored per match. |

| `goals\\\_conceded\\\_per\\\_match` | Average goals conceded per match. |

| `points` | Tournament points accumulated by the team. |

| `points\\\_per\\\_match` | Average points earned per match. |

| `win\\\_percentage` | Percentage of matches won. |

| `overall\\\_rank` | Overall ranking metric. |

| `points\\\_rank` | Ranking based on points. |

| `wins\\\_rank` | Ranking based on wins. |

| `goal\\\_difference\\\_rank` | Ranking based on goal difference. |

| `titles\\\_rank` | Ranking related to World Cup titles. |



This view provides the analytical layer used to calculate and display team performance indicators in Power BI.



\---



\# 2.3 `vw\\\_tournament\\\_results`



This view provides tournament-level results and historical standings.



It supports analyses of:



\- World Cup champions

\- Runner-ups

\- Third-place teams

\- Fourth-place teams

\- Tournament chronology

\- Tournament-level statistics



The view is primarily used by the \*\*Historical Overview\*\* and \*\*Tournament Explorer\*\* dashboards.



\---



\# 3. Data Relationships



The database is organized around the relationship between tournaments, matches, teams, and stadiums.



A simplified representation is:





&#x20;                   tournaments

&#x20;                        │

&#x20;                        │ tournament\_id

&#x20;                        ▼

&#x20;                     matches

&#x20;                   /          \\

&#x20;                  /            \\

&#x20;                 ▼              ▼

&#x20;              teams          stadiums

