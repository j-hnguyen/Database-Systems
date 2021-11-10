SELECT "1----------";
.headers on
--put your code here
CREATE TABLE Classes (
    class       varchar(20) NOT NULL,
    type        varchar(2) NOT NULL,
    country     varchar(20) NOT NULL,
    numGuns     int NOT NULL,
    bore        int NOT NULL,
    displacement  int NOT NULL,
    PRIMARY KEY (class)
);

CREATE TABLE Ships (
    name    varchar(20) NOT NULL,
    class   varchar(20) NOT NULL,
    launched char(4) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE Battles (
    name    varchar(20) NOT NULL,
    date    date NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE Outcomes (
    ship    varchar(20) NOT NULL,
    battle  varchar(20) NOT NULL,
    result  varchar(10) NOT NULL,
    PRIMARY KEY (ship, battle)
);
.headers off

SELECT "2----------";
.headers on
--put your code here
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Bismarck", "bb", "Germany", 8, 15, 42000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Iowa", "bb", "USA", 9, 16, 46000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Kongo", "bc", "Japan", 8, 14, 32000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "North Carolina", "bb", "USA", 9, 16, 37000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Renown", "bc", "Britain", 6, 15, 32000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Revenge", "bb", "Britain", 8, 15, 29000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Tennessee", "bb", "USA", 12, 14, 32000
);
INSERT INTO Classes (
    class, type, country, numGuns, bore, displacement
) VALUES (
    "Yamato", "bb", "Japan", 9, 18, 65000
);

INSERT INTO Ships (
    name, class, launched
) VALUES (
    "California", "Tennessee", "1915"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Haruna", "Kongo", "1915"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Hiei", "Kongo", "1915"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Iowa", "Iowa", "1933"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Kirishima", "Kongo", "1915"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Kongo", "Kongo", "1913"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Missouri", "Iowa", "1935"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Musashi", "Yamato", "1942"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "New Jersey", "Iowa", "1936"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "North Carolina", "North Carolina", "1941"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Ramillies", "Revenge", "1917"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Renown", "Renown", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Repulse", "Renown", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Resolution", "Revenge", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Revenge", "Revenge", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Royal Oak", "Revenge", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Royal Sovereign", "Revenge", "1916"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Tennessee", "Tennessee", "1915"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Washington", "North Carolina", "1941"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Wisconsin", "Iowa", "1940"
);
INSERT INTO Ships (
    name, class, launched
) VALUES (
    "Yamato", "Yamato", "1941"
);

INSERT INTO Battles (
    name, date 
) VALUES (
    "Denmark Strait", "1941-05-24"
);
INSERT INTO Battles (
    name, date 
) VALUES (
    "Guadalcanal", "1942-11-15"
);
INSERT INTO Battles (
    name, date 
) VALUES (
    "North Cape", "1943-12-26"
);
INSERT INTO Battles (
    name, date 
) VALUES (
    "Surigao Strait", "1944-10-25"
);

INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "California", "Surigao Strait", "ok"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Kirishima", "Guadalcanal", "sunk"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Resolution", "Denmark Strait", "ok"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Wisconsin", "Guadalcanal", "damaged"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Tennessee", "Surigao Strait", "ok"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Washington", "Guadalcanal", "ok"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "New Jersey", "Surigao Strait", "ok"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Yamato", "Surigao Strait", "sunk"
);
INSERT INTO Outcomes (
    ship, battle, result
) VALUES (
    "Wisconsin", "Surigao Strait", "damaged"
);
.headers off

SELECT "3----------";
.headers on
--put your code here
SELECT Classes.country, COUNT(Ships.class)
FROM Classes, Ships
WHERE Classes.class = Ships.class
AND launched BETWEEN "1930" AND "1940"
GROUP BY Classes.country
;
.headers off

SELECT "4----------";
.headers on
--put your code here
INSERT INTO Outcomes (
    ship, battle, result
) 
SELECT Ships.name, "Denmark Strait", "damaged"
FROM Ships
WHERE Ships.launched < "1920"
AND Ships.name NOT IN (
    SELECT Outcomes.ship
    FROM Outcomes
    WHERE Outcomes.battle = "Denmark Strait"
) GROUP BY Ships.name
;
.headers off

SELECT "5----------";
.headers on
--put your code here
SELECT Classes.country, COUNT(Outcomes.ship)
FROM Classes
INNER JOIN Ships ON Ships.class = Classes.class
INNER JOIN Outcomes ON Outcomes.ship = Ships.name
WHERE Outcomes.result = "damaged"
GROUP BY Classes.country
;
.headers off

SELECT "6----------";
.headers on
--put your code here
SELECT Classes.country
FROM Classes 
INNER JOIN Ships ON Classes.class = Ships.class
INNER JOIN Outcomes ON Ships.name = Outcomes.ship
WHERE Outcomes.result = "damaged"
GROUP BY Classes.country
HAVING COUNT(Outcomes.result) = (
    SELECT MIN(results)
    FROM (
            SELECT COUNT(Outcomes.result) AS results
            FROM Outcomes
            INNER JOIN Ships ON Ships.name = Outcomes.ship
            INNER JOIN Classes ON Classes.class = Ships.class
            WHERE Outcomes.result = "damaged"
            GROUP BY Classes.country
    )
)
;
.headers off

SELECT "7----------";
.headers on
--put your code here
DELETE FROM Outcomes
WHERE Outcomes.ship IN (
    SELECT Outcomes.ship 
    FROM Outcomes
    INNER JOIN Ships ON Ships.name = Outcomes.ship
    INNER JOIN Classes ON Classes.class = Ships.class
    WHERE Classes.country = "Japan"
)
AND Outcomes.battle = "Denmark Strait"
;
.headers off

SELECT "8----------";
.headers on
--put your code here
SELECT DISTINCT ship 
FROM Outcomes oa
WHERE EXISTS (
    SELECT ship 
    FROM Outcomes ob
    WHERE oa.ship = ob.ship
    AND result = "damaged"
)
AND EXISTS (
    SELECT ship 
    FROM Outcomes oc
    WHERE oc.ship = oa.ship
    GROUP BY ship
    HAVING COUNT(battle) > 1
)
;
.headers off

SELECT "9----------";
.headers on
--put your code here
SELECT Classes.country, SUM(CASE WHEN Classes.type = "bb" then 1 else 0 end), SUM(CASE WHEN Classes.type = "bc" then 1 else 0 end)
FROM Classes
INNER JOIN Ships ON Ships.class = Classes.class
WHERE Classes.country IN (
    SELECT Classes.country
    FROM Classes
    WHERE Classes.type = "bc"
) GROUP BY Classes.country
;
.headers off

SELECT "10---------";
.headers on
--put your code here
UPDATE Classes
SET numGuns = numGuns*2
WHERE Classes.class IN (
    SELECT Classes.class
    FROM Classes
    INNER JOIN Ships ON Ships.class = Classes.class
    WHERE Ships.launched > "1940"
)
;
.headers off

SELECT "11---------";
.headers on
--put your code here
SELECT Classes.class
FROM Classes
INNER JOIN Ships ON Ships.class = Classes.class
GROUP BY Classes.class
HAVING COUNT(Ships.name) = 2
;
.headers off

SELECT "12---------";
.headers on
--put your code here
SELECT Ships.class
FROM Ships
WHERE Ships.name NOT IN (
    SELECT Outcomes.ship
    FROM Outcomes
    WHERE Outcomes.result = "sunk"
) GROUP BY Ships.class
HAVING COUNT(*) = 2
;
.headers off

SELECT "13---------";
.headers on
--put your code here
DELETE FROM Ships
WHERE Ships.name IN (
    SELECT Ships.name
    FROM Ships 
    INNER JOIN Outcomes on Outcomes.ship = Ships.name
    WHERE Outcomes.result = "sunk"
)
;
.headers off

SELECT "14---------";
.headers on
--put your code here
SELECT Classes.country, SUM(Classes.numGuns)
FROM Classes
INNER JOIN Ships ON Ships.class = Classes.class
GROUP BY Classes.country
;
.headers off

SELECT "15---------";
.headers on
--put your code here
;
.headers off

SELECT "16---------";
.headers on
--put your code here
-- INSERT INTO Ships (
--     name, class, launched
-- ) SELECT Ships.class, Ships.class, MIN(launched)

;
.headers off

SELECT "17---------";
.headers on
--put your code here
;
.headers off
