SELECT FirstName|| ' ' || LastName AS Name, COUNT(ID) AS Counting
FROM IMDBPerson, Movie
WHERE ID = DirectorID
GROUP BY ID, FirstName,LastName
HAVING  COUNT(ID)>=5
ORDER BY COUNT(ID)
;