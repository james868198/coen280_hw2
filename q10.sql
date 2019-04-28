SELECT ActorID, FirstName, LastName
FROM IMDBPerson, MovieActor
WHERE ID = ActorID AND FirstName != 'Matt' AND LastName != 'Damon' AND MovieID IN (
    SELECT MovieID
    FROM Movie, MovieActor
    WHERE MovieID = SerialNumber AND ActorID IN (
        SELECT ActorID
        FROM IMDBPerson, MovieActor
        WHERE ID = ActorID AND FirstName != 'Matt' AND LastName != 'Damon' AND MovieID IN (
            SELECT MovieID
            FROM IMDBPerson, MovieActor, Movie
            WHERE ID = ActorID AND MovieID = SerialNumber AND FirstName = 'Matt' AND LastName = 'Damon'
        )
        GROUP BY ActorID
    )
    GROUP BY MovieID    
)AND ActorID NOT IN (
    SELECT ActorID
    FROM IMDBPerson, MovieActor
    WHERE ID = ActorID AND FirstName != 'Matt' AND LastName != 'Damon' AND MovieID IN (
        SELECT MovieID
        FROM IMDBPerson, MovieActor, Movie
        WHERE ID = ActorID AND MovieID = SerialNumber AND FirstName = 'Matt' AND LastName = 'Damon'
    )
    GROUP BY ActorID
)
GROUP BY ActorID, FirstName, LastName
;