SELECT  Abs(AVG(AvgAfter)-AVG(AvgBefore)) AS TheAbsDifference
FROM (
    SELECT  MovieID, TiTle, ReleasedYear, AVG(Rate) AS AvgAfter
    FROM MovieRate, Movie
    WHERE MovieID = SerialNumber AND ReleasedYear >= 2005
    GROUP BY MovieID,TiTle, ReleasedYear
),(
    SELECT  MovieID, TiTle, ReleasedYear, AVG(Rate) AS AvgBefore
    FROM MovieRate, Movie
    WHERE MovieID = SerialNumber AND ReleasedYear < 2005
    GROUP BY MovieID,TiTle,ReleasedYear
);