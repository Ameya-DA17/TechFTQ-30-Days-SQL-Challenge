-- QUERY 1

/* Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

- For brands that do not have pairs in the same year : keep those rows as well
*/


DROP TABLE IF EXISTS brands;
CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT
);
INSERT INTO brands VALUES ('apple', 'samsung', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('samsung', 'apple', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('apple', 'samsung', 2021, 1, 2, 5, 3);
INSERT INTO brands VALUES ('samsung', 'apple', 2021, 5, 3, 1, 2);
INSERT INTO brands VALUES ('google', NULL, 2020, 5, 9, NULL, NULL);
INSERT INTO brands VALUES ('oneplus', 'nothing', 2020, 5, 9, 6, 3);

SELECT * FROM brands;




--- VIDEO_Q1 ---

-- Solution 
with cte as
            (select *
            , case when brand1 < brand2 
                              then concat(brand1,brand2,year)
                     else concat(brand2,brand1,year)
              end as pair_id
            from brands),
      cte_rn as
            (select * 
            , row_number() over(partition by pair_id order by pair_id) as rn
            from cte)
select brand1, brand2, year, custom1, custom2, custom3, custom4
from cte_rn
where rn = 1 
or (custom1 <> custom3 and custom2 <> custom4)  ;


drop table if exists mountain_huts;
create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;



-- SOLUTION
with cte_trails1 as
		(select t1.hut1 as start_hut, h1.name as start_hut_name
		 ,h1.altitude as start_hut_altitude, t1.hut2 as end_hut
		from mountain_huts h1
		join trails t1 on t1.hut1 = h1.id),
	cte_trails2 as
		(select t2.*, h2.name as end_hut_name, h2.altitude as end_hut_altitude
		, case when start_hut_altitude > h2.altitude then 1 else 0 end as altitude_flag
		from cte_trails1 t2
		join mountain_huts h2 on h2.id = t2.end_hut),
	cte_final as
		(select case when altitude_flag = 1 then start_hut else end_hut end as start_hut
		, case when altitude_flag = 1 then start_hut_name else end_hut_name end as start_hut_name
		, case when altitude_flag = 1 then end_hut else start_hut end as end_hut
		, case when altitude_flag = 1 then end_hut_name else start_hut_name end as end_hut_name
		from cte_trails2)
select c1.start_hut_name as startpt
, c1.end_hut_name as middlept
, c2.end_hut_name as endpt
from cte_final c1
join cte_final c2 on c1.end_hut = c2.start_hut;

    
