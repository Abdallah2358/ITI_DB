-- 1.  Create a scalar function that takes date and returns Month name of that 
-- date. 
CREATE FUNCTION  whatMonth ( @date date) RETURNS VARCHAR(5)
BEGIN
    RETURN  MONTH(@date)
END
go
select dbo.whatMonth('2022-12-27')
 

-- 2.   Create a multi-statements table-valued function that takes 2 integers 
-- and returns the values between them. 
go
CREATE FUNCTION  numsBetween ( @v1 int, @v2 int) RETURNS  @t table
(r int)	 as
    BEGIN
    declare @x int
    ;
    set @x= @v1 +1;
    while @x <@v2
        BEGIN
        insert @t
        select @x;
        set @x = @x + 1;
    END
    RETURN
END
go
select *
From dbo.numsBetween(1,5);
GO
 

-- 3.   Create inline function that takes Student No and returns Department 
-- Name with Student full name. 
CREATE FUNCTION stDep(@st_n int) 
returns table 
as  
return (select d.Dept_Name , (s.St_Fname+' ' + s.St_Lname) as ['Full Name']
from Student as s INNER JOIN Department as d
    on s.Dept_Id =d.Dept_Id
where s.St_Id = @st_n)
GO
select *
from stDep(2)
GO


-- 4.  Create a scalar function that takes Student ID and returns a message to 
-- user  
-- a.  If first name and Last name are null then display 'First name & 
-- last name are null' 
-- b.  If First name is null then display 'first name is null' 
-- c.  If Last name is null then display 'last name is null' 
-- d.  Else display 'First name & last name are not null' 
create FUNCTION  gotNull ( @s_id int ) RETURNS VARCHAR(50)
BEGIN
    declare @F_name VARCHAR(30)
    declare @L_name VARCHAR(30)

    select @F_name = s.St_Fname , @L_name =s.St_Lname
    from Student as s where s.St_Id =@s_id;

    IF  @F_name is null and @L_name is null 
BEGIN
        RETURN 'First name & last name are null'
    end
ELSE IF @F_name IS NULL 
BEGIN
        RETURN 'first name is null'
    end
ELSE IF @L_name IS NULL 
BEGIN
        RETURN 'last name is null'
    end
    RETURN 'First name & last name are not null'
END
go
select  dbo.gotNull(1)


-- 5.  Create inline function that takes integer which represents manager ID 
-- and displays department name, Manager Name and hiring date  
GO
create FUNCTION manger_info( @mng_id int ) RETURNS TABLE AS
RETURN (select d.Dept_Name , i.Ins_Name ,d.Manager_hiredate
from Instructor as i INNER JOIN Department as d
    on i.Ins_Id =d.Dept_Manager
where d.Dept_Manager = @mng_id)

go 
select * from manger_info(1)


-- 6.  Create multi-statements table-valued function that takes a string 
-- If string='first name' returns student first name 
-- If string='last name' returns student last name  
-- If string='full name' returns Full Name from student table  
-- Note: Use �ISNULL� function 
go
CREATE FUNCTION  tellMEThier ( @what VARCHAR (20)) RETURNS  @t table
(['Student Name'] VARCHAR (40))	 as
    BEGIN
    IF @what = 'first name'
    BEGIN
    insert @t  
        select ISNULL(s.St_Fname,'empty') from Student as s
    END
    IF @what = 'last name'
    BEGIN
    insert @t  
        select ISNULL(s.St_Lname, 'empty') from Student as s
    END
    IF @what = 'full name'
    BEGIN
    insert @t  
        select   (ISNULL(s.St_Fname ,'') +' '+ ISNULL(s.St_Lname ,'')) AS ["Name"]  from Student as s
    END
    RETURN
END
go
select * from tellMEThier('first name')
select * from tellMEThier('last name')
select * from tellMEThier('full name')


-- 7.  Write a query that returns the Student No and Student first name 
-- without the last char 
SELECT  s.St_Id , SUBSTRING(s.St_Fname , 1, LEN(s.St_Fname)-1) as name from Student as s 

-- 8. Wirte query to delete all grades for the students Located in SD 
-- Department  
create   table  temp ([Crs_Id] [int] ,
	[St_Id] [int] 
,	[Grade] [int] )

insert into temp select * from Stud_Course where St_Id in (
select s.St_Id from Student as s inner join Department as d 
on s.Dept_Id= d.Dept_Id 
where d.Dept_Name = 'SD')

select * from temp as t order by t.St_Id
go
delete from Stud_Course where St_Id in (
select s.St_Id from Student as s inner join Department as d 
on s.Dept_Id= d.Dept_Id 
where d.Dept_Name = 'SD')
 
