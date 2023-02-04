-- Задача 1

select *,
	   lag(price, 1, 0) over(partition by item_id order by actual_date),
	   first_value(price) over(partition by item_id order by actual_date), 
	   last_value(price) over(partition by item_id order by actual_date rows between unbounded preceding and unbounded
 following)
from d8_item_price dip

-- Задача 3

with t1 as(
select *,
	   first_value(amnt) over(partition by acc_id order by log_id desc) - 
	   first_value(amnt) over(partition by acc_id order by log_id) as diff	   
from d9_credit
)
select distinct acc_id
from t1
where diff = (select max(diff) from t1)

-- Задача 4

with calendar as (
    select item_id, '2021-01-06'::date + generate_series(0, 4) dt
    from d9_h_item
    order by 1, 2)
, discount as (select *, lead(actual_date, 1, '9999-12-31'::date) over (partition by item_id order by actual_date) lead_actual_date
				from d9_s_item_discount)
select calendar.*, discount
from calendar
left join discount on calendar.item_id = discount.item_id
                  and actual_date <= calendar.dt
                  and calendar.dt < lead_actual_date
order by calendar.item_id, calendar.dt

-- Задача 5
with t1 as(
select *,
		case
			when lag(eventtype) over(partition by user_id order by event_date) = 'D'
			then 1
			else 0
		end	as start
from clickstream c 
)
,
t2 as(
select *,
		sum(start) over (partition by user_id order by event_date) as eventnew
from t1
)
select user_id, eventnew, min(event_date) as date_start, max(event_date) as date_end
from t2 
group by 1,2
order by 1,2




