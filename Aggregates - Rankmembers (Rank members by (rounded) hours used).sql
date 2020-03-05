with sum as (
  select mem.firstname, mem.surname, SUM(bks.slots)/2 as totalhours from
  	cd.members mem
  	inner join cd.bookings bks
  		on mem.memid = bks.memid
  group by mem.firstname, mem.surname
)
select firstname, surname, round(totalhours,-1),
rank() over (order by round(totalhours,-1) desc) rank from sum
	order by rank, surname, firstname
