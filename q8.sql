SELECT ID, FirstName, LastName
FROM IMDBPerson, (
    SELECT year, ActorID, ROWNUM AS ro
    FROM (
        SELECT ReleasedYear AS year, ActorID
        FROM Movie, MovieActor
        WHERE MovieID = SerialNumber
        GROUP BY ActorID, ReleasedYear
        ORDER BY ReleasedYear
    )
) list1, (
    SELECT year, ActorID, ROWNUM AS ro
    FROM (
        SELECT ReleasedYear AS year, ActorID
        FROM Movie, MovieActor
        WHERE MovieID = SerialNumber
        GROUP BY ActorID, ReleasedYear
        ORDER BY ReleasedYear
    )
) list2
WHERE  list1.ActorID = list2.ActorID AND list2.ActorID = ID AND list2.ro= list1.ro+1
GROUP BY ID, FirstName, LastName
HAVING MAX(list2.year- list1.year)<=2 
;