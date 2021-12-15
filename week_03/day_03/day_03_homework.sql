--Week 3, Day 03 Lab/Homeowkr


---------------- MVP ----------------

------------ General  -------------

select*
from employees e ;

select*
from committees c;

select*
from employees_committees ec ;

select*
from pay_details pd ;

select*
from teams t ;

------------ Question 1 -------------
select 
count(e.id) as no_grade_n_salary
from employees as e
where e.grade is null and e.salary is null;


------------ Question 2 -------------
select
	e.department,
	e.first_name,
	e.last_name
from employees as e
order by e.department, e.last_name 

------------ Question 3 -------------
select 
	e.first_name,
	e.last_name,
	e.salary
from employees as e
--order by e.last_name 
where lower(e.last_name) like 'a%' and salary notnull
order by salary desc
fetch first 10 rows only;


------------ Question 4 -------------

select 
	count(e.id) as worker_in_2003
from employees as e
WHERE e.start_date BETWEEN '20030101' and '20031231';


------------ Question 5 -------------

select 
	e.department,
	e.fte_hours,	
	count(fte_hours) as employee_fte_hour_cat
from employees as e	
group by e.department, fte_hours
order by e.department, fte_hours desc;


------------ Question 6 -------------

select 
	count(*) filter (where e.pension_enrol is true) as enroll_to_pension,
	count(*) filter (where e.pension_enrol is false) as not_enroll_to_pension,
	count(*) filter (where e.pension_enrol is null) as unknown_to_pension
	from employees as e 
group by e.pension_enrol;

------------ Question 7 -------------
--Obtain the details for the employee with the highest salary in the ‘Accounting’ department who is not enrolled in the pension scheme?

select 
	e.id,
	e.first_name,
	e.last_name,
	e.salary
from employees as e
--order by e.last_name 
where e.department = 'Accounting' and salary notnull
-- Alternatively "Order by salary desc nulls last" 
order by salary desc
fetch first 1 rows only;

------------ Question 8 -------------
--Get a table of country, number of employees in that country, 
--and the average salary of employees in that country for any countries in which more than 30 employees are based. 
--Order the table by average salary descending.

select 
	e.country,
	count(e.id) as num_employees,
	cast(avg(e.salary) as decimal(10,2)) as avg_salary
from employees as e
group by country 
having count(e.id) > 30
order by avg(e.salary) desc

------------ Question 9 -------------
--Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, 
--and a new column effective_yearly_salary 
--which should contain fte_hours multiplied by salary. 
--Return only rows where effective_yearly_salary is more than 30000.

select 
	e.first_name,
	e.last_name,
	e.fte_hours,
	e.salary,
	(e.fte_hours * e.salary) as effective_yearly_salary
from employees as e 
group by e.first_name, e.last_name, e.fte_hours, e.salary
having e.fte_hours*e.salary > 30000
order by (e.fte_hours * e.salary) desc

------------ Question 10 -------------

select 
	e.first_name,
	e.last_name,
	e.team_id
from employees as e 
where e.team_id = '1' or e.team_id = '2'
order by 	e.last_name, e.team_id


------------ General  -------------
------------ General  -------------

select*
from employees e ;

select*
from committees c;

select*
from employees_committees ec ;

select*
from pay_details pd ;

select*
from teams t ;


------------ Question 11 -------------
select 
	e.first_name,
	e.last_name,
	pd.local_tax_code
from pay_details as pd left join employees e 
on e.id = pd.id
where pd.local_tax_code isnull;

------------ Question 12 -------------

select 
	e.first_name,
	e.last_name,
	e.team_id,
	t.charge_cost,
	(((48*35*cast(t.charge_cost as int)) - e.salary)*e.fte_hours) as expected_profit
from teams as t left join employees as e 
on e.team_id = t.id
where t.charge_cost notnull and salary notnull and fte_hours notnull;

------------ Question 13 -------------


--Find the first_name, last_name and salary

--who works the least common full-time 
--of the lowest paid employee in Japan 
--equivalent hours across the corporation.”

select
	e.first_name,
	e.last_name,
	e.salary,
	e.country,
	count(e.fte_hours) as fte_count_num
from employees as e
group by 
		e.first_name,
		e.last_name,
		e.salary,
		e.country
where country = 'Japan' and e.fte_hours in (select
												e.fte_hours
											from 
												employees as e
											group by 
												e.fte_hours
											having max(count(fte_hour))
)
;

--fetch first 1 rows only;
--where e.country is 'Japan' 
-- e.salary
--and fte_hours notnull  and salary notnull


(select
	e.fte_hours
from 
	employees as e
group by 
	e.fte_hours
having max(count(fte_hour)))


SELECT *
FROM employees
WHERE 
	country = 'United States' AND fte_hours IN (
  												SELECT fte_hours
												FROM employees
												GROUP BY fte_hours
												HAVING COUNT(*) = (
												    				SELECT MAX(count)
												    				FROM (
												      						SELECT COUNT(*) AS count
												      						FROM employees
												      						GROUP BY fte_hours
												    						) AS fte_max_count
  )
)


select 
	e.country,	
	e.first_name,
	e.last_name,
	e.salary
from employees as e 
where e.country = 'Japan'

	
	
-- Count FTE CAT	
select 
		count(*) as count
		from employees
		where country = 'Japan'
		group by fte_hours	
		
-- Find MAX in FTE CAT COUNT		
select max(count) as max_fte_count
from (select 
		count(*) as count
		from employees
		where country = 'Japan'
		group by fte_hours	
		) as max_fte_count;
		
--		
	
select *
	e.country,	
	e.first_name,
	e.last_name,
	e.salary,
	max(count) as max_fte_count
from employees as e 
where country = 'Japan' and e.fte_hours in (select 
											count(*) as count
											from employees
											group by fte_hours	
											) as max_fte_count)
											
											
------------ Question 14 -------------

------------ General  -------------
------------ General  -------------

select*
from employees e ;
--Obtain a table showing any departments 
--in which there are two or more employees lacking a stored first name. 
--Order the table in descending order of the number of employees lacking a first name, 
--and then in alphabetical order by department.			

select
e.department,
count(*) as first_name_null
from employees as e
where e.first_name isnull 
group by e.department,
e.first_name,
e.last_name;

											
count(*) where count first_name isnull 											
											

		-- 									
		select 
			department,
			count(*) as null_count
		from employees
		where first_name is null
		group by department
		having count(*) >2
		--;
