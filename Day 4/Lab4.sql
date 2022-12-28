--1.Display (Using Union Function)
--a.The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--b.And the male dependence that depends on Male Employee.
select d.DependantName , d.Sex 
from Employee e ,Dependant d 
where e.Sex ='f' and d.Sex = 'f'
union 
select d.DependantName , d.Sex 
from Employee e ,Dependant d 
where e.Sex ='m' and d.Sex = 'm'


--2.For each project, list the project name and the total hours per week ----------
-- (for all employees) spent on that project.----sum of hours
select PName ,  w.Hours  from  
Employee e join Works_On w on e.SSN = w.ESSN
join Project p on p.PNumber=w.PNO

--3.Display the data of the department which has the smallest employee ID 
--over all employees' ID.-- with 1 sub query
select * from Department d where d.DNum in 
(select e.DNO from Employee e 
where e.SSN = (select MIN(SSN) from Employee) )


--4.For each department, retrieve the department name and 
--the maximum, minimum and average salary of its employees.
select  
MIN(Salary) as Min_val
,Max(Salary)as Max_val ,
AVG(Salary) as Avg_val ,
d.DName
from Employee e JOIN Department d ON d.DNum=e.DNO
group by d.DName


--5.List the full name of all managers who have no dependents.
select e.FName+e.LName as FullName 
from Employee e, Department d where e.SSN =d.MSSN 
and e.SSN not in (select ESSN from Dependant)

--6.For each department-- if its average salary is less than the average 
--salary of all employees-- display its number, name and number of its employees.
select 
COUNT(e.Salary)as empCount,
AVG(e.salary) as avgSalary,
d.DNum,d.DName
from Department d,Employee e
where e.DNO =d.DNum
group by d.DNum , d.DName
having AVG(e.Salary)<(select AVG(Salary)from Employee)

--7.Retrieve a list of employees names and the projects names they are working
--on ordered by department number and within each department, 
--ordered alphabetically by last name, first name.
select p.PName ,e.FName+e.LName as full_name 
from Employee e , Project p,Department d 
where  d.DNum=p.DNum and e.DNO=d.DNum
order by d.DNum asc , e.LName asc,e.FName asc

--8.Try to get the max 2 salaries using subquery
select Salary  from Employee where SSN in 
(select SSN from Employee where Salary = MAX(salary)
union
select SSN from Employee
where Salary = ( 
select MAX(Salary) from Employee 
where Salary not in (select MAX(salary) from Employee )
)
)


--9.Get the full name of employees that is similar to any dependent name
select (e.FName+e.LName) as FullName  from Employee e, Dependant d 
where (e.FName+e.LName) = d.DependantName

--10.Display the employee number and name if at least one of them have dependents
--(use exists keyword) self-study.
select SSN, FName from Employee 
where EXISTS (select * from Employee e , Dependant d 
where e.SSN = d.ESSN)

--11.In the department table insert new department called "DEPT IT" , 
--with id 100, employee with SSN = 112233 as a manager for this department. 
--The start date for this manager is '1-11-2006'
insert into Department (DName,DNum,MSSN,M_S_Date)
values ('DEPT IT',100,112233,1-11-2006)

--12.Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  
--moved to be the manager of the new department (id = 100), and 
--they give you(your SSN =102672) her position (Dept. 20 manager) 
--a.First try to update her record in the department table
update Department set 
MSSN = 968574
where DNum = 100

--b.Update your record to be department 20 manager.
update Department set 
MSSN = 102672
where DNum = 20

--c.Update the data of employee number=102660 
--to be in your teamwork (he will be supervised by you) (your SSN =102672)
update Employee set 
SuperSSN = 102672
where SSN = 102660

--13.Unfortunately the company ended the contract with Mr. Kamel Mohamed 
--(SSN=223344) so try to delete his data from your database in case you know 
--that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, 
--supervises any employees or works in any projects and handle these cases).
update Employee set SuperSSN = 102672 where SuperSSN = 223344
update Works_On set ESSN = 102672 where ESSN = 223344
update Department set MSSN = 102672 where MSSN = 223344
delete Dependant where ESSN = 223344 
delete Employee where SSN = 223344
--14.Try to update all salaries of employees who work in Project 
--‘Al Rabwah’ by 30%
update Employee 
set Salary *=1.3
where SSN in 
(select SSN from Works_On w, Employee e, Project p 
where p.PNumber=w.PNO and p.PName ='Al Rabwah'
and e.SSN =w.ESSN )