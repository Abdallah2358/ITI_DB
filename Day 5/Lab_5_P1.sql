--1.Retrieve number of students who have a value in their age. 
select count(St_Id) from Student where St_Age is not null 

--2.Get all instructors Names without repetition
select distinct i.Ins_Name from Instructor i 

--3.Display student with the following Format (use isNull function)
--Student ID	Student Full Name	Department name
select
St_Id as 'Student ID',
St_Fname+St_Lname as 'Student Full Name'
,ISNULL( Dept_Id , -1)as 'Student ID' 
from Student 

--4.Display instructor Name and Department Name 
--Note: display all the instructors if they are attached to a department or not
select i.Ins_Name , d.Dept_Name 
from Instructor i  left join Department d on i.Dept_Id= d.Dept_Id

--5.Display student full name and the name of the course he is taking
--For only courses which have a grade  
select 
St_Fname+St_Lname as 'Student Full Name'
,c.Crs_Name
from Student s, Course c, Stud_Course sc
where s.St_Id=sc.St_Id and c.Crs_Id = sc.Crs_Id and sc.Grade is not null

--6.Display number of courses for each topic name
select count(c.Crs_Name) ,t.Top_Name from Course c ,Topic T
where c.Top_Id =t.Top_Id
group by t.Top_Name

--7.Display max and min salary for instructors
select max(Salary) as MaxSal , min(Salary) as MinSal from Instructor

--8.Display instructors who have salaries less than the average salary of 
--all instructors.
select Salary from Instructor where Salary < AVG(Salary)

--9.Display the Department name that contains the instructor who receives 
--the minimum salary.
select d.Dept_Name 
from Department d, Instructor i 
where d.Dept_Id=i.Dept_Id 
and i.Salary = (select min(Salary) from Instructor)

--10.Select max two salaries in instructor table. 
select top(2) salary from Instructor order by salary desc

--11.Select instructor name and his salary but if there is no salary 
--display instructor bonus keyword. “use coalesce Function”
select i.Ins_Name ,
COALESCE(cast( i.Salary as varchar),'bonus')
from Instructor i 

--12.Select Average Salary for instructors 
select AVG(SAlary) from Instructor

--13.Select Student first name and the data of his supervisor 
select i.Ins_Name as superName , s.St_Fname as studentFname
from Instructor i, Student s
where s.St_super = i.Ins_Id

--14.Write a query to select the highest two salaries in Each Department for 
--instructors who have salaries. “using one of Ranking Functions”
select * from 
(select  i.Salary , d.Dept_Name,
Rank() Over (PARTITION BY d.Dept_Name order by i.Salary desc ) as ran 
from Instructor i ,Department d where d.Dept_Id =i.Dept_Id ) as subQ
where subQ.ran<=2


--15.Write a query to select a random  student from each department. 
--“using one of Ranking Functions”
select 