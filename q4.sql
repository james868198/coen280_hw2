
SELECT FirstName, LastName,ActorID, COUNT(ActorID) AS counting
FROM MovieActor, IMDBPerson
WHERE ID = ActorID AND Attribute = 'Actor' AND MovieID IN (
            SELECT SerialNumber
            FROM IMDBPerson,Movie
            WHERE ID = DirectorID AND FirstName = 'Steven' AND LastName = 'Spielberg'  
        ) 
GROUP BY ActorID,FirstName,LastName
HAVING COUNT(ActorID) >= (
    SELECT MAX(counting)
        FROM (
            SELECT DISTINCT COUNT(ActorID) AS counting
            FROM MovieActor, IMDBPerson
            WHERE ID = ActorID AND Attribute = 'Actor' AND MovieID IN (
                SELECT SerialNumber
                FROM IMDBPerson,Movie
                WHERE ID = DirectorID AND FirstName = 'Steven' AND LastName = 'Spielberg'  
            )
            GROUP BY ActorID,FirstName,LastName
        )
    )
;


