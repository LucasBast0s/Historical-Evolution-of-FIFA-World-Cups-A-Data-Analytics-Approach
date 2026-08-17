# Historical Evolution of FIFA World Cups — A Data Analytics Approach

## Project Overview

This project is a data curation, cleaning, SQL analysis, and data visualization project focused on the historical evolution of the FIFA World Cup.

The project started with **A Comprehensive Database on the FIFA World Cup**, created by **Josh Fjelstul**, and originally published through Kaggle. The dataset provides a comprehensive collection of FIFA World Cup data and, at the time this project was started, covered tournaments from **1930 to 2018**.

Rather than using the dataset as-is, this project focused on **updating, validating, and extending the original database** to include the 2022 and 2026 FIFA World Cups, while maintaining consistency with the original database structure and naming conventions.

The work was organized into four main stages:

1. **Data Curation and Updating**
2. **Data Validation and Cleaning**
3. **SQL Analysis and View Development**
4. **Power BI Data Visualization**

---

## 1. Data Curation and Updating

The original dataset contained several tables covering different aspects of the FIFA World Cup. For this project, four key tables were selected for updating:

- `matches`
- `stadiums`
- `teams`
- `tournaments`

These tables were manually updated to incorporate information from the **2022 and 2026 FIFA World Cups**.

The update process involved collecting information from multiple sources, comparing records, standardizing values, and adapting new records to the structure and conventions established by the original dataset.

SOURCES:https://en.wikipedia.org/wiki/2022_FIFA_World_Cup
https://en.wikipedia.org/wiki/2026_FIFA_World_Cup
https://www.fifa.com/en/tournaments/mens/worldcup/canadamexicousa2026/scores-fixtures?country=BR&wtw-filter=ALL
https://www.thestatsapi.com/world-cup/matches/winner-match-101-vs-winner-match-102-2026-07-19

The main objective was not simply to append new records, but to preserve the consistency of the original database while extending its temporal coverage.

The updated data was initially organized and reviewed using **Google Sheets**, where records could be manually compared, corrected, and standardized before being imported into the analytical database.

---

## 2. Data Validation and Cleaning

After the manual curation process, the updated tables were imported into **DBeaver** and integrated into the database.

Before starting the analysis, the database was validated to ensure data integrity and consistency.

Validation and cleaning steps included:

- Checking duplicate records across the updated tables.
- Identifying and removing duplicated tournament records.
- Verifying unique identifiers.
- Checking relationships between tournaments, matches, teams, and stadiums.
- Validating tournament match counts.
- Checking consistency of team and stadium names.
- Standardizing values and formatting across historical and newly added records.
- Confirming that queries and relationships returned the expected results after cleaning.

This stage was particularly important because the 2022 and 2026 data came from multiple sources and required manual reconciliation with the original database structure.

The resulting dataset provides a consistent foundation for the subsequent SQL analysis and Power BI dashboards.

---

## 3. SQL Analysis and View Development

Once the data had been validated, SQL was used to explore the database, generate analytical queries, and create reusable views.

The project includes documented SQL queries covering different aspects of World Cup history and team performance.

Several analytical views were developed to transform the underlying tables into datasets suitable for analysis and visualization:

- `vw_team_history`
- `vw_team_statistics`
- `vw_tournament_results`

These views consolidate and transform the underlying data into analytical structures used throughout the project.

The SQL work includes operations such as:

- Aggregations
- `JOIN` operations
- Subqueries
- `UNION ALL`
- Grouping and filtering
- Calculated metrics
- Tournament-level statistics
- Team performance statistics

The purpose of creating dedicated views was to separate the data preparation and analytical logic from the visualization layer, making the Power BI dashboards easier to maintain and ensuring that the same calculations could be reused across different visualizations.

---

## 4. Power BI Dashboards

The final stage of the project was the development of an interactive **Power BI** dashboard using the SQL views created during the analysis.

The dashboard is organized into three main pages:

### Historical Overview

Provides a high-level overview of FIFA World Cup history, including:

- Number of World Cups
- Number of participating teams
- Total matches
- Total goals
- World Cup titles by country
- Average goals per match across tournaments
- Total goals by World Cup
- Tournament final standings

### Tournament Explorer

Allows users to select an individual World Cup and explore tournament-specific statistics.

The page includes:

- Total matches
- Number of participating teams
- Total goals
- Average goals per match
- Tournament results
- Goals scored by team
- Wins, draws, and losses
- Tournament performance comparisons

### Team Performance

Allows users to select a specific team and World Cup edition to examine its performance during that tournament.

The page includes:

- Matches played
- Wins
- Draws
- Losses
- Points
- Goals scored
- Goals conceded
- Goal difference
- Win percentage
- Average goals per match
- Comparison of tournament points between teams
- Goals scored versus goals conceded
- Tournament champion information

The dashboards were designed to provide an interactive way to explore both the long-term historical evolution of the competition and individual tournament and team performance.

---

## Data Validation

The database was continuously validated throughout the updating and analysis process to ensure that the addition of new data did not compromise the consistency of the original database.

Historical team names follow the naming conventions established by the original dataset. For example, **West Germany** and **Germany** are treated as separate entities where appropriate in order to preserve historical consistency.

---

## Project Workflow

The overall workflow can be summarized as:

**Original Dataset → Data Curation → Manual Updating → Data Cleaning → Database Validation → SQL Analysis → SQL Views → Power BI Dashboards**

This project demonstrates a complete data analytics workflow, from working with an existing dataset and preparing new data to querying, transforming, analyzing, and visualizing the resulting information.
