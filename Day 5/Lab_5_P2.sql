--Part-2: Use AdventureWorks DB
--1.Display the SalesOrderID, ShipDate of the SalesOrderHeader table 
--(Sales schema) to show SalesOrders that occurred within the period 
--‘7/28/2002’ and ‘7/29/2014’
select SalesOrderID, ShipDate from Sales.SalesOrderHeader 
where ShipDate between '7/28/2002' and '7/29/2014'

--2.Display only Products(Production schema) with a StandardCost below $110.00 
--(show ProductID, Name only)
select p.ProductID , p.Name from Production.Product p 
where p.StandardCost < 100

--3.Display ProductID, Name if its weight is unknown
select p.ProductID , p.Name from Production.Product p 
where p.Weight is null

--4. Display all Products with a Silver, Black, or Red Color
select p.ProductID , p.Name , p.Color from Production.Product p 
where p.Color IN ('Red','Silver','Black')


--5. Display any Product with a Name starting with the letter B

--6.Run the following Query
--UPDATE Production.ProductDescription
--SET Description = 'Chromoly steel_High of defects'
--WHERE ProductDescriptionID = 3
--Then write a query that displays any Product description with underscore 
--	value in its description.
update Production.ProductDescription 
set Description = 'Chromoly steel_High of defects'
where ProductDescriptionID = 3

select * from Production.ProductDescription where Description like '%[_]%'

--7.Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader
--table for the period between  '7/1/2001' and '7/31/2014'
select SUM(TotalDue) from Sales.SalesOrderHeader 
where OrderDate between  '7/1/2001' and '7/31/2014'

--8. Display the Employees HireDate (note no repeated values are allowed)
select distinct  HireDate from HumanResources.Employee  

--9. Calculate the average of the unique ListPrices in the Product table
select AVG(ListPrice) from 
(select distinct ListPrice from Production.Product ) as pp

--10.Display the Product Name and its ListPrice within the values of 100 and 120 
--the list should has the following format "The [product name] is only!
--[List price]" (the list will be sorted according to its ListPrice value)
select pp.Name as 'Product name', pp.ListPrice as 'List price' 
from Production.Product pp 
where pp.ListPrice between 100 and 120
order by pp.ListPrice


--11.
--a) Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store 
--table  in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?
create table store_Archive 
(rowguid int 
, Name nvarchar(50)
,SalesPersonID int 
,Demographics xml(CONTENT Sales.StoreSurveySchemaCollection)
);
insert into store_Archive 
(rowguid ,Name, SalesPersonID, Demographics )
select BusinessEntityID ,Name, SalesPersonID, Demographics  
from  Sales.Store

--b)Try the previous query but without transferring the data? 


--12.Using union statement, retrieve the today’s date in different styles 
--using convert or format funtion.
select GETDATE()
union all
select  CONVERT(varchar,  GETDATE(), 102)
union  all
select  CONVERT(NVARCHAR,  GETDATE(), 111)
union  all
select  CONVERT(NVARCHAR,  GETDATE(), 104)
union  all
select  CONVERT(NVARCHAR,  GETDATE(), 101)
union all
SELECT FORMAT(GETDATE(), 'yy-MM-dd' ) 
