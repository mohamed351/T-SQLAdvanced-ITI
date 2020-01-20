/*
Lab 1 SQL Advanced

*/

use ITI
GO 
--1-Retrieve number of students who have a value in their age. 
select * from Student where St_Age is not null
go
--2.Get all instructors Names without repetition
select distinct Ins_Name from Instructor
go 
--3.Display student with the following Format (use isNull function)
select St_Id as [Student ID],ISNULL(St_Fname,'')+ISNULL(St_Lname,'') as [Student Full Name] ,dept.Dept_Name as [DepartmentName] from Student as stu
inner join Department as dept
on dept.Dept_Id = stu.Dept_Id
go 
--4.Display instructor Name and Department Name 
Select inst.[Ins_Name] as [Instruct Name], dept.[Dept_Name] as [Deparment Name] 
from Instructor as inst inner join Department as dept
on inst.Dept_Id = dept.Dept_Id
/*
5.	Display student full name and the name of the course he is taking
For only courses which have a grade  
*/
Select Concat(St_Fname,St_Lname) as [Full Name] ,stuCourse.Grade   from Student as student
inner join Stud_Course as stuCourse 
on stuCourse.St_Id = student.St_Id
inner join Course as cou 
on cou.Crs_Id = stuCourse.Crs_Id
/*
6.	Display number of courses for each topic name
*/
select  Course.Crs_Name, SUM( Topic.Top_Id) AS [Topic Number]   from Topic inner join Course
on Topic.Top_Id = Course.Top_Id
GROUP by Course.Crs_Name
/*
7.	Display max and min salary for instructors
*/
select MAX(Salary) as [The Max Salary], MIN(Salary) as [The Min Salary] from Instructor
/*
8.	Display instructors who have salaries less 
than the average salary of all instructors.
*/
Select  * from Instructor
where Salary < (select AVG(ISNULL(Salary,0)) from Instructor)

/*
9.	Display the Department name that contains the 
instructor who receives the minimum salary.
*/
Select top(1) * from Department as dept  inner join Instructor as inst
on dept.Dept_Id = inst.Dept_Id
where Salary is not null	
order by Salary
/*
10.	 Select max two salaries in instructor table. 
*/
select top(2) * from Instructor
where Salary is not null	
order by Salary desc
/*
Select instructor name and his salary but if there is no salary
 display instructor bonus. “use one of coalesce Function”
*/
Select * from	Instructor
/*Alter table Add Bonus*/
/*
Alter table Instructor 
add Bouns decimal(9,2)
*/
/*Update Instructor set Bouns=150 */
Select Ins_Name, coalesce(Salary,Bouns) from Instructor

/*
12.	Select Actual Average Salary for instructors 
*/
select AVG(ISNULL(Salary,0)) from Instructor
/*
13.	Select Student first name and the data of his supervisor 
*/
Select stu.St_Fname as StudentName, sup.* from Student as stu inner join Student as sup
on stu.St_Id = sup.St_Id
/****************************************************/
/*
1.	Display the SalesOrderID, ShipDate of the SalesOrderHearder 
table (Sales schema) to designate SalesOrders 
that occurred within the period ‘7/28/2002’ and ‘7/29/2014’

*/
use AdventureWorks2012
go 
Select ordD.SalesOrderID ,ordH.ShipDate  from Sales.SalesOrderDetail as ordD
inner join  Sales.SalesOrderHeader as ordH
on ordD.SalesOrderID =ordH.SalesOrderID
where ordH.ShipDate Between '7/28/2002' and'7/29/2014'

Select ProductID,Product.[Name]  from Production.Product 
where StandardCost <100

Select ProductID, [Name] from Production.Product where [Weight] is null	

select * from Production.Product
where Color in ('Black','Red','Silver')

select * from Production.Product
where Name like 'B%'

UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3;

select * from  Production.ProductDescription
inner join Production.Product
on Production.ProductDescription.ProductDescriptionID = Product.ProductID
where  Production.ProductDescription.Description like  '%\_%' Escape '\'
go 

Select SUM( TotalDue) from Sales.SalesOrderHeader
where OrderDate  between '7/1/2001'  and '7/31/2014'


--9.Calculate the average of the unique ListPrices in the Product table
Select DISTINCT AVG(ListPrice) from Production.Product

Select Product.[Name], CONCAT('The ',Product.[Name],' is only price ',Product.ListPrice ) from Production.Product
where ListPrice between 100 and 120

go 
Select rowguid, [Name],SalesPersonID into [store_Archive] from Sales.Store
go 


select @@VERSION
select @@SERVERNAME --Global Variable




















