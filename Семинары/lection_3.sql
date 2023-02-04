select *
from students
order by studentship > 20000, studentship

select studentship,
case
	WHEN studentship > 20000 THEN 1 else 0 
END AS category
FROM students
order by category

select 
	count(*),
	greatest(count(*)-count(open), count(*)-count(low), count(*)-count(high)) as number
from stocks

select 	
	sum(open)/nullif(count(open),0) as aver
from stocks

select 
	max(close - open) as diff
from stocks

select 
	"month", avg(volume) as V
from stocks
group by "month"
order by V
-- group by выполняется до select поэтому сначала группирует по месяцам, а потом по ним среднее считает

select random()-0.5 as x, random()-0.5 as y
from generate_series(0,10)

select base, avg(cost) as aver
from operations
group by base

select
	extract(years from date) as years, count(distinct "month")
from stocks
group by extract(years from date)

select model
from PC
where price in 
	(select max(price)
	from PC
	)


select avg(speed)
from PC
where model in
	(
	select model
	from product
	where maker = 'A'
	)
	


select student_id,
      sum(case when mark in (3,4,5) then 1
      else 0 end) as good_score
from register r 
group by student_id


select request_at, count(status like 'cancelled_%')/nullif(count(status),0) as cancel_rate
from trips
where (client_id in 
        (
        select user_id
        from users
        where role = 'client' and banned = 0
        ) or
      driver_id in
        (
        select user_id
        from users
        where role = 'driver' and banned = 0
        )
        ) and
     request_at between '2020-02-01' and '2020-02-03'
group by request_at


select request_at, 
	round(count(can)/count(*),2) as cancel_rate
from
(select request_at,
	case 
		when status like '%cancelled%' then 1
		else NULL
	end as can	
from trips) as t_1
group by request_at 


select *
from trips
order by request_at

select *
from users
	
	
	