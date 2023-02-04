-- Задача 1

create table avradivon_clients(
	client_id int,
	name varchar(255),
	surname varchar(255),
	total_orders int
)

select *
from avradivon_clients

-- Задача 2

create table avradivon_orders(
	order_id int,
	client_id int,
	name_good varchar(255),
	amnt int,
	price int
)

select *
from avradivon_orders

-- Задача 3

-- 1 вариант
insert into avradivon_clients values
(1, 'Mary', 'Novikova', null),
(2, 'Ivan', 'Petrov', null),
(3, 'Kirill', 'Ivanov', null)

select *
from avradivon_clients

-- 2 вариант
insert into avradivon_orders
select 1, 1, 'Mary', 5, 1000
union all 
select 2, 2, 'Ivan', 7, 10000
union all 
select 3, 2, 'Ivan', 1, 30

select *
from avradivon_orders

-- Задача 4

update avradivon_clients cl
set total_orders = (select count(order_id) from avradivon_orders o where o.client_id = cl.client_id)
where true

select *
from avradivon_clients

-- Задача 5
-- удаление
ALTER TABLE avradivon_clients DROP COLUMN patronimyc;
-- добавление
ALTER TABLE avradivon_clients add COLUMN patronimyc varchar(80);

select *
from avradivon_clients

-- Задача 6
-- удаление строк
delete from avradivon_clients where client_id = 1;

select *
from avradivon_clients

-- Задача 7
-- Пункт 1
ALTER TABLE avradivon_clients add COLUMN sum_orders int, notfinish_orders int

-- ALTER TABLE avradivon_clients add COLUMN notfinish_orders int

select *
from avradivon_clients

-- Пункт 2
create table avradivon_status(
	order_id int,
	order_status varchar(80)
)

select *
from avradivon_status

-- Пункт 3

insert into avradivon_status values
(1, 'rejected'),
(2, 'finished'),
(3, 'delivering')

select *
from avradivon_status

-- Пункт 4

update avradivon_clients cl
set sum_orders = (select sum(price) 
				  from avradivon_orders o 
				  where o.client_id = cl.client_id
				  )
where true

update avradivon_clients cl
set notfinish_orders = (select count(order_id) 
				  		from avradivon_orders o 
				  		where o.client_id = cl.client_id
				  		and o.order_id in (
				  					  select order_id
				  					  from avradivon_status 
				  					  where order_status != 'finished'
				  						  )
				  	   )
where true
							
select *
from avradivon_clients



