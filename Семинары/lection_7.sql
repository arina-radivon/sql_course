
-- Задача 1
with t1 as(
select *
from d7_set1 ds 
union all
select *
from d7_set2 ds2)
select distinct n from t1
order by 1


-- Задача 2
with t1 as(
select *
from d7_buyer db 
union
select *
from d7_seller ds 
union
select *
from d7_manager dm
)
select distinct surname
from t1
where id in(
			select id 
			from d7_user
			where registration_date > '2020-11-01'
			)
order by 1


-- Задача 3
with t1 as(
select *
from d7_buyer db 
union
select *
from d7_seller ds 
union
select *
from d7_manager dm
)
select count(id)
from
(
select id, max(last_action_date)
from t1
where last_action_date > '2020-06-01'
group by id
) t2


-- Задача 4
select *
from d7_set1 ds 
except
select*
from d7_set2
order by 1


select distinct d1.n
from d7_set1 d1
left join d7_set2 d2 on d1.n = d2.n
where d2.n is null
order by 1

-- Задача 5
select *
from d7_set1 ds 
intersect
select*
from d7_set2
order by 1


select distinct d1.n
from d7_set1 d1
inner join d7_set2 d2 on d1.n = d2.n
order by 1

-- Задача 6
select count(id)
from(
select id
from d7_seller ds 
except
select distinct id
from d7_buyer db 
where last_action_date > '2020-06-01'
)t1

-- Задача 7
select min(registration_date) 
from d7_user 
where id in (
select id
from d7_buyer db 
except
select id 
from d7_seller ds) 

-- Задача 8
select distinct date_trunc('month', registration_date)::date
from d7_user
except
select distinct date_trunc('month', registration_date)::date as registration_date 
from d7_user du 
where id in(
select id
from d7_buyer db 
intersect
select id 
from d7_seller ds
)
order by 1

-- Задача 9
select floor_id, room_id, count(distinct user_id), sum(paid)
from d7_hotel dh 
group by grouping sets(1,(1,2),())
order by 1,2


select 
	floor_id::varchar, 
	room_id::varchar, 
	sum(paid), 
	count(distinct user_id) 
from d7_hotel 
group by 1,2
union all
select 
	floor_id::varchar, 
	'Any', 
	sum(paid), 
	count(distinct user_id) 
from d7_hotel 
group by 1,2
union all
select 
	'Any', 
	'Any', 
	sum(paid), 
	count(distinct user_id) 
from d7_hotel 
group by 1,2


-- Задача 10

