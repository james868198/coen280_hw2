SELECT DISTINCT FirstName|| ' ' || LastName AS Name, TITLE, ReleasedYear
FROM IMDBPerson,Movie,Genre
WHERE ID = DirectorID AND MovieID = SerialNumber AND Genre = 'DRAMA' AND MOD(ReleasedYear,4) = 0 
;

