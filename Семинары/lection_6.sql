-- Задача 1

select distinct student_id
from registry_day4 rd 
where (subject, task_no) in 
	(
	select subject, task_no
	from task_book_day4 tbd 
	where difficulty = 3 and subject = 'sql'
	)
and accepted = true

select distinct student_id
from registry_day4 rd 
where (subject, task_no) = any 
	(
	select subject, task_no
	from task_book_day4 tbd 
	where difficulty = 3 and subject = 'sql'
	)
	
select distinct student_id
from registry_day4 rd 
where exists 
	(
	select *
	from task_book_day4 tbd 
	where rd.subject = tbd.subject 
		and rd.task_no = tbd.task_no 
		and tbd.difficulty = 3 
		and tbd.subject = 'sql'
	)
	
-- Задача 2	
	
select *
from employee e
left join employee_trip et on e.id = et.employee_id
where et.employee_id is null

-- Памагити

-- Задача 3

select *
from employee e
where salary = all 
(
select max(salary)
from employee e  
)

select *
from employee e1
where not exists 
(
select *
from employee e2 
where e1.salary < e2.salary
)


-- Задача 9
select sd.student_id, sd.birthday
from students_day5 sd
where sd.birthday < all
(
select sd2.birthday
from students_day5 sd2 
where sd2.student_id = sd.senior
)
order by 1


select sd.student_id, sd.birthday
from students_day5 sd
where exists
(
select *
from students_day5 sd2 
where sd2.student_id = sd.senior and sd.birthday < sd2.birthday
)
order by 1

-- Задача 7

select *
from students_day5 sd 
order by birthday 
limit 1
offset 1

-- Задача 11

select *
from
(
select hi.item_id, coalesce(ip.price,0) as price, ip.actual_date
from h_item hi
left join s_item_price ip on hi.item_id = ip.item_id
order by 1
) t1
where t1.actual_date >= all
(
	select max(actual_date)
	from s_item_price ip
	where t1.item_id = ip.item_id
) or t1.actual_date is null

-------------------------------------

select *
from registry_day4 rd 

select *
from task_book_day4 tbd 

select distinct difficulty
from task_book_day4 tbd  
where (subject, task_no) = any 
	(
	select subject, task_no
	from registry_day4 rd  
	where accepted = true and subject = 'math'
	)



