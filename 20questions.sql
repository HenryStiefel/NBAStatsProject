# 1.	Which teams had a winning record in 2021?
select Team, WLP from teamstats21
where WLP > 0.5
ORDER BY WLP DESC;

# 2.	Which players scored more than 500 total points in 2021?
select Player, (G*PTS) as "Total Points" from playerstats21
where (G*PTS) > 500
ORDER BY (G*PTS) DESC;

# 3.	Which players, on Pacific division teams, either led the team in points per game (minimum 20) or led the team in rebounds per game (minimum 10)?
SELECT Player, Position, Team, PTS, TRB 
FROM playerstats21 p
WHERE p.Team IN (
	SELECT tc.code
    FROM teamcodes tc
    JOIN teamstats21 t ON tc.Team = t.Team
	WHERE t.D = 'P')
AND ((p.PTS IN (
	SELECT max(p1.PTS)
    FROM playerstats21 p1
    WHERE p.Team = p1.Team) AND p.PTS > 20)
    
    OR
    
    (p.TRB IN (
    SELECT max(p2.TRB)
    FROM playerstats21 p2
    WHERE p.Team = p2.Team)) AND p.TRB > 10);
    #AND (p.PTS > 20 or p.TRB > 10) #use function here for max points on team, max rebounds on team
    
# 4.	Which coaches coached teams with losing records?
SELECT DISTINCT c.Coach, c.Team, t.W, t.L
FROM coachstats21 c
JOIN teamcodes tc ON tc.code = c.Team
JOIN teamstats21 t ON t.Team = tc.team 
WHERE c.Team IN (
	SELECT tc.code 
    FROM teamcodes tc
    JOIN teamstats21 t ON tc.Team = t.Team
	WHERE t.W < t.L);



# 5.	Which coaches currently coach a team which has had a winning record over the last 5 years?
SELECT c.Coach, c.Team
FROM coachstats21 c
WHERE c.Team IN (
	SELECT tc.code 
    FROM teamcodes tc
    JOIN teamstats21 t21 ON tc.Team = t21.Team
    JOIN teamstats20 t20 ON tc.Team = t20.Team
    JOIN teamstats19 t19 ON tc.Team = t19.Team
    JOIN teamstats18 t18 ON tc.Team = t18.Team
    JOIN teamstats17 t17 ON tc.Team = t17.Team
	WHERE (t21.W + t20.W + t19.W + t18.W + t17.W) > (t21.L + t20.L + t19.L + t18.L + t17.L));
    
# 6.	What was the average points per game amongst all players in 2020?
SELECT AVG(PTS) 
FROM playerstats20;

# 7.	Which player scored the most points per game in 2021?
SELECT Player, PTS
FROM playerstats21
WHERE PTS IN (
SELECT MAX(PTS)
FROM playerstats21);

# 8.	Which teams in the Eastern Conference had a winning record last season?
SELECT Team, W, L
FROM teamstats21
WHERE C like 'E' and W > L;

# 9.	Who was the top rebounder in the Western Conference last season?
SELECT p.Player, p.Team, p.TRB
FROM playerstats21 p
WHERE p.TRB IN (
	SELECT max(p1.TRB)
    FROM playerstats21 p1
    WHERE p1.Team IN (
		SELECT tc.code
		FROM teamcodes tc
		JOIN teamstats21 t ON tc.Team = t.Team
		WHERE t.C = 'W'))
AND p.Team IN (
	SELECT tc.code
    FROM teamcodes tc
    JOIN teamstats21 t on tc.Team = t.Team
    WHERE t.C = 'W');

# 10.	Who were the players with the most assists per game, and who is their coach?
SELECT DISTINCT p.Player, p.AST, c.Coach, c.Team
FROM coachstats21 c
JOIN playerstats21 p ON p.Team = c.Team
WHERE p.AST IN (
	SELECT MAX(p21.AST)
    FROM playerstats21 p21
    WHERE p.Team = p21.Team)
ORDER BY p.AST DESC;

# 11.	Which players are in the top 10 for three-point percentage with a minimum of 100 three point attempts?
SELECT Player, Team, 3PP
FROM playerstats21
WHERE (3PA * G) > 100
ORDER BY 3PP DESC
LIMIT 10;

# 12.	Who are the league leaders for points, assists, and rebounds per game?
SELECT Player
FROM playerstats21 
WHERE PTS IN (
	SELECT MAX(PTS)
	FROM playerstats21)
    
UNION

SELECT Player
FROM playerstats21
WHERE TRB IN (
	SELECT MAX(TRB)
    FROM playerstats21)
    
UNION

SELECT Player
FROM playerstats21
WHERE AST IN (
	SELECT MAX(AST)
    FROM playerstats21);

# 13.	Who are the coaches of the Atlantic division?
SELECT *
FROM coachstats21 c
WHERE c.Team IN (
	SELECT t.code
    FROM teamcodes t
    JOIN teamstats21 ts ON t.Team = ts.Team
    WHERE ts.D = 'A');
    
# 14.	Who are the top scorers on teams with a Net-Adjusted Rating (nRtgA) greater than 3?
SELECT p.Player, p.Team, p.PTS
FROM playerstats21 p
WHERE p.Team IN (
	SELECT tc.code
    FROM teamcodes tc
    JOIN teamstats21 t ON tc.Team = t.Team
    WHERE t.Team IN (
		SELECT Team
        FROM teamstats21 
        WHERE NRtgA > 3 ))
AND
p.PTS IN (
	SELECT max(p21.PTS)
    FROM playerstats21 p21
    WHERE p.Team = p21.Team);
    
# 15.	Which player has the best field-goal percentage on each team with a minimum of 100 field goal attempts?
SELECT DISTINCT p.Player, p.Position, p.FGP, p.Team
FROM playerstats21 p 
WHERE p.FGP IN (
	SELECT MAX(p21.FGP)
    FROM playerstats21 p21
    WHERE p.Team = p21.Team
    AND (p21.FGA * p21.G) > 100)
ORDER BY p.Team ASC;

# 16.	Which players in the league are small forwards and average at least 1 steal per game?
SELECT p.Player, p.Position, p.STL, p.Team
FROM playerstats21 p 
WHERE p.STL > 1 AND p.Position = 'SF';

# 17.	Who coaches the players in the league who are small forwards and average at least 1 steal per game?
SELECT c.Coach, c.Team
FROM coachstats21 c
JOIN playerstats21 p ON c.Team = p.Team
WHERE p.Team IN (
	SELECT p21.Team
    FROM playerstats21 p21
    WHERE p.STL > 1 and p.Position = 'SF');
    
# 18.	Which players average 20 points, adjusted per 36 minutes, but average less than 15 points per game and greater than 10 minutes per game?
SELECT Player, Team, PTS, MP, (PTS*36/MP)
FROM playerstats21
WHERE (PTS*36/MP) > 20 AND PTS < 15 AND MP > 10
ORDER BY PTS ASC;

# 19.	Which teams’ city name starts with a C?
SELECT Team
FROM teamstats21
WHERE Team like ('C%');

# 20.	Who are all the players in the Eastern Conference who started more games than they came off the bench?
SELECT p21.Player, p21.Team, p21.GS, p21.G
FROM playerstats21 p21
WHERE p21.Team IN (
	SELECT tc.code
    FROM teamcodes tc
    JOIN playerstats21 p21 ON tc.code = p21.Team
    WHERE tc.Team IN (
		SELECT t.Team
        FROM teamstats21 t
        JOIN teamcodes tc ON t.Team = tc.Team
        WHERE t.C = 'E'))
AND p21.GS > (p21.G - p21.GS)