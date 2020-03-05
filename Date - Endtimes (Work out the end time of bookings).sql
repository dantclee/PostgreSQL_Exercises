select starttime, endtime from
(select starttime, starttime + interval '30 minute'*slots as endtime, rank() over (order by starttime desc) as rank
from cd.bookings
group by starttime, endtime) as subq
where rank<=10
order by endtime desc, starttime desc
