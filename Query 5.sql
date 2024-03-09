-- QUERY 5 

-- LOAD DATA TO emp_transaction TABLE
insert into emp_transaction
select s.emp_id, s.emp_name, x.trns_type
, case when x.trns_type = 'Basic' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Allowance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Others' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Insurance' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'Health' then round(base_salary * (cast(x.percentage as decimal)/100),2)
	   when x.trns_type = 'House' then round(base_salary * (cast(x.percentage as decimal)/100),2) end as amount	   
from salary s
cross join (select income as trns_type, percentage from income
			union
			select deduction as trns_type, percentage from deduction) x order by emp_id , x.trns_type ;
select * from emp_transaction ;




-- SALARY REPORT
SELECT 
    emp_name as Employee,
    MAX(IF(trns_type = 'Basic', amount, NULL)) AS Basic,
    MAX(IF(trns_type = 'Allowance', amount, NULL)) AS Allowance,
    MAX(IF(trns_type = 'Others', amount, NULL)) AS Others,
    (MAX(IF(trns_type = 'Basic', amount, NULL)) + MAX(IF(trns_type = 'Allowance', amount, NULL)) + MAX(IF(trns_type = 'Others', amount, NULL))) AS Gross,
    MAX(IF(trns_type = 'Insurance', amount, NULL)) AS Insurance,
    MAX(IF(trns_type = 'Health', amount, NULL)) AS Health,
    MAX(IF(trns_type = 'House', amount, NULL)) AS House,
    (MAX(IF(trns_type = 'Insurance', amount, NULL)) + MAX(IF(trns_type = 'Health', amount, NULL)) + MAX(IF(trns_type = 'House', amount, NULL))) AS Total_Deductions,
    ((MAX(IF(trns_type = 'Basic', amount, NULL)) + MAX(IF(trns_type = 'Allowance', amount, NULL)) + MAX(IF(trns_type = 'Others', amount, NULL))) - 
    (MAX(IF(trns_type = 'Insurance', amount, NULL)) + 
MAX(IF(trns_type = 'Health', amount, NULL)) + MAX(IF(trns_type = 'House', amount, NULL)))) AS Net_Pay
FROM 
    emp_transaction
GROUP BY 
    Employee;
    

    


