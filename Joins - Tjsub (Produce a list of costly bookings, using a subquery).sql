select mems.firstname || ' ' || mems.surname as member,
	facs.name as facility, squery.cost

        from
						(select 
							case
								when mems.memid = 0 then
									bks.slots*facs.guestcost
								else
									bks.slots*facs.membercost
							end as cost
							from
								cd.members mems
                inner join cd.bookings bks
                        on mems.memid = bks.memid
                inner join cd.facilities facs
                        on bks.facid = facs.facid) squery
        where
		bks.starttime >= '2012-09-14' and
		bks.starttime < '2012-09-15' and
		squery.cost > 30
order by squery.cost desc;
