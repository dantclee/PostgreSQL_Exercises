SELECT facid, MAX(totalslots) from (
SELECT facid, SUM(slots) AS totalslots FROM cd.bookings
GROUP BY facid) as addition
GROUP BY facid
