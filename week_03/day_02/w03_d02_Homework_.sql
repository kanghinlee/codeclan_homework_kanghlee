--MVP

---------------- Question 1 ----------------
--General
select*
from teams t ;
select*
from employees e ;

--Question 1 (a)
select
t,
e.first_name,
e.last_name
from teams as t left join employees as e
on t.id = e.team_id;

--Question 1 (b)
select
t,
e.first_name,
e.last_name,
e.pension_enrol
from teams as t left join employees as e
on t.id = e.team_id
where e.pension_enrol is true

--Question 1 (c)
select
t,
e.first_name,
e.last_name
from teams as t left join employees as e
on t.id = e.team_id
where cast(charge_cost as int) > 80;


---------------- Question 2 ----------------

--Question 2 (a)
select*
from employees e ;
select*
from pay_details pd ;
select*
from teams t ;

--Question 2 (a)
select 
	e.*,
	pd.local_sort_code,
	pd.local_tax_code 
from employees as e left join pay_details as pd
on e.id = pd.id;

--Question 2 (b)
select 
	e.*,
	pd.local_sort_code,
	pd.local_tax_code,
	t.name
from (
		employees as e left join pay_details as pd
		on e.id = pd.id)
left join teams as t
on t.id = e.team_id

---------------- Question 3 ----------------

--Question 3 (a)
select*
from employees e ;
select*
from teams t ;

--Question 3 (b)
select 	
	t.id,
	t.name,
	count(e.team_id)
from teams as t left join employees as e
on t.id = e.team_id
group by t.id
--Question 3 (c)
order by count(*)


---------------- Question 4 ----------------

--Question 4 (a) & (b)
select 	
	t.*,
	count(e.team_id) as head_count,
	
cast(t.charge_cost as int)*count(e.team_id) as total_day_charge
from teams as t left join employees as e
on t.id = e.team_id
group by t.id


--Question 4 (c) Doesnt work
select 	
	t.*,
	count(e.team_id) as head_count,
cast(t.charge_cost as int)*count(e.team_id) as total_day_charge
from teams as t left join employees as e
on t.id = e.team_id
where 'total_day_charge' > 5000
group by t.id

