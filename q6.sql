SELECT Title, MAX(Rate)-MIN(Rate) AS RatingSpan
FROM Movie,MovieRate
WHERE SerialNumber = MovieID
GROUP BY Title
ORDER BY RatingSpan DESC;