use ITI
GO
/*Create a scalar function that takes date and returns Month name of that date.*/
Create function GetCustomDate(@date datetime)
returns nvarchar(20)
begin 
 return DATENAME(month, @date)
end
go 
/*Create a multi-statements table-valued function that takes 2 integers and returns the values between them.*/
Create function GetTheValues(@number1 int , @number2 int)
returns @x table (
Numbers int 
)
begin 
   declare @temp as int =@number1;
	while @temp<=@number2
	begin
		Insert into @x values (@temp);
		set @temp = @temp+1;
	end
	return
end 
/*
Create a tabled valued function that takes Student
 No and returns Department Name with Student full name.
*/
GO
Create function ReturnTable(@StudentNo int)
returns table  
return (Select dept.Dept_Name, CONCAT(st.St_Fname,st.St_Lname) as fullName from Student as st inner join Department as dept
on st.Dept_Id = dept.Dept_Id
where st.St_Id =@StudentNo
) 

/*
 4- Create a scalar function that takes Student ID and returns a message to user
*/
Go
Create function returnTheNull(@studentID int)
returns nvarchar(100)
begin 
declare @FName nvarchar(50);
declare @LName nvarchar(50);
Select @FName = St_Fname, @LName= St_Lname  from Student
where St_Id = @studentID
 if @FName is  NULL and @LName is NULL
	 return 'The Value of First Name is Null and LastName is NUll'
 else if @FName is NULL
	return 'The value of Fname is NULL'
 else if @LName is NULL
	return 'The value of LName is NULL'
 else
	return 'The values are not null  Fname : '+@Fname+ 'Lname' +@Lname

	return ''
end 
Go

--5
-- I didn't underStand it 
go 
Create function DisplayIt(@format int)
returns @xtable table (hireDate date, departmentName nvarchar(50), ManagerName nvarchar(50))
begin
insert into @xtable select 
 CONVERT(date,dept.Manager_hiredate,@format) as HireDate, dept.Dept_Name, Ins_Name  
from Department as dept inner join Instructor as ins
on dept.Dept_Manager = ins.Ins_Id
return
end 

--6 
go
Create function ReturnStudentName(@StudentName nvarchar(50))
returns @x table (
[Name] nvarchar(50)
)
begin 
	if @StudentName = 'firstname'
	  insert @x select ISNULL(St_Fname,'')  from Student
	else if @StudentName = 'lastname'
	  insert @x select ISNULL(St_Lname ,'') from Student
	 else if @StudentName = 'fullname'
		insert @x select CONCAT(St_Fname,' ',St_Lname) from Student

	return
end



go

/*
Write a query that returns the Student No and Student first name without the last char
*/
go
Create function ReturnStudentSubString()
returns table
	 return Select St_Id ,Substring(St_Fname,0,len(St_Fname))  as SubStringName from Student;
 go


/*
Write a query that takes the columns list and table name 
into variables and then return the result of this query “Use exec command”
*/

 declare @x nvarchar(100) = 'select * from Student'
 execute(@x);

------------------------------------------------------
--Part2


Create database TestingITILab
go
Use TestingITILab
go
Create table Instructor 
(
ID int primary key identity(1,1),
HireDate as GetDate(), 
[Address] nvarchar(max),
FirstName nvarchar(50),
LasName nvarchar(50),
DateOfBirth date,
OverTime decimal(9,2) unique  , 
Salary decimal(9,2)  check (Salary >=1000 and Salary <= 5000) default 1000,
NetSalary as OverTime+ Salary, --computed
Age  as DATEDIFF(year,DateOfBirth,GetDate())
)
GO
Create table Courses
(
CID int primary key identity(1,1),
CName nvarchar(50),
Duration datetime unique ,
)
GO
Create table Insructor_Course
(
InsId int ,
CID int,

constraint pk_compo primary key(InsId,CID ),
constraint fk_insructor foreign key (InsId) references Instructor(ID) on update cascade on delete cascade,
constraint fk_Cid foreign key (CID) references Courses(CID) on update cascade on delete cascade
)

GO
 
 Create table Labs
 (
 ID int,
 [Location] nvarchar(max),
 Capacity int check (Capacity<=20),
 CourseID int ,
 constraint pk_Week primary key(ID, CourseID)  ,
 constraint fk_Course_ID foreign key (CourseID) references Courses(CID) on delete cascade  on  update cascade
 )












