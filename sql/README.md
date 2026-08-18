\# SQL Analysis



\## Overview



SQL was used as the main analytical layer of the project.



After the original dataset was updated and validated, the data was imported into a PostgreSQL database and analyzed using SQL through DBeaver.



The SQL workflow included data validation, exploratory analysis, aggregations, joins, subqueries, calculated metrics, and the development of reusable analytical views for Power BI.



\---



\## Database



The project uses a PostgreSQL database containing the following main tables:



\- `matches`

\- `stadiums`

\- `teams`

\- `tournaments`



The tables were updated and validated before being used for analytical queries.



\---



\## Analytical Queries



The `queries/` directory contains selected SQL queries developed during the analysis.



The queries focus on tournament-level and team-level analysis.



\### Main analyses



\#### Goals by Tournament



Calculates the total number of goals scored in each FIFA World Cup.



Key operations:



\- `JOIN`

\- `COUNT`

\- `SUM`

\- `GROUP BY`

\- `ORDER BY`



\#### Goals per Match



Calculates the average number of goals scored per match for each World Cup.



This analysis uses a subquery to calculate tournament-level match and goal totals before calculating the average.



\#### Team Performance



Analyzes team performance using:



\- Matches played

\- Wins

\- Draws

\- Losses

\- Goals scored

\- Goals conceded

\- Goal difference

\- Points



\---



\## Analytical Views



Three reusable SQL views were created as the main analytical layer for Power BI.



\### `vw\_tournament\_results`



Provides tournament-level results, including:



\- Champion

\- Runner-up

\- Third place

\- Fourth place

\- Tournament year

\- Tournament identifier



This view is used primarily for tournament-level analysis and historical results.



\### `vw\_team\_statistics`



Provides tournament-level statistics for individual teams.



The view calculates metrics such as:



\- Matches played

\- Wins

\- Draws

\- Losses

\- Goals scored

\- Goals conceded

\- Goal difference

\- Win percentage

\- Goals per match

\- Points

\- Points per match

\- Performance rankings



This view provides the primary analytical dataset for the team and tournament Power BI dashboards.



\### `vw\_team\_history`



Aggregates team performance across multiple FIFA World Cup editions.



It provides historical metrics including:



\- World Cups played

\- Matches played

\- Wins

\- Draws

\- Losses

\- Goals scored

\- Goals conceded

\- Goal difference

\- Points

\- World Cup titles

\- Runner-up finishes

\- Third-place finishes

\- Fourth-place finishes

\- Finals

\- Semifinals

\- Historical performance rankings



\---



\## SQL Techniques Used



The project demonstrates the use of several SQL concepts:



\- `SELECT`

\- `WHERE`

\- `GROUP BY`

\- `ORDER BY`

\- `JOIN`

\- `LEFT JOIN`

\- `UNION ALL`

\- Common Table Expressions (`WITH`)

\- Subqueries

\- Aggregate functions

\- `CASE`

\- `COALESCE`

\- Type casting

\- Window functions

\- `DENSE\_RANK()`

\- Calculated metrics



\---



\## SQL → Power BI Workflow



The analytical workflow was designed to separate database logic from visualization.





PostgreSQL Tables

&#x20;      │

&#x20;      ▼

Data Validation

&#x20;      │

&#x20;      ▼

SQL Analysis

&#x20;      │

&#x20;      ▼

Analytical Views

&#x20;      │

&#x20;      ├── vw\_tournament\_results

&#x20;      ├── vw\_team\_statistics

&#x20;      └── vw\_team\_history

&#x20;      │

&#x20;      ▼

Power BI

&#x20;      │

&#x20;      ├── Historical Overview

&#x20;      ├── Tournament Explorer

&#x20;      └── Team Performance



This structure allows SQL to handle the main data transformation and aggregation logic while Power BI is used primarily for interactive visualization and exploration.



\---



Reproducibility



The SQL files included in this directory document the main analytical logic used in the project.



The queries were developed and tested in PostgreSQL using DBeaver.



The analytical views depend on the underlying database tables and should be created after the updated and validated tables have been imported.





