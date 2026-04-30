create database IKT25tar
use IKT25tar

create table Employees
(
Id int primary key,
FirstName nvarchar(50),
MiddleName nvarchar(30),
LastName nvarchar(30),
Gender nvarchar(50),
salary nvarchar(50),
DepartmentId int,
Email nvarchar(50),
ManagerId int
)

