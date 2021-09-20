use nba_stats;

CREATE TABLE PlayerStats21 (
	id INT,
    Player VARCHAR(256),
    Position VARCHAR(2),
    Age VARCHAR(2),
    Team VARCHAR(3),
    G INTEGER,
    GS INTEGER,
    MP FLOAT,
    FG FLOAT,
    FGA FLOAT,
    FGP FLOAT,
    3P FLOAT,
    3PA FLOAT,
    3PP FLOAT,
    2P FLOAT,
    2PA FLOAT,
    2PP FLOAT,
    eFGP FLOAT,
    FT FLOAT,
    FTA FLOAT,
    FTP FLOAT,
    ORB FLOAT,
    DRB FLOAT,
    TRB FLOAT,
    AST FLOAT,
    STL FLOAT,
    BLK FLOAT,
    TOV FLOAT,
    PF FLOAT,
    PTS FLOAT
);

CREATE TABLE TeamStats21 (
	id INT, 
    Team VARCHAR(255),
    C VARCHAR(1),
    D VARCHAR(2),
    W INTEGER,
    L INTEGER,
    WLP FLOAT,
    MOV FLOAT,
    ORtg FLOAT,
    DRtg FLOAT,
    NRtg FLOAT,
    MOVA FLOAT,
    ORtgA FLOAT,
    DRtgA FLOAT,
    NRtgA FLOAT
);

CREATE TABLE CoachStats21 (
	Coach VARCHAR(255),
    Team VARCHAR(3),
    G INTEGER,
    W INTEGER,
    L INTEGER
);