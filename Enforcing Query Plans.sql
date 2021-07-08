CREATE DATABASE Project_Part3
GO

USE Project_Part3
GO

-- Creating 3 tables T1, T2, T3
CREATE TABLE T1
(
	a int not null primary key,
	b int,
	c int
)

CREATE TABLE T2
(
	a int not null primary key,
	b int,
	c int
)

CREATE TABLE T3
(
	a int not null,
	b int,
	c int
)

CREATE TABLE T4
(
	a int not null,
	b int,
	c int
)
GO


--Drop table T1, T2, and T3 if needed
drop table T1
drop table T2
drop table T3

--Check Tables
select * from T1
select * from T2
select * from T3
select * from T4

--Delete all contents from T1, T2, and T3
delete from T1
delete from T2
delete from T3
delete from T4

--Fill data into tables
DECLARE @i1 int = 0
WHILE @i1 < 10000
BEGIN
    SET @i1 = @i1 + 1
    INSERT INTO T1 values(@i1, @i1, @i1*7)
END

DECLARE @i2 int = 0
WHILE @i2 < 30000
BEGIN
    SET @i2 = @i2 + 1
    INSERT INTO T2 values(@i2, @i2%10, @i2*3)
END

DECLARE @i3 int = 0
WHILE @i3 < 70000
BEGIN
    SET @i3 = @i3 + 1
    INSERT INTO T3 values(@i3, @i3%100, @i3*2)
END

DECLARE @i4 int = 0
WHILE @i4 < 70000
BEGIN
    SET @i4 = @i4 + 1
    INSERT INTO T4 values(@i4, @i4%100, @i4*2)
END

--Query 1
--Initial query
Select * from T1 join T2 on T1.a = T2.a WHERE T1.c%7 = 1
--Optimized query
Select * from T1 join T2 on T1.a = T2.a WHERE T1.c%7 = 1
option (loop join)

--Query 2
--Initial query
Select * from T3 join T4 on T3.a = T4.a
--Optimized query
Select * from T3 join T4 on T3.a = T4.a option (merge join)

--Query 3
--Initial query
Select * from T2 join T3 on T2.c > T3.c and T2.b = T3.b
--Optimized query
Select * from T2 join T3 on T2.c > T3.c and T2.b = T3.b
option (hash join)

--Query 4
--Initial query
Select count(T3.b) from T3 WHERE T3.c%2 = 1 group by T3.b
--Optimized query
Select count(T3.b) from T3 WHERE T3.c%2 = 1 group by T3.b
option (order group)

--Query 5
--Initial query
Select * from T2 join T4 on T2.a = T4.a
	WHERE T2.a > 1 AND T4.c > 1
	order by T4.c
--Optimized query
Select * from T2 join T4 on T2.a = T4.a
	WHERE T2.a > 1 AND T4.c > 1
	order by T4.c
	option (merge join)