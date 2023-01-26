use tutorial;
-- 										Task 1
create table shopping_history(
Product varchar(30) not null,
Quantity integer not null,
Unit_price integer not null);

insert into  shopping_history values('milk',3,10);
insert into  shopping_history values('bread',7,3),('bread',5,2);

select * from shopping_history;
--  									Task 1 Result
select Product, sum(Quantity*Unit_price) as Total_price from shopping_history
group by 1
order by 1;

-- 								 Task 2 telecommunication company
create table phones(
name varchar(20) not null unique,
phone_number int not null unique);

create table calls(
id int not null,
caller int not null,
callee int not null,
duration int not null,
unique(id));

insert into phones values('Jack',1234),
('Lena',3333),('Mark',9999),('Anna',7582);
insert into calls values(25,1234,7582,8),(7,9999,7582,1),(18,9999,3333,4),
(2,7582,3333,3),(3,3333,1234,1),(21,3333,1234,1);

select * from calls;
select * from Phones;
create table call_duration(select callee as 'phone_number',sum(duration) as 'total_duration' from calls group by phone_number);
insert into call_duration(select caller as 'phone_number',sum(duration) as 'total_duration' from calls group by phone_number);

select * from call_duration;

select * from calls;
select * from Phones;
-- 										 Result for task 2.1
select a.name from phones as a join call_duration as b 
on a.phone_number=b.phone_number
group by b.phone_number having sum(b.total_duration)>=10;

--  										task2.2
create table tbl_phones(
`name` varchar(20),
phone_number int);

create table tbl_calls(
id int,
caller int,
callee int,
duration int);
insert into tbl_phones values('John',6356),('Addison',4315),('Kate',8003),('Ginny',9831);
insert into tbl_calls values(65,8003,9831,7),(100,9831,8003,3),(145,4315,9831,18);

create table tbl_duration(select caller as 'Phone_number',sum(duration) as cd from tbl_calls group by caller);
insert into tbl_duration(select callee as 'Phone_number',sum(duration) as cd from tbl_calls group by callee);
select * from tbl_duration;

select * from tbl_phones;
select * from tbl_calls;

-- 								 Result for Task 2.2
select a.name from tbl_phones as a join tbl_duration as b on a.Phone_number=b.Phone_number
group by b.Phone_number 
having sum(b.cd)>=10
order by a.name ;

--  									TASK-3  3.1
create table transactions1(
amount int not null,
`data` date not null);

insert into transactions1 values(1000,'2020-01-06');
insert into transactions1 values(-10,'2020-01-14'),(-75,'2020-01-20'),(-5,'2020-01-25'),
(-4,'2020-01-29'),(2000,'2020-03-10'),(-75,'2020-03-12'),(-20,'2020-03-15'),(40,'2020-03-15'),
(-50,'2020-03-17'),(200,'2020-10-10'),(-200,'2020-10-10');

select sum(amount)-(5*(12-(select * from transactions1 where amount<=0
group by date_format(`data`,'%m')
having sum(amount)<=-100 and count(`data`)>=3))) from transactions1;

create table okch(select date_format(`data`,'%m')as mn from transactions1
where amount<=0
group by mn
having sum(amount)<=-100 and count(amount)>=3);

select * from transactions1;
-- 									Result for task 3.1
select sum(amount)-(5*(12-(select count(*) okch))) as amount from transactions1;

-- 									 TASK-3  3.2
create table transactions2(
amount int not null,
`date` date not null);

insert into transactions2 values(1,'2020-06-29');
insert into transactions2 values(35,'2020-02-20'),(-50,'2020-02-03'),
(-1,'2020-02-26'),(-200,'2020-08-01'),(-44,'2020-02-07'),(-5,'2020-02-25'),(1,'2020-06-29'),
(1,'2020-06-29'),(-100,'2020-12-29'),(-100,'2020-12-30'),(-100,'2020-12-31');

create table cardfee2 (select date_format(`date`,'%m') as mn from transactions2
where amount<0
group by mn 
having sum(amount)<=-100 and count(amount)>=3);

create table amount2(select (sum(amount) - (5*(12-(select count(*) from cardfee2)))) as balance from transactions2);

select * from transactions2;
--  							Result for Task 3.2
select * from amount2;

-- 								 TASK-3  3.3
create table transactions3(
amount int not null,
`date` date not null);

insert into transactions3 values(6000,'2020-04-03'),(5000,'2020-04-02'),(4000,'2020-04-01'),(3000,'2020-03-01'),
(2000,'2020-02-01'),(1000,'2020-01-01');

create table cardfee3(select date_format(`date`,'%m') as mn from transactions3
where amount<0
group by mn
having sum(amount)>=-100 and count(amount)>=3);

create table balance3(select sum(amount)-(5*(12-(select count(*) from cardfee3))) as balance from transactions3);
select * from transactions3;
-- 								 Result for task 3.3
select * from balance3;