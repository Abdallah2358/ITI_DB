--1.Display the Department id, name and id and the name of its manager.
select DName,DNum , e.FName+e.LName as MangerName from Department d, Employee e
where d.MSSN = e.SSN

--2.Display the name of the departments and the name of the projects under 
--its control.
select Pname, DName from Project p , Department d
where p.DNum = d.DNum

--3.Display the full data about all the dependence associated 
--with the name of the employee they depend on him/her.
Select * from Dependant d , Employee e where e.SSN =d.ESSN

--4.Display the Id, name and location of the projects in Cairo or Alex city.
select PNumber,PName,PLocation from Project 
where PLocation ='Cairo' or PLocation ='Alex'

--5.Display the Projects full data of the projects with a name starts with "a" letter.
select * from Project 
where PName like 'a%'

--6.display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select * from Employee e left join Department d 
on e.DNO = d.DName
where d.DNum = 30 
and e.Salary >= 1000 
and e.Salary <=2000

--7.Retrieve the names of all employees in department 10 who works 
--more than or equal to 10 hours 
--per week on "AL Rabwah" project.
select e.FName+e.LName as EmpName  from 
Employee e join Works_On w on w.ESSN= e.SSN
join Project p on p.PNumber=w.PNO
where p.DNum = 10 
and p.PLocation = 'AL Rabwah'
and w.Hours = 10

--8.Find the names of the employees who directly supervised with Kamel Mohamed.
select * from Employee e join Employee e1
on e.SSN =e.SuperSSN
where e.FName = 'Kamel'
and e.LName = 'Mohamed'

--9.Retrieve the names of all employees and the names of the projects
--they are working on,
--sorted by the project name.
select e.FName+e.LName as EmpName , p.PName from Employee e join Works_On w on e.SSN = w.ESSN
join Project p on p.PNumber =w.PNO
order by p.PName

--10.For each project located in Cairo City , find the project number, 
--the controlling department name ,the department manager last name 
--,address and birthdate.
select p.PName,d.DName,e.LName,e.Address,e.BDate 
from Project p join Department d on d.DNum=p.DNum
join Employee e on e.SSN=d.MSSN
where p.PLocation = 'Cairo'

--11.Display All Data of the managers ?? which mangers depart manger or
--empp super visors
select * from Employee e join Department d on e.SSN = d.MSSN

--12.Display All Employees data and the data of their dependents even
--if they have no dependents
select * from Employee e left join Dependant d on e.SSN =d.ESSN

--13.Insert your personal data to the employee table as a new employee 
--in department number 30,
--SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee (DNO,SSN	 ,SuperSSN	,Salary)
			values   (30 ,102672 ,1112233	,3000 ) 

--14.Insert another employee with personal data your friend as new employee in 
--department number 30, SSN = 102660, 
--but don’t enter any value for salary or supervisor number to him.

insert into Employee (DNO,SSN	)
			values   (30 ,102660) 


--15.Upgrade your salary by 20 % of its last value.
update Employee set 
Salary *=1.2
where SSN =1