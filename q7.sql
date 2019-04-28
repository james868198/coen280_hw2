SELECT ActorName, ActressName ,COUNT(MMID) AS TogetherCounting
FROM 
(SELECT MovieID AS MMID, FirstName|| ' ' || LastName AS ActorName
FROM IMDBPerson, MovieActor
WHERE ID = ActorID and Gender = 'M'
GROUP BY FirstName,LastName,MovieID),
(SELECT MovieID AS FMID, FirstName|| ' ' || LastName AS ActressName
FROM IMDBPerson, MovieActor
WHERE ID = ActorID and Gender = 'F'
GROUP BY FirstName,LastName,MovieID)
WHERE MMID = FMID
GROUP BY ActorName,ActressName
HAVING COUNT(MMID)>=2
ORDER BY TogetherCounting DESC;