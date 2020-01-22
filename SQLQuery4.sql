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
1.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
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
