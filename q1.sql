SELECT FirstName, LastName 
from IMDBPerson 
where ID IN(
    SELECT DISTINCT ActorID 
    from MovieActor 
    Where MovieID
    IN (SELECT SerialNumber from Movie Where Title LIKE '%Star War%')
);
