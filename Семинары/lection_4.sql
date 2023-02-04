select count(user_id),
	case 
		when amount < 50 then '< 50'
		when amount between 50 and 499 then '< 500'
		when amount >= 500 then '> 500'
	end as category
from transactions_day4
group by category


select user_id
from transactions_day4
group by user_id
having(count(amount between 250 and 499) - count(amount < 250) > 0)


select count(amount250) as d_1, count (amount between 250 and 499) as d_2,
	user_id
from transactions_day4
group by user_id


select user_id
from transactions_day4
where amount > 900
group by user_id
having(count(amount) < 100)

(select *
from generate_series(0,12)) t
	join
(select extract(month from dtime) as mnt
from transactions_day4) mon
	on mon = t
	
	
	
select s.student_id, sum(accepted::int) as total
from registry_day4 rd
left join students s on s.student_id = rd.student_id and subject = 'math'
where (group_code like 'М8О-101А-19')
group by s.student_id
order by total

select *
from task_book_day4 tbd 


select rd.student_id, sum(accepted::int) as total
from registry_day4 rd
left join task_book_day4 tbd on tbd.subject = rd.subject and tbd.task_no = rd.task_no
where  difficulty = 3
group by student_id
having (sum(accepted::int) > 5)


select *
from registry_day4

select rd.student_id 
from registry_day4 rd
full join students s on s.student_id = rd.student_id

SELECT *
	FROM (values(1),(1),(1),(1),(1)) a
	INNER JOIN (values(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) b
	ON a.column1 = b.column1;

select t.client_id, t.driver_id, u.banned
from trips t
left join users u on t.client_id = u.user_id or t.driver_id = u.user_id
where t.request_at between '2020-02-01' and '2020-02-03'
group by 
having u.banned = '0'

select u.user_id, role, banned, client_id, driver_id, status, request_at,
from users u
left join trips t on (u.user_id = t.client_id) or (u.user_id = t.driver_id) 


select client_id, driver_id
from(
select user_id as client_id, user_id as driver_id
from users
where banned = '0'
) t_1

select *
from users


select client_id, driver_id, trole
from trips t


right join trips t on (t.client_id = t_1.user_id and t_1.cli_ban ='1') or (t.driver_id = t_1.user_id and t_1.dri_ban ='1')
-- where cli_ban = '1' or dri_ban = '1'

select *
from users u 
full join trips t on t.client_id = u.user_id
where banned = '0'

select *
from users


-- кредит - списание, дебит - пополнение

with 
t_deb as
	(select acc_id, date, sum(amnt) as sum_deb
	from debit d 
	group by 1,2
	order by 1,2)
,
t_cred as
	(select acc_id, date, -sum(amnt) as sum_cred
	from credit c 
	group by 1,2
	order by 1,2)
 ,
 t_full as
 (
select 
	t_deb.acc_id as d_acc_id,
	t_deb.date as d_date, 
	t_deb.sum_deb as d_sum, 
	t_cred.acc_id as c_acc_id, 
	t_cred.date as c_date, 
	t_cred.sum_cred as c_sum
from t_deb
full join t_cred on t_deb.acc_id = t_cred.acc_id and t_deb.date = t_cred.date
 )
 select 
	coalesce(d_acc_id, c_acc_id) as acc_id, 
  coalesce(d_date, c_date) as date,
  coalesce(d_sum, 0) + coalesce(c_sum,0) as diff
 from t_full	
 order by 1, 2



-- РЕШЕНИЕ 1 ЗАДАЧИ ДЗ
 
 select
    request_at,
    round(sum(case when status like 'cancelled%' then 1 else 0 end)/count(request_at),2)  as cancel_rate   
from
(
    select 
        status, 
        request_at,
        case
            when client_id = user_id then client_id
            when driver_id = user_id then driver_id
        end as user_id
    from
        (
        select *
        from users u
        inner join trips t on t.client_id = u.user_id or t.driver_id = u.user_id
        where banned = 0 and request_at between '2020-02-01' and '2020-02-03'
        ) t_1
    )t_2
group by request_at

---------------------------------------------------- 

