with recursive mem_recommended (memid) as (
	select memid from cd.members where recommendedby = 1
	union all
	select mems.memid
		from mem_recommended mem_rec
		inner join cd.members mems
			on mems.recommendedby = mem_rec.memid
)
select mem_rec.memid, mems.firstname, mems.surname
	from mem_recommended mem_rec
	inner join cd.members mems
		on mem_rec.memid = mems.memid
order by mem_rec.memid
