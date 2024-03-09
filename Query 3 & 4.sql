-- Query 3 
DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;
-- Solution 2:
select *
from (SELECT car FROM FOOTER where car is not null order by id desc limit 1) car
cross join (SELECT length FROM FOOTER where length is not null order by id desc limit 1) length
cross join (SELECT width FROM FOOTER where width is not null order by id desc limit 1) width
cross join (SELECT height FROM FOOTER where height is not null order by id desc limit 1) height;


-- Query 4

drop table if exists Q4_data;
create table Q4_data
(
	id			int,
	name		varchar(20),
	location	varchar(20)
);
insert into Q4_data values(1,null,null);
insert into Q4_data values(2,'David',null);
insert into Q4_data values(3,null,'London');
insert into Q4_data values(4,null,null);
insert into Q4_data values(5,'David',null);

select * from Q4_data;


-- OUTPUT 1
select min(id) as id
, min(name) as name
, min(location) as location
from Q4_data;



-- OUTPUT 2
select max(id) as id
, min(name) as name
, min(location) as location
from Q4_data;
