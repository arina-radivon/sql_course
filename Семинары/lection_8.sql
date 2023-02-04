-- Задача 1

with t1 as(
select player_id,
	max(training_result) over (partition by player_id) as result,
	training_date,
	training_result 
from d8_training_log
order by 1
)
select player_id, min(training_date), result
from t1
where result = training_result 
group by 1,3
order by 1

-- Задача 2

select 
	distinct player_id,
	sum(score) over (partition by player_id),
	max(match_date) over (partition by player_id)
from d8_tournament_log
order by 1

-- Здача 3

select distinct match_date, 
	   player_id, 
	   sum(score) over (partition by player_id  order by match_date)
from d8_tournament_log
order by 2, 1

-- Задача 4

select player_name,
	   registration_date,
	   registration_date - min(registration_date) over () as reg1
from d8_player


-- Задача 5

select 
	player_id,
	training_date,
	training_result/(sum(training_result) over (partition by player_id) :: float) as total
from d8_training_log
order by 1


-- Задача 6

select distinct
	player_id,
	training_date,
	sum(training_result) over (partition by player_id 
								order by training_date
								rows between unbounded preceding and current row)
from d8_training_log
order by 1, 2







