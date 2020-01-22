use ITI
GO
/*
Create a view that displays student 
full name, course name if the student has a grade more than 50. 
*/
GO
Create view SelectStudentInfos
as 
Select CONCAT(St_Fname,' ',st.St_Lname) as FullName
,cou.Crs_Name as [CourseName] , Grade  from Student as st
inner join Stud_Course as cours
on st.St_Id = cours.St_Id
inner join Course as cou
on cou.Crs_Id = cours.Crs_Id
where Grade >50
GO
Select * from SelectStudentInfos
GO 
/*
Create an Encrypted view that displays manager names 
and the topics they teach. 
*/
Create view DisplayEncryption 
With ENCRYPTION 
as
Select Ins_Name as ManagerNames ,Crs_Name as CourseName  from Department inner join Instructor AS inst
on Department.Dept_Manager = inst.Ins_Id 
inner join Ins_Course as incsCourse
on  incsCourse.Ins_Id = inst.Ins_Id
inner join Course as cours
on cours.Crs_Id = incsCourse.Crs_Id
Go
/*
3.	Create a view that will display Instructor Name,
 Department Name for the ‘SD’ or ‘Java’ Department “use Schema binding” and describe what is the meaning of Schema Binding
*/
Create View vw_V1
with Schemabinding -- indexed view 
as
Select Ins_Name, Dept_Desc from Instructor as instruct
inner join Department as dept
on instruct.Dept_Id = dept.Dept_Id
go 
/*
4.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
Note: Prevent the users to run the following query 
Update V1 set st_address=’tanta’
Where st_address=’alex’;

*/
GO
Create view ShowStudent
as
select * from Student where St_Address ='Alex'
with check option

Select * from ShowStudent
Update ShowStudent set St_Fname='nn' WHERE st_address='tanta'
GO
/*
5.	Create index on column (Hiredate) that allow u to cluster the data
 in table Department. What will happen?
*/
Create NONCLUSTERED index index_Hiredate 
on Department(Manager_hiredate)  
GO
/*
6.Create index that allow u to enter unique 
ages in student table. What will happen?
*/
Create unique index Age_Student
on Student(St_Age)
GO
use [SD32-Company]
GO
/*
7.	Create temporary table [Session based] on Company DB to 
save employee name and his today task.
*/ 
Create table  #Employees_Task
(
ID int ,
TODayTask nvarchar(max)
)
Select * from #Employees_Task
/*
8.	Create a view that will display the project name and the number of 
employees work on it. “Use Company DB”
*/
GO
Create view vw_SelectProjectNumber
as
Select  ProjectName,count(*) as ANumberOfEmployees from Company.Project as prod
Inner join Works_On as work
on prod.ProjectNo = work.ProjectNo
group by ProjectName
GO
Select * from vw_SelectProjectNumber
Go
/*
9.	Using Merge statement between the following two 
tables [User ID, Transaction Amount]
*/
--Create 2 tables
Create table DailyTransaction(
UserID int ,
TransactionAmount decimal(9,2)
)
go 
Create table LastTransaction(
UserID int ,
TransactionAmount decimal(9,2)
)
Go
Insert into DailyTransaction values (1, 1000),(2,2000),(3,1000)
Insert into LastTransaction values (1, 4000), (4,2000), (2,10000)
Go
/*
MERGE <target_table> [AS TARGET]
USING <table_source> [AS SOURCE]
ON <search_condition>
[WHEN MATCHED 
   THEN <merge_matched> ]
[WHEN NOT MATCHED [BY TARGET]
   THEN <merge_not_matched> ]
[WHEN NOT MATCHED BY SOURCE
   THEN <merge_matched> ];
*/ 
Merge  LastTransaction as Target 
using  DailyTransaction as Source 
on target.UserID = source.UserID and target.TransactionAmount = source.TransactionAmount
when not matched 
then Insert  values(UserID,TransactionAmount);
GO
Select * from DailyTransaction
GO
Select * from [Human Resource].Employees
GO
/*
10.	Write a query to select the highest two salaries in Each Department for instructors who have salaries.
 “using one of Ranking Functions”
*/
Select * from 
(
Select  *,ROW_NUMBER() over (Order by Salary desc) AS Rank from [Human Resource].Employees 
)as NewTbl
where Rank <=2
/*
Write a query to select a random  student from each department. 
 “using one of Ranking Functions”
*/

Select top(1) *, ROW_NUMBER()over(Order by newID()) from [Human Resource].Employees 

/*Part2:use CompanySD23 DB*/
Go
Create view v_clerk 
as
Select work.ProjectNo, emp.EmpNo, work.Enter_Date as HireDate , work.Job from [Human Resource].Employees as emp
inner join Works_On as work 
on emp.EmpNo = work.EmpNo
where work.Job = 'Clerk'
with check option
select * from v_clerk

/*
2)	 Create view named  “v_without_budget” 
that will display all the projects data 
without budget
*/
Go
Create view v_without_budget
as
select ProjectNo,ProjectName from Company.Project
go 
Select * from v_without_budget
/*
3)	Create view named  “v_count “ that will display 
the project name and the # of jobs in it
*/
Go
Create view v_count 
as 
Select ProjectName, count(work.Job) as ANumberOfEmployees from Company.Project as pro
inner join Works_On as work 
on pro.ProjectNo = work.ProjectNo
group by ProjectName
Go
--4
/*
5)	modifey the view named  “v_without_budget”
to display all DATA in project p1 and p2 
*/

Alter view v_without_budget
as 
Select * from Company.Project
Go
/*
6)	Delete the views  “v_ clerk” and “v_count”
*/
drop view v_clerk 
drop view v_count 


/*
v_without_budget”  
*/



