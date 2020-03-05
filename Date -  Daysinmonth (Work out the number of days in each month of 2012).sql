select sr.endt - sr.startt as length from

select generate_series(date '2012-01-01', date '2012-12-31', interval '1 month') as startt,
generate_series(date '2012-01-31', date '2012-12-31', interval '1 month') as endt
