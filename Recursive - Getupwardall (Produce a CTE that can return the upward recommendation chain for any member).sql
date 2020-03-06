WITH RECURSIVE recommenders (memid, recommender) AS (
  SELECT
    memid,
    recommendedby
  FROM
    cd.members
  UNION ALL
  SELECT
    recs.memid,
    mem.recommendedby
  FROM
    cd.members mem
  INNER JOIN recommenders recs
    ON mem.memid = recs.recommender
)
SELECT
  recs.memid,
  recs.recommender,
  mem.firstname,
  mem.surname
FROM recommenders recs
INNER JOIN cd.members mem
  ON recs.recommender = mem.memid
WHERE recs.memid = 12 or
      recs.memid = 22
ORDER BY recs.memid ASC, recs.recommender DESC
