--teeme andmebaasi e db
--create database IKT25tar

-- andmebaasi valimine
--use IKT25tar
use master
--andmekastutamine koodiga
--otsida kood ülesse
--drop database IKT25tar

--teeme uuesti andmebaasi IKT25tar
--create database IKT25tar
use IKT25tar
--teeme tabeli
create table Test
(
-- meil on muutuja Id,
-- mis on täisarv andmetüüp,
--kui sisestad andmed, 
--siis see verg peab olema täidetud,
--tegemist on primaarvõtmega
Id int not null primary key,
--veeru nimi on gender,
--10 tähemärki on max pikkus,
--andmend peavad olema sisestatud e
-- ei tohi olla tühi
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Test
(id, Gender)
values
(1, 'male'),
(2, 'female');

--vaatame tabeli sisu
-- * näitab kõike seal sees olevat infot
select * from Test

--teeme tabeli nimega persons
create table person
(
Id int not null primary key,
name nvarchar(30),
email nvarchar(30),
GenderId int,
)

insert into Person(Id, Name, Email, GenderId)
values
(1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'aquaman', 'a@a.com', 2),
(5, 'catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 2),
(8, null, null, 2)

select * from Person

alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Test(Id)

alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Test(Id, Gender)
values(3, 'Unknown')

Insert into Person (Id, Name, Email, GenderId)
values (7, 'Black panther', 'b@b', null)

Insert into Person (Id, Name, Email, GenderId)
values (9, 'spiderman', 'spider@man.com', 2)

select * from Person

alter table Person
drop constraint DF_Persons_GenderId

alter table person
add Age nvarchar(10)

alter table person
add constraint CK_Person_Age check (age >0 and Age < 155)

update person
set Age = 151
where id = 7

select * from person

delete from person where Id = 8

alter table person
add City nvarchar(50)

--kõik kes elavad gothamis
select * from person where city = 'Gotham'

select * from person where city != 'Gotham'

select * from person where city <> 'Gotham'

select * from person where Age in (151, 35, 26)

select * from person where Age between 22 and 41

select * from person where city like 'g%'

select * from person where email like '%@%'

select * from person where email like '_@_.com'

select * from person where name not like '[^was]%'

select * from person where city in ('Gotham', 'New York')

select * from person where (city in ('gotham', 'New York') and age >= 29)

select * from person order by name

select top 3* from person 

--näita esimesed 50% tabelist
select top 50 percent * from Person
select * from Person

--järjestab vanuse järgi isikud
select * from Person order by Age desc

--muudab Age muutuja int-ks ja näitab vanuselises järjestuses
-- cast abil saab andmetüüpi muuta
select * from Person order by cast(Age as int) desc

-- kõikide isikute koondvanus e liidab kõik kokku
select sum(cast(Age as int)) from Person

--kõige noorem isik tuleb üles leida
select min(cast(Age as int)) from Person

--kõige vanem isik
select max(cast(Age as int)) from Person

--muudame Age muutuja int peale
-- näeme konkreetsetes linnades olevate isikute koondvanust
select City, sum(Age) as TotalAge from Person group by City

--kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person 
alter column Name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age-i 
-- TotalAge-ks
--järjestab City-s olevate nimede järgi ja siis Genderid järgi
--kasutada group by-d ja order by-d
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

--näitab, et mitu rida andmeid on selles tabelis
select count(*) from Person

--näitab tulemust, et mitu inimest on Genderid väärtusega 2
--konkreetses linnas
--arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total Person(s)] from Person
where GenderId = '1'
group by GenderId, City

--näitab ära inimeste koondvanuse, mis on üle 41 a ja
--kui palju neid igas linnas elab
--eristab inimese soo ära
select GenderId, City, sum(Age) as TotalAge, count(Id) as 
[Total Person(s)] from Person
where GenderId = '2'
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja Department
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department(Id, DepartmentName, Location, DepartmentHead)
values 
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

---
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
---

--arvutab k]ikide palgad kokku Employees tabelist
select sum(cast(Salary as int)) from Employees --arvutab kõikide palgad kokku
-- kõige väiksema palga saaja
select min(cast(Salary as int)) from Employees

--näitab veerge Location ja Palka. Palga veerg kuvatakse TotalSalary-ks
--teha left join Department tabeliga
--grupitab Locationiga
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

select * from Employees
select sum(cast(Salary as int)) from Employees

alter table Employees
add City nvarChar(30)

select City, Gender, sum(cast(salary as int)) as TotalSalary
from Employees
group by City, Gender

select City, Gender, sum(cast(salary as int)) as TotalSalary
from Employees
group by City, Gender
order by City

select count(*) from Employees

select City, Gender, sum(cast(salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

select City, Gender, sum(cast(salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

select City, Gender, sum(cast(salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

select * from Employees where sum(cast(Salary as int)) > 4000

select City, Gender, sum(cast(salary as int)) as TotalSalary,
count (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having sum(cast(Salary as int)) > 4000

create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('x')
select * from test1


