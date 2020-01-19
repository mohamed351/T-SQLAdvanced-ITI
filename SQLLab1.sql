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










