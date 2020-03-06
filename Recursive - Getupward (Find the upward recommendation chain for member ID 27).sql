WITH RECURSIVE rec AS (
   SELECT
      memid,
      firstname,
      surname,
   FROM
      cd.members
   WHERE
      memid = (select recommendedby from cd.members where memid = 27)
UNION 
     SELECT
        mem.memid,
        mem.firstname,
        mem.surname
     FROM
        cd.members mem, rec
     WHERE
        mem.memid = (select mem.recommendedby from mem where mem.memid = rec.memid)
) SELECT
  *
FROM
  rec;
