
-- CREATING Athlete Info Table Table
CREATE TABLE athlete_info (
ID int,
Name varchar(255),
Sex varchar(255),
Height float,
Weight float);

-- Creating Teams Info Table and Adding ID Column

CREATE TABLE team_info(
Team varchar(255),
NOC varchar(255),
NOC_Region varchar(255),
NOC_notes varchar(255)
)

ALTER TABLE team_info
ADD COLUMN team_id int;


SET @row_number = 0;
INSERT INTO team_info (team_id, Team, NOC, NOC_region, NOC_notes)
SELECT 
    (@row_number := @row_number + 1) AS team_id,
    Team,
    NOC,
    NOC_region,
    NOC_notes
FROM (
    SELECT DISTINCT 
        Team,
        NOC,
        NOC_region,
        NOC_notes
    FROM olympics
) AS teams
ORDER BY team;

-- Creating Game Info Table with Game_id

create table game_info (
game_id int,
Games varchar(255),
Year int,
Season varchar(255),
City varchar(255));


INSERT INTO game_info (game_id, Games, Year, Season, City)
SELECT 
    (@row_number := @row_number + 1) AS game_id,
    Games,
    Year,
    Season,
    City
FROM (
    SELECT DISTINCT 
       Games,
    Year,
    Season,
    City
    FROM olympics
) AS games
ORDER BY Games;


-- Creating events Table with event_id

CREATE TABLE events (
  event_id INT,
  event VARCHAR(100),
  sport VARCHAR(25)
);
INSERT INTO events
SELECT 
ROW_NUMBER() OVER(ORDER BY event, sport) as event_id,
event,
sport
FROM (
	SELECT DISTINCT 
	event,
	sport
	FROM olympics
) as events;

-- Creating Results Table

CREATE TABLE results (
  athlete_id INT,
  athlete_age INT,
  team_id INT,
  games_id INT,
  event_id INT, 
  medal VARCHAR(6)
);

INSERT INTO results
SELECT DISTINCT
id as athlete_id,
NULLIF(age,'') as athlete_age,
team_id,
game_id,
event_id,
medal
FROM olympics as S
INNER JOIN team_info as T on T.team = S.team
INNER JOIN game_info as G on G.games = S.games AND G.year = S.year AND G.season = S.season
INNER JOIN events as E on E.event = S.event AND E.sport = S.sport;


-- ADDING PRIMARY KEYS

ALTER TABLE athlete_info ADD PRIMARY KEY(id);

ALTER TABLE game_info ADD PRIMARY KEY(game_id);

ALTER TABLE events ADD PRIMARY KEY(event_id);

ALTER TABLE team_info ADD PRIMARY KEY(team_id);


-- ADDING FOREIGN KEYS
ALTER TABLE results ADD FOREIGN KEY (athlete_id) REFERENCES athlete_info(id);
ALTER TABLE results ADD FOREIGN KEY (team_id) REFERENCES team_info(team_id);
ALTER TABLE results ADD FOREIGN KEY (games_id) REFERENCES game_info(game_id);
ALTER TABLE results ADD FOREIGN KEY (event_id) REFERENCES events(event_id);