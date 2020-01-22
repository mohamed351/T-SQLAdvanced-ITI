use ITI
GO
/*
Create a view that displays student 
full name, course name if the student has a grade more than 50. 
*/
Create view SelectStudentInfos
as 
Select CONCAT(St_Fname,' ',st.St_Lname) as FullName
,cou.Crs_Name as [CourseName] , Grade  from Student as st
inner join Stud_Course as cours
on st.St_Id = cours.St_Id
inner join Course as cou
on cou.Crs_Id = cours.Crs_Id
where Grade >50

Select * from SelectStudentInfos
