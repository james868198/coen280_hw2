SELECT ActorID, FirstName, LastName
FROM IMDBPerson, (
    SELECT ActorID,COUNT(ActorID) as counting
    FROM (
        SELECT DISTINCT ActorID,DirectorID
        FROM MovieActor ,Movie
        WHERE  MovieID = SerialNumber
        GROUP BY ActorID,DirectorID
    )
    GROUP BY ActorID
    )
WHERE ID = ActorID AND counting>=4;


