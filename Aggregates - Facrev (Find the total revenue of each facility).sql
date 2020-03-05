
select name, SUM(revenue) as revenue from (
    select facs.name as name,
      case
        when bks.memid = 0 then
          bks.slots*facs.guestcost
        else
          bks.slots*facs.membercost
      end as revenue
      from
        cd.bookings bks
        inner join cd.facilities facs
          on bks.facid = facs.facid) as bookings
  group by name
  order by SUM(revenue);
