use [SD32-Company]
GO

Create default def as  'NY'
GO
Create rule locationRule  as @x In('NY','DS','KW');
GO

sp_addtype locationType , 'nchar(2)','not null'

Go
 EXECUTE sp_bindrule 'locationRule','locationType'
execute sp_bindefault 'def','locationType'
GO
Create table Department 
(
DeptNo nchar(2) primary key,
DeptName nvarchar(50),
[Location] locationType
)


go
Create rule EmployeeSalary as @x <6000 
execute sp_addtype EmployeeSalaryType,int
go
Create table Employees
(
EmpNo int  primary key ,
DepatNo nchar(2),
Salary EmployeeSalaryType Unique,

constraint fk_employees_department foreign key (DepatNo) references Department(DeptNo)
)
go 
Alter table Employees
add TelephoneNumber  nchar(15)
go
Alter table Employees
drop column TelephoneNumber
go 
create schema Company 
go 
create schema [Human Resource]
go 
Alter schema [Human Resource]
transfer  Employees
go
Alter schema Company
transfer  Department
go
Alter schema Company
transfer  Project
Select * from Employees
Select * from [Human Resource].Employees

/*p1	Apollo	120000*/
/*10102	Ann	Jones	d3	3000*/
Insert into Company.Department values('d3','Markiting','KW')
go
Alter table [Human Resource].Employees
add  EmpFname nvarchar(50) unique
go
Alter table [Human Resource].Employees
add  EmpLname nvarchar(50) unique

go
Insert into  [Human Resource].Employees (EmpNo,EmpFname,EmpLname,DepatNo) values (10102,'Ann', 'Jones','d3')
go 
Update Company.Project  set Budget = Budget+(Budget*10/100)  where Budget = ( Select Budget from  [Human Resource].Employees as emp inner join  Works_On as work
on emp.EmpNo = work.EmpNo inner join Company.Project as pro 
on pro.ProjectNo = work.ProjectNo
where emp.EmpNo =1012  )

go

Update Company.Department SET DeptName='Sales' where DeptNo= (Select top(1) DeptNo from [Human Resource].Employees as emp inner join Company.Department as dept on
emp.DepatNo = dept.DeptNo
where emp.EmpFname = 'James')

Select * from Company.Department
/*
There is two more 
7.	Change the enter date for the projects for those employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
8.	Delete the information in the works_on table for all employees who work for the department located in KW.

*/



