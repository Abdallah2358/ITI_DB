CREATE RULE r1  AS   @state  in ( 'NY','DS','KW');

CREATE DEFAULT d1   as 'NY';


CREATE TYPE loc FROM nvarchar(2);
sp_bindefault  'd1' ,'dbo.loc'
sp_bindrule 'r1' , 'dbo.loc'

CREATE TABLE Department
(
    ['DeptNo'] INT PRIMARY KEY,
    ['DeptName'] VARCHAR(20) ,
    ['Location'] loc
);

CREATE TABLE Employee
(
    EmpNo INT  ,
    EmpFname VARCHAR(20),
    EmpLname VARCHAR(20),
    DeptNo int,
    Salary INT ,
    CONSTRAINT PK PRIMARY KEY(EmpNo),
    CONSTRAINT  FK_DP FOREIGN KEY
    (DeptNo) REFERENCES Department,
    CONSTRAINT U_c UNIQUE(Salary),
    CONSTRAINT NotNull_c CHECK 
    (EmpFname != NULL AND EmpLname <> NULL )
)

CREATE RULE r2  AS   @SAL  <6000;

sp_bindrule 'r2' , 'dbo.Employee.Salary';

CREATE TABLE Project
(
    ProjectNo INT PRIMARY KEY,

)
ALTER TABLE Employee ADD  TelephoneNumber VARCHAR(30);
ALTER TABLE Employee DROP COLUMN TelephoneNumber ;

ALTER SCHEMA Company TRANSFER Department;
ALTER SCHEMA HumanResources TRANSFER Employee;

SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Employee';

CREATE SYNONYM Emp   FOR HumanResources.Employee
;

Select *
from Employee;
Select *
from [HumanResources].Employee;
Select *
from Emp;
Select *
from [HumanResources].Emp;


-- UPDATE SD.Company.Project set budget *=1.10 
-- where ProjectNo = (select budget )

UPDATE Company.Department set ['DeptName'] = 'Sales'
where ['DeptNo']  = 
(Select DeptNo
from Emp
where EmpFname = 'James');

UPDATE Works_on SET enter_date = '12.12.2007'
WHERE ProjectNo = 1 AND empno in 
(SELECT empno
    from Emp as e inner join Company.Department as d
        on e.DeptNo = d.['DeptNo']
    where d.['DeptName'] ='Sales'
)


DELETE FROM works_on
WHERE empno in (SELECT empno
from Emp as e inner join Company.Department as d
    on e.DeptNo = d.['DeptNo']
where d.['Location'] ='KW'
)
