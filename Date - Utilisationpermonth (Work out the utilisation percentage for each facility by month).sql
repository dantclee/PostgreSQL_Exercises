-- calculate number of days each month
with days_per_month as (select distinct extract(month from starttime) as month,
	cast((date_trunc('month',starttime) + interval '1 month') as date) -
  cast(date_trunc('month',starttime) as date) as days
  from cd.bookings),
-- calculate number of slots each day
slots_per_day as (select (extract(epoch from time '20:30:00') -
  extract(epoch from time '08:00:00')) / (30*60) as slots),
-- calculate number of slots each month
slots_per_month as (select days_per_month.month, days_per_month.days * slots_per_day.slots as monthly_slots
  from days_per_month, slots_per_day),
-- number of slots each month of each facility
slots_per_facility as (select facs.name, extract(month from bks.starttime) as month, sum(bks.slots) as monthly_slots
  from cd.bookings bks
  inner join cd.facilities facs
    on bks.facid = facs.facid
  group by name, month)

-- calculate utilization rate
select slots_per_facility.name, slots_per_facility.month,
  round(cast((slots_per_facility.monthly_slots/slots_per_month.monthly_slots*100) as numeric),2) as utilisation
  from slots_per_facility, slots_per_month
  where slots_per_facility.month = slots_per_month.month
  order by slots_per_facility.name, slots_per_facility.month
