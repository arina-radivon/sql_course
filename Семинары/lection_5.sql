select user_id
from transactions_day4
where amount > 900
group by user_id
having(count(amount) < 100)


select rd.subject, rd.task_no, rd.accepted, tbd.difficulty
from registry_day4 rd 
left join task_book_day4 tbd on (rd.subject = tbd.subject and rd.task_no = tbd.task_no)
where student_id = '13'
order by 1,2


select tbd.subject, tbd.task_no, rd.accepted, tbd.difficulty
from task_book_day4 tbd 
left join registry_day4 rd 
on (rd.subject = tbd.subject and rd.task_no = tbd.task_no and student_id = '13' )
where tbd.subject = 'sql'
order by 1,2


select sd.student_id, tbd.subject, tbd.task_no, rd.accepted, tbd.difficulty
from task_book_day4 tbd
cross join students_day5 sd 
left join registry_day4 rd 
	on rd.subject = tbd.subject 
		and rd.task_no = tbd.task_no 
		and rd.student_id  = sd.student_id
where tbd.subject = 'sql' 
and (sd.student_id = '13' or sd.student_id = '25')
order by 1,3


select group_code, Sum(case when tbd.difficulty = 3 
							and accepted = true then 1
							else 0 end) as total_sum
from task_book_day4 tbd 
cross join students_day5 sd 
left join registry_day4 rd 
	on rd.task_no = tbd.task_no and 
	   rd.subject = tbd.subject 
	   and rd.student_id  = sd.student_id
group by group_code
order by 2 desc


select sd_2.student_id, sd_2.name, sd_2.senior, sd.student_id, sd.name
from students_day5 sd 
join students_day5 sd_2 on sd.student_id = sd_2.senior
where sd_2.studentship > sd.studentship 


select *
FROM
(
	SELECT *
	FROM debit d  
	JOIN debit d2 
	ON d.acc_id = d2.acc_id 
		and d.date >= d2.date
) t
order by 2

 
SELECT d.acc_id, d.date, sum(d2.amnt)
FROM 
	(
	select distinct acc_id, date
	from debit
	) d
JOIN debit d2 
ON d.acc_id = d2.acc_id 
		and d.date >= d2.date
group by 1,2
order by 1,2



select sd.student_id
from students_day5 sd 
join students_day5 sd2 on sd.student_id = sd2.senior
group by sd.studentship, sd.student_id
having (sd.studentship < avg(sd2.studentship))


select 
	sd.name as name_from, 
	sd2.name as name_to, 
	pd.name as platform, 
	sum(td.amount) as money
from transactions_day5 td 
left join students_day5 sd on td.from_student_id = sd.student_id 
left join students_day5 sd2 on td.to_student_id = sd2.student_id 
left join platforms_day5 pd on td.platform_id =pd.id 
where sd.name = 'Петров Петр Петрович' 
	  and sd2.name = 'Куприянов Евлампий Денисович'
group by 1, 2, 3
order by 1, 2, 3















