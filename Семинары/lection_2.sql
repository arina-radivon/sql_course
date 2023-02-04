select name, coalesce(group_code, 'Unknown group') as group_code
from students

select name, birthday
from students
order by extract(month from birthday), extract(day from birthday)

select distinct group_code
from students
where studentship >= 20000

select *
from delivery_orders
where status <> 'cancelled' or status is null

select name, student_id, MOD(student_id, 2) as id_mod
from students 
order by id_mod, student_id desc

select name, student_id, group_code
from students
where (group_code = 'М8О-101А-19' or group_code = 'М8О-104А-19') and MOD(student_id, 3) = 0
--where group_code in ('М8О-101А-19', 'М8О-104А-19') and MOD(student_id, 3) = 0

select surname, address, tax
from employees
where address like 'Выкса%' or address like 'Навашино%'

select nomination, base, cost
from operations
where (nomination like 'Инъекция%') and (cost > 10000)
order by 2, 3

select *
from delivery_orders
where (sum between 3000 and 10000) and status = 'cancelled'

select *
from delivery_orders
where status = 'cancelled' or status = 'returned'

select *
from students
where (studentship < 30000) and group_code notnull 
order by birthday 

select *
from cities 
order by city = 'Санкт-Петербург' desc, city = 'Москва', city desc


