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



