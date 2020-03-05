with sum as (
  select facid, sum(slots) as totalslots
	from cd.bookings
	group by facid
), ranking as(
	select facid, totalslots, rank() over(order by totalslots desc) rank
	from sum
)

select facid, totalslots as total from ranking
where rank = 1
