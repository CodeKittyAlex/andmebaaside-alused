--teeme andmebaasi e db
create database IKT25tar

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

alter table Employees
drop column City

select Firstname, Gender, Salary, departmentname
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

select Name, gender, Salary, DepartmentName
from Employees
full outer join Department
on Employees.DepartmentId = Department.Id

select Name, gender, Salary, DepartmentName
from Employees
cross join Department

select Name, gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

select Name, gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

select Name, gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select Product.name as [Product Name], ProductNumber, ListPrice,
ProductModle.Name as [Product Modle Name]
from SalesLt.Product
inner join SalesLt.ProductModle
on PRODUCT.ProductModelId = ProductModle.ProductModelId

--null funktsiooni kasutamine
select isnull ('Ingvar', 'No Manager') as Manager

--null asemel kuvab No Manager
select coalesce(null, 'No Manager') as manager

alter table Employees
add ManagerId int

--neile kellel ei ole ülemust, siis paneb neile No Manager Teksti
select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

sp_rename 'employees.Name', 'Firstname'

update Employees
set MiddleName = 'Nick',
LastName = 'jones'
where id = 1

update Employees
set LastName = 'Anderson'
where id = 2

update Employees
set LastName = 'Smith'
where id = 4

update Employees
set MiddleName = 'todd',
LastName = 'Someone',
FirstName = null
where id = 5

update Employees
set MiddleName = 'Ten',
LastName = 'Sven'
where id = 6

update Employees
set LastName = 'Connor'
where id = 7

update Employees
set MiddleName = 'Balerine'
where id = 8

update Employees
set MiddleName = '007',
LastName = 'Bond'
where id = 9

update Employees
set FirstName = null,
LastName = 'Crowe'
where id = 10

select id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

create table IndianCustomer
(
Id int identity(1,1),
name nvarchar(30),
Email nvarchar(30)
)

create table UKCustomer
(
Id int identity(1,1),
name nvarchar(30),
Email nvarchar(30)
)

insert into IndianCustomer(Name,Email)
values('Raj','R@R.com'),
('Sam','S@S.com')


insert into UKCustomer(Name,Email)
values('Ben','B@B.com'),
('Sam','S@S.com')

--union all ühendab tabelid ja näitab sisu
select Id, Name, Email from IndianCustomer
union all
select Id, Name, Email from UKCustomer

select Id, Name, Email from IndianCustomer
union 
select Id, Name, Email from UKCustomer

select Id, Name, Email from IndianCustomer
union all
select Id, Name, Email from UKCustomer
order by name

create procedure spGetEmployees
as begin
	select FirstName, gender from Employees
end

spGetEmployees

exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesbyGenderAndDepartment
@gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, departmentId from Employees where Gender = @gender
	and departmentId = @DepartmentId
end

spGetEmployeesbyGenderAndDepartment 'male', 1

spGetEmployeesbyGenderAndDepartment @departmentId = 1, @Gender = 'Male'

---saab sp sisu vaadata
sp_helptext spGetEmployeesbyGenderAndDepartment 

--kuidas muuta sp ja panna sinna võti peale

alter proc spGetEmployeesbyGenderAndDepartment
@gender nvarchar(20),
@DepartmentId int
with encryption
as begin
	select FirstName, Gender, departmentId from Employees where Gender = @gender
	and departmentId = @DepartmentId
end

create proc spGetEmployeeCountByGender
@gender nvarchar(20)
@EmployeeCount int output
as begin
	select @EmployeeCount

end

declare @TotalCount int

execute spGetEmployeeCountByGender 'Male', @TotalCount out

if @TotalCount = 0
	print N'TotalCount is null'
else
	print N'total is not null'
	print @TotalCount

	-- deklareerime muutuja @TotalCount, mis on int andmetüüp
declare @TotalCount int
-- käivitame stored procedure spGetEmployeeCountByGender, kus on parameetrid
-- @EmployeeCount = @TotalCount out ja @Gender 
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
--prindib konsooli välja, kui TotalCount on null või mitte null
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info vaatamine
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

-- vaatame, millest sõltub meie valitud sp
sp_depends spGetEmployeeCountByGender
-- näitab, et sp sõltub Employees tabelist, kuna seal on count(Id) 
-- ja Id on Employees tabelis

--vaatame tabelit
sp_depends Employees

--teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelis
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

--annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

-- on vaja teha uus päring, kus kasutame spTotalCount2 sp-d, 
-- et saada tabeli ridade arv

-- tuleb deklareerida muutuja @TotalCount, mis on int andmetüüp
declare @TotalEmployees int
--tuleb execute spTotalCount2, kus on parameeter @TotalEmployees
exec spTotalCount2 @TotalEmployees output
select @TotalEmployees

--mis Id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(20) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end

--annab tulemuse, kus id 1(seda numbrit saab muuta) real on keegi koos nimega
--print tuleb kasutada, et näidata tulemust
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName output
print 'Name of the employee = ' + @FirstName

--- tehke sama, mis eelmine, aga kasutage spGetNameById sp-d
--FirstName l]pus on outdeclare 
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

--output tagastab muudetud read kohe p'ringu tulemsuena
--see on salvestatud protseduuris ja ühe väärtuse tagastamine
--out ei anna mitte midagi, kui seda ei määra execute käsus

--rida 668
--tund 8
--19.03.2026


sp_help spGetNameById

create proc spGetNameById2
@Id int
--kui on begin, siis on ka end kuskil olemas
as begin
	return (select FirstName from Employees where Id = @Id)
end

--tuleb veateade kuna kutsusime välja int-i, aga Tom on nvarchar
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName


--sisseehitatud string funktsioonid
--see konverteerib ASCII tähe väärtuse numbriks
select ASCII('A')

select char(65)

--prindime kogu tähestiku välja
declare @Start int
set @Start = 97
--kasutate while, et näidata kogu tähestik ette
while (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

--eemaldema tühjad kohad sulgudes
select ('               Hello')
select LTRIM('               Hello')

--tühikute eemaldamine veerust, mis on tabelis
select FirstName, MiddleName, LastName from Employees
--eemaldage tühikud FirstName veerust ära
select ltrim(FirstName) as Name, MiddleName, LastName from Employees

--paremalt poolt tühjad stringid lõikab ära
select rtrim('    Hello     ')

--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt lower-ga ja uppper-ga saan muuta m'rkide suurust
--reverse funktsioon pöörab kõik ümber
select Reverse(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName
from Employees

--left, right, substring
--vasakult poolt neli esimest tähte
select left('ABCDEF', 4)
--paremalt poolt kolm tähte
select right('ABCDEF', 3)

--kuvab @-tähemärgi asetust e mitmes on @-märk
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta näitab, et mitmendast alustab ja
--siis mitu nr peale seda kuvada
select SUBSTRING('pam@bbb.com', 5, 2)

-- @ - märgist kuvab kolm tähemärki. Viimase nr saab määrata pikkust
select SUBSTRING('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

--peale @-märki hakkab kuvama tulemust, nr saab kaugust seadistada
select SUBSTRING('pam@bbb.com', charindex('@', 'pam@bbb.com') + 5,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

alter table Employees
add Email nvarchar(20)

select * from Employees

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

--soovime teada saada domeeninimesid emailides
select SUBSTRING (Email, charindex('@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Employees

--alates teisest tähest emailis kuni @ märgini on tärnid
select FirstName, LastName,
	substring(Email, 1, 2) + replicate('*', 5) +
	substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees

--kolm korda näitab stringis olevat väärtust
select replicate('asd', 3)

--tühiku sisestamine
select space(5)

--tühiku sisestamine FirstName ja LastName vahele
select FirstName + space(25) + LastName as FullName
from Employees

---PATINDEX
-- sama, mis charindex, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0
--leian k]ik selle domeeni esindajad ja alates mitmendast märgist algab @

--k]ik .com emailid asendab .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEmail
from Employees

--soovin asendada peale esimest m'rki kolm tähte viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

create table DateTime
(
	c_time time,
	c_date date,
	c_smalldatetime smalldatetime,
	c_datetime datetime,
	c_datetime2 datetime2,
	c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

insert into DateTime
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())

select * from DateTime

update DateTime set c_datetimeoffset = '2026-04-08 14:49:28.1933333 +10:00'
where c_datetimeoffset = '2026-03-19 14:25:09.8900000 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja päring
select SYSDATETIME(), 'SYSDATETIME' --veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --t'pne aeg koos ajalise nihkega
select GETUTCDATE(), 'GETUTCDATE' ---UTC aeg

--saab kontrollida, kas on õige andmetüüp
select isdate('asd') -- tagastab 0 kuna string ei ole date
select isdate(GETDATE()) -- kuidas saada vastuseks 1 isdate puhul?
select isdate('2026-04-08 14:49:28.193333') --tagastab 0 kuna max kolm komakohta võib olla
select isdate('2026-04-08 14:49:28.193') --tagastab 1
select DAY(GETDATE()) --annab tänase päeva nr
select DAY('01/24/2026') --annab stringis oleva kp ja järjestus peab olema õige
select Month(GETDATE()) --annab jooksva kuu nr
select Month('01/24/2026') --annab stringis oleva kuu ja järjestus peab olema õige
select YEAR(GETDATE()) --annab jooksva aasta nr
select YEAR('01/24/2026') --annab stringis oleva aasta ja järjestus peab olema õige

select datename(day, '2026-04-08 14:49:28.193') --annab stringis oleva päeva nr
select datename(weekday, '2026-04-08 14:49:28.193') --annab stringis oleva päeva sõnana
select datename(month, '2026-04-08 14:49:28.193') --annab stringis oleva kuu sõnana

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (5, 'Todd', '1978-11-29 12:59:30.670');

select * from EmployeesWithDates

select name, DateOfBirth, Datename(WEEKDAY, DateOfBirth) as [day],
	month(DateOfBirth) as MonthNumber,
	Datename(month, DateOfBirth) as [MonthName],
	Year(DateOfBirth) as [Year]
from EmployeesWithDates

--kuvab 1 kuna USA nädal algab pühapäevaga
select datepart(weekday, '2026-03-24 12:59:30.670')
--vaatab kuud
select datepart(MONTH, '2026-03-24 12:59:30.670')
--lisab 20 päeva
select dateadd(day, 20, '2026-03-24 12:59:30.670')
--lahutab 20 päeva
select dateadd(day,-20, '2026-03-24 12:59:30.670')
-- kuvab kahe stringis oleva kuudevahelist aega nr-na
select datediff(month, '11/20/2026', '01/20/2026')

select datediff(YEAR, '11/20/2021', '01/20/2026')

create function fnConputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int,@months int, @days int
	select @tempdate = @DOB
	select @years = datediff(YEAR, @tempdate, getdate()) - case when (month(@DOB)) >
	MONTH(getdate()) or (month(@DOB) = month(getdate()) and day(@DOB) > day(getdate()))
	then 1 else 0 end
	select @tempdate = dateadd(year, @years, @tempdate)

	select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate())
	then 1 else 0 end
	select @tempdate = dateadd(MONTH, @months, @tempdate)

	select @days = datediff(day, @tempdate, getdate())

	declare @age nvarchar(50)
		set @age = cast(@years as nvarchar(4)) + 'Years' + cast(@months as nvarchar(2))
		+ 'Months' + cast(@days as nvarchar(2)) + 'days old'
	return @age
end

select id name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

select dbo.fnConputeAge('02/24/2010') as age

select id, name, DateOfBirth,
CONVERT(nvarchar, DateOfBirth, 110) as ConvertedDOB
from EmployeesWithDates

select id, name, name + ' - ' + cast(id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(getdate() as date) --tänane kp
select cast(getdate() as nvarchar)


--matemaatilised func
select ABS(-5) --abs on absoluutväärtusega numberja tulemusena saame ilma miinus märgita 5
select CEILING(4.2)-- celing on func, mis ümardab ülespoole ja tulemuseks saame 5
select CEILING(-4.2) -- seeling ümardab ka miinus numbrid ülespoole mis tähendab, et saame -4
select floor(15.2)
select FLOOR(-15.2)
select POWER(2,4)
select square(9) -- antud juhul 9 ruudus
select sqrt(16)

select rand() -- rand on func mis genereerib juhusliu numbri 0 kuni 1
select floor(rand() * 100) 

declare @count int
set @count = 1
while (@count <= 10)
begin
	select floor(rand() * 100) 
	set @count = @count + 1
end

select round(850.556, 2) 
select round(850.556, 2, 1) 
--round on func, mis ühendab kaks komakohta ja kui kolmas parameeter on 1 siis ümardab üles
select round(850.556, 1) --ümardab ühe komakoha
select round(850.556,1,1) 
select round(850.556, -2) 
select round(850.556, -1) 

create function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int
	set @Age = DATEDIFF(year, @dob, GETDATE())-
	case
		when(MONTH(@DOB) > MONTH(GETDATE())) or
		(MONTH(@DOB) = MONTH(GETDATE()) and DAY(@DOB)<DAY(GETDATE())) 
		then 1 else 0 end
	return @Age
end

exec dbo.CalculateAge '1980-12-30'

select id, name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) >36

--inline table valued func
alter table EmployeesWithDates
add DepartmentId Int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates
set DepartmentId = 1, Gender = 'male'
where Id =  1
update EmployeesWithDates
set DepartmentId = 2, Gender = 'female'
where Id =  2
update EmployeesWithDates
set DepartmentId = 1, Gender = 'male'
where Id =  3
update EmployeesWithDates
set DepartmentId = 3, Gender = 'female'
where Id =  4
update EmployeesWithDates
set DepartmentId = 1, Gender = 'male'
where Id =  5

--scalar function annab mingis vahemikus olevaid andmeid,
--inline tabel values ei kasuta begin ja end funksioone
--scalar annab väärtused ja inline annab tabeli
create function fn_EmployeesbyGender(@Gender nvarchar(10))
returns table
as
return(select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

select * from fn_EmployeesbyGender ('female')

--tahaks ainult pami nime näha

select * from fn_EmployeesbyGender ('female') where name = 'pam'

select * from Department

select name, Gender, DepartmentName
from fn_EmployeesbyGender('male') E
join Department D on D.Id = E.DepartmentId

--multi table statment
--inline funksioon
create function fn_GetEmployees()
returns table as
return(select Id, Name, cast(DateOfBirth as date)
		as DOB
		From EmployeesWithDates)

select * from fn_GetEmployees()

--multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
--funktsiooni nimi on fn_MS_GetEmployees()
--peab esitama meile id, Name, DOB tabelist EmployeesWithDates

create function fn_MS_GetEmployees()
returns @Table table 
(Id int,Name nvarchar(20), DOB date)
as begin
	insert into @Table 
	select e.Id, e.Name, e.DateOfBirth
	from EmployeesWithDates e
	return
end

select * from fn_MS_GetEmployees()

--inline Tabeli funktsioonid on paremini töötamas kuna käitletakse vaatena
--multi puhul on pm tegemist stored proceduringa ja kulutab ressurssi rohkem

update fn_GetEmployees() set Name = 'sam1' where Id = 1
select * from fn_GetEmployees() --saab muuta andmeid

update fn_MS_GetEmployees() set Name = 'sam1' where Id = 1
--ei saa muuta multi state func
--kuna see on nagu stored procedure

--deterministlic vs non-deterministic func
--deterministlic func annavad alati sama tulemuse, kui sisend on sama
select COUNT(*) from EmployeesWithDates
select SQUARE(4)

--non-deterministlic func annavad erineva tulemuse, kui sisend on sama
select getDate()
select CURRENT_TIMESTAMP
select rand()

--1
create function fn_GetAllCustomers_ITVF()
returns table as
return (select * from SalesLT.Customer) 

select * from fn_GetAllCustomers_ITVF()

--2
create function fn_GetCustomerById_itvf(@CustomerID int)
returns table as
return(select FirstName, LastName
		from SalesLT.Customer
		where CustomerID = @CustomerID)

select * from fn_GetCustomerById_itvf(4)

--3
create function fn_GetOrdersById_itvf(@CustomerID int)
returns table as
return(select SalesOrderID
		from SalesLT.SalesOrderHeader
		where CustomerID = @CustomerID)

select * from fn_GetOrdersById_itvf(30072)
--4
create function fn_GetProductsByPrice_ITVF()
returns table as
return(select min(ListPrice), Max(ListPrice) 
		from SalesLT.Product)

--10
create function fn_GetTopCustomersBySpending_MSTVF()
returns @results table
(
	CustomerID int,
	fullname nvarchar(200),
	TotalSpent MONEY
)
as begin
	insert
c.CustomerID,

create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(20))

insert into ##TestTempTable values(101, 'Mart', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable

--trigerid

--DML trigger
--kokku on kolme tüüpi DML,DDL ja LOGON

--trigger on stored proceadure eriliik, mis automaatselt käivitub,
--kui mingi tegevus peaks andmebaasis aset leidma

--DML - data manipulatsion language
--DML-i põhilised käsutlused: insert, update ja delete

--DML triggereid saab klassifitseerida kahte tüüpi:
--1.
--2.

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale iga töötaja sisestamist tahame eada saada töötaja Id-d
--päeva ning aega(millal sisestati)
--kõik andmed tulevad EmployeeAudit tabelisse
--andmed sisestame Employees tabelisse

create trigger trEmployeeForInsert
on Employees
for insert
as begin
declare @Id int 
select @id = Id from inserted
insert into EmployeeAudit
values ('New employee with Id = '+ cast(@Id as nvarchar(5)) + ' is added at ' + cast(getdate() as nvarchar(20)))
end

select * from Employees

insert into Employees values
(12, 'Bob', 'blob', 'Bomb', 'Male',3000,1,3,'bob@bob.com')
go
select * from EmployeeAudit


--delete trigger
create trigger trEmployeeForDelete
on employees
for delete
as begin
	declare @Id int
	select @Id = Id from deleted

	insert into EmployeeAudit
	values('An Existing employee with Id = ' + cast(@Id as nvarchar(5)) + ' is deleted at ' + cast(getdate()as nvarchar(20)))
end

delete from Employees where Id = 12
select * from EmployeeAudit

-- update trigger
create trigger trEmployeesForUpdate
on Employees
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldManagerId int, @NewManagerId int
	declare @OldFirstName nvarchar(20) , @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20) , @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20) , @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)

	--muutuja kuhu läheb lõpptekst
	declare @AuditString nvarchar(1000)

	--leb kõik uuendatud andmed temp tabeli alla
	select * into #Tempable
	from inserted

	--käib läbi kõik andmed temp tebelist
	while(exists(select Id From #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimene rea andmed temp tabel-st
		select top 1 @Id = Id, @NewGender = Gender, @NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName, @NewMiddleName = MiddleName,
		@NewLastName = LastName, @NewEmail = Email
		from #TempTable
		-- võtab vanad andmed kustudab tabelist
		select @OldGender = Gender, @OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName, @OldMiddleName = MiddleName,
		@OldLastName = LastName, @OldEmail = Email 
		from deleted where Id = @Id

		--hakkab võrdlema igat muutujat, et kas toimus andmete muutus
		set @AuditString = 'Employee with Id ' + cast(@ID as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + ' to ' +
			@NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20)) + ' to ' +
			cast(@NewSalary as nvarchar(20))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) + ' to ' +
			cast(@NewDepartmentId as nvarchar(20))

		if(@OldManagerId <> @NewManagerId)
			set @AuditString = @AuditString + ' ManagerId from ' + cast(@OldManagerId as nvarchar(20)) + ' to ' +
			cast(@NewManagerId as nvarchar(20))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' FirstName from ' + @OldFirstName + ' to ' +
			@NewFirstName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' LastName from ' + @OldLastName + ' to ' +
			@NewLastName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' MiddleName from ' + @OldMiddleName + ' to ' +
			@NewMiddleName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + ' to ' +
			@NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--kustudab temp tabelist rea
		delete from #TempTable where Id = @Id
	end
end
-- triggeri lõpp

update Employees set FirstName = 'test123', Salary = 4000, MiddleName = 'test456'
where Id = 10

select * from Employees
select * from EmployeeAudit

create table Employee
(
Id int primary key,
Name nvarchar(30),
Gender nvarchar(10),
DepartmentId int
)

create table Department
(
id int primary key,
DepartmentName nvarchar(20)
)

select * from Employee

insert into Employee values(1, 'John', 'Male', 3)
insert into Employee values(2, 'Mike', 'Male', 2)
insert into Employee values(3, 'Pam', 'Female', 1)
insert into Employee values(4, 'Todd', 'Male', 4)
insert into Employee values(5, 'Sara', 'Female', 1)
insert into Employee values(6, 'Ben', 'Male', 3)

create view vEmployeeDetails
as
select Employee.Id, Name, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails
insert into vEmployeeDetails values(7, 'valarie', 'Female', 'IT')

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int

	select @DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted.DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiserror('invalid department name. statement terminated',16,1)
		return
	end
	---raiserror funk
	--selle eesmärk on tuua välja veateade, kui DepartmentName veerus ei ole Väärtust
	--ja ei klapi uue sisestatud väärtusega
	--esimene on parameeter ja veateate sisu, teine on veataseme nr (nr 16 tähendab
	--üldiseid vigu) ja kolmas on olek


	insert into dbo.Employee(Id,Name,Gender,DepartmentId)
	select Id, Name, Gender, @DeptId
	from inserted
end

insert into vEmployeeDetails values(7, 'valarie', 'Female', 'IT')

--uuendame andmeid
update vEmployeeDetails
set Name = 'Johny', DepartmentName = 'IT'
where id = 1
--ei saa uuendada andmeid kuna mitu tabelit on sellest mõjutatud

update vEmployeeDetails
set DepartmentName = 'IT'
where Id = 1

select * from vEmployeeDetails

--instead of Update trigger
create trigger tr_vEmployeeDetails_InsteadOfUpdate
on vEmployeeDetails
instead of update
as begin

	if(update(Id))
	begin
		raiserror('Id cannot be changed', 16, 1)
		return
	end

	if(update(DepartmentName))
	begin
		declare @DeptId int
		select @DeptId = Department.Id
		from Department
		join inserted
		on inserted.DepartmentName = Department.DepartmentName

		if(@DeptId is null)
		begin
			raiserror('Invalid Department Name', 16, 1)
			return
		end

		update Employee set DepartmentId = @DeptId
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Gender))
	begin
		update Employee set Gender = inserted.Gender
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end

	if(update(Name))
	begin
		update Employee set Name = inserted.Name
		from inserted
		join Employee
		on Employee.Id = inserted.id
	end
end

--uuendame andmeid, kasutada vEmployeeDetails
--uuendada seal kus Id on 1
update Employee set Name = 'John123', Gender = 'male', DepartmentId = 3
where id = 1
	
select * from vEmployeeDetail

create view vEmployeeCount
as
select DepartmentId, DepartmentName, count(*) as TotalEmployees
from Employee
join Department
on Employee.DepartmentId = Department.Id
group by DepartmentName, DepartmentId

select * from vEmployeeCount

select * from vEmployeeCount where TotalEmployees > 1
	
select DepartmentName, TotalEmployees from vEmployeeCount
where TotalEmployees >= 2

select departmentName, DepartmentId, count(*) as totalEmployees
into #TempEmployeeCount
from Employee
join Department
on Employee.DepartmentId = Department.id
group by DepartmentName, DepartmentId

select * from #TempEmployeeCount

-- läbi ajutise tabeli saab samu andmeid vaadata, kui seal on info olemas
select DepartmentName, TotalEmployees from #TempEmployeeCount
where TotalEmployees >= 2

--tuleb teha trigger nimega trEmployeesDetails_InsteadOfDelete
--ja kasutada vEmployeesDetails
--trigeri tüüp on instead of delete

create trigger trEmployeesDetails_InsteadOfDelete
on vEmployeeDetails
instead of delete
as begin
	delete Employee
	from Employee
	join deleted
	on Employee.Id = deleted.Id
end

delete from vEmployeeDetails where id = 7

-- cte e common table expression
--cte näide
with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as 
	(
	select DepartmentName, DepartmentId, count(*) as totalEmployees
	from Employee
	join Department
	on Employee.departmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2

--ct-d võivad sarnaneda temp tabeliga
--sarnane päritud tabelile ja ei ole salvestatud objektina
--ning kestab päringu ulatuses

--Päritud tabel
select DepartmentName, TotalEmployees
from
(
	select DepartmentName, DepartmentId, count(*) as totalEmployees
	from Employee
	join Department
	on Employee.departmentId = Department.Id
	group by DepartmentName, DepartmentId
)
as EmployeeCount
where totalEmployees >= 2

with EmployeeCountBy_Payroll_It_Dept(DepartmentName, Total)
as
(
	select DepartmentName, count(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmetId = Department.Id
	where DepartmentName in ('Payroll', 'IT')
	Group by DepartmentName
),
EmployeeCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
	select DepartmentName, count(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmetId = Department.Id
	Group by DepartmentName
)
--kui on kaks cte-d, siis unioni abil ühendab päringu
select * from EmployeeCountBy_Payroll_It_Dept
union
select * from EmployeeCountBy_HR_Admin_Dept

--teha cte päribg nimega EmployeeCount
--järjestakse DepartmentName järgi ära

with EmployeeCount(DepartmentId, totalEmployees)
as
(
	select DepartmentId, count(*) as TotalEmployees
	from Employee
	group by DepartmentId
)
--select 'hello'
---peale cte-d peab kohe tulema select, insert, update või delete
---kui proovida midagi muud siis tuleb veateade
select DepartmentName
From Department
join Employee
on Department.Id = Employee.DepartmentId
order by DepartmentName


with Employees_Name_Gender
as
(
	select id, Name, Gender from Employees
)
select * from Employees_Name_Gender

with EmployeesByDepartment
as
(
	select Employee.Id, Employee.Name, DepartmentName
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
)
select * from EmployeesByDepartment

with EmployeesByDepartment
as
(
	select Employee.Id, Employee.Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male' where Id = 1

with EmployeesByDepartment
as
(
	select Employee.Id, Employee.Name, Gender, DepartmentName
	from Employee
	join Department
	on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Female', DepartmentName = 'Payroll' where Id = 1
--ei luba mitmes tabelis korraga andmeid muuta, kui on tegemist cte-ga

---kokkuvõte CTE-st
-- 1. kui cte baseerub ühel tabelil, siis uuendus töötab
-- 2. kui cte baseerub mitmele tabelil, siis tuleb veateade
-- 3. kui cte baseerub mitmele tabelil ja tahame muuta ainult ühte tebelit,
--siis uuendus saab tehtud

-- korduv cte
---cte, mis iseendale viitab, kutsutakse korduvaks cte-ks
--kui tahad andmeid näidata hierarhiliselt
create table Employee
(
	EmployeeId int primary key,
	Name nvarchar(20),
	ManagerId int
)

insert into Employee values (1, 'Tom', 2) 
insert into Employee values (2, 'Josh', null)
insert into Employee values (3, 'Mike', 2)
insert into Employee values (4, 'John', 3)
insert into Employee values (5, 'Pam', 1)
insert into Employee values (6, 'Mary', 3)
insert into Employee values (7, 'James', 1) 
insert into Employee values (8, 'Sam', 5)
insert into Employee values (9, 'Simon', 1)

select Emp.Name as [Employee Name],
isnull (Manager.Name, 'Super Boss') as [Manager Name]
from dbo.Employee Emp
left join Employee Manager
on Emp.ManagerId = Manager.EmployeeId

with EmployeeCTE(Id, Name, ManagerId, [level])
as 
(
	select Employee.EmployeeId, Name, ManagerId, 1
	from Employee
	where ManagerId is null

	union all
	
	select Employee.EmployeeId, Employee.Name, Employee.ManagerId, 
	EmployeeCTE.[level] + 1
	from Employee
	join EmployeeCTE 
	on Employee.ManagerId = EmployeeCTE.Id
)
select EmpCTE.Name as [Employee Name],
isnull (MgrCTE.Name, 'Super Boss') as [Manager Name],
EmpCTE.Level as [Boss Level]
from EmployeeCTE EmpCTE
left join EmployeeCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.Id

---PIVOT

create table Sales
(
	SalesAgent nvarchar(20),
	SalesCountry nvarchar(20),
	SalesAmount int
)

insert into Sales values ('Tom', 'UK', 200)
insert into Sales values ('John', 'US', 180)
insert into Sales values ('John', 'UK', 260)
insert into Sales values ('David', 'India', 450)
insert into Sales values ('Tom', 'India', 350)
insert into Sales values ('David', 'US', 200)
insert into Sales values ('Tom', 'US', 130)
insert into Sales values ('John', 'India', 540)
insert into Sales values ('John', 'UK', 120)
insert into Sales values ('David', 'UK', 220)
insert into Sales values ('John', 'UK', 420)
insert into Sales values ('David', 'US', 320)
insert into Sales values ('Tom', 'US', 340)
insert into Sales values ('Tom', 'UK', 200)
insert into Sales values ('John', 'India', 200)
insert into Sales values ('David', 'India', 230)
insert into Sales values ('David', 'India', 280)
insert into Sales values ('Tom', 'UK', 480)
insert into Sales values ('John', 'UK', 360)
insert into Sales values ('David', 'UK', 140)

----
select SalesCountry, SalesAgent, sum(SalesAmount) as TotalSales
from Sales
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

--- kasutada pivotit, et saada sama tulemus nagu ülemises päringus

select SalesAgent, India, US, UK
from Sales
as SourceTable
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable

--päring muudab unikaalsete väärtust (India, US, UK) SalesCountry veerus
-- omaette veergudeks koos veergude SalesAmount liitmisega.

Create table SalesWithId
(
Id int primary key,
SalesAgent nvarchar(20),
SalesCountry nvarchar (20),
SalesAmount int
)

insert into SalesWithId values (1,'Tom', 'UK', 200)
insert into SalesWithId values (2,'John', 'US', 180)
insert into SalesWithId values (3,'John', 'UK', 260)
insert into SalesWithId values (4,'David', 'India', 450)
insert into SalesWithId values (5,'Tom', 'India', 350)
insert into SalesWithId values (6,'David', 'US', 200)
insert into SalesWithId values (7,'Tom', 'US', 130)
insert into SalesWithId values (8,'John', 'India', 540)
insert into SalesWithId values (9,'John', 'UK', 120)
insert into SalesWithId values (10,'David', 'UK', 220)
insert into SalesWithId values (11,'John', 'UK', 420)
insert into SalesWithId values (12,'David', 'US', 320)
insert into SalesWithId values (13,'Tom', 'US', 340)
insert into SalesWithId values (14,'Tom', 'UK', 660)
insert into SalesWithId values (15,'John', 'India', 430)
insert into SalesWithId values (16,'David', 'India', 230)
insert into SalesWithId values (17,'David', 'India', 280)
insert into SalesWithId values (18,'Tom', 'UK', 480)
insert into SalesWithId values (19,'John', 'UK', 360)
insert into SalesWithId values (20,'David', 'UK', 140)

select SalesAgent, India, US, UK
from SalesWithId
as SourceTable
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable
-- põhjuseks on Id veeru olemasolu SalesWithId, mida võetakse arvesse
-- pööramise 

select SalesAgent, India, US, UK
from
(
	select SalesAgent, SalesCountry, SalesAmount
	from SalesWithId
)
as SourceTable
pivot
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable

--transaction
-- transaction jälgib järgmisi samme:
-- 1. selle algus
-- 2. käivitab db käske
-- 3. kontrollib vigu. kui on viga siis taastab algse oleku

create table MailingAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(20),
	StreetAddress nvarchar(20),
	City nvarchar(20),
	PostalCode nvarchar(20)
)

insert into MailingAddress
values (1, 101, '#10', 'King Street','Londoon', 'CR27DW')

create table PhysicalAddress
(
	Id int not null primary key,
	EmployeeNumber int,
	HouseNumber nvarchar(20),
	StreetAddress nvarchar(20),
	City nvarchar(20),
	PostalCode nvarchar(20)
)

insert into PhysicalAddress
values (1, 101, '#10', 'King Street','Londoon', 'CR27DW')

create proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

-- käivitame spUpdate Address stored procedure-i
spUpdateAddress

select * From MailingAddress
select * From PhysicalAddress

--kui teine uuendus ei lähe läbi, siis esimene ei lähe ka läbi
-- kõik uuendused peavad läbi minema

--- transcation ACID test

--edukas transaction peab läbima ACID testi:
-- a - atomic e aatomlikus
-- c - consistent e järjepidev
-- i - isoation
-- d - durable

-- Atomic - kõik tehingud transactionis on kas edukalt täidetud või need
-- lükatakse tagasi. Nt mõlemad käsud peaksid alati õnnestuma. andmebaas
-- teeb sellisel juhul: võtab esimese update tagasi ja veeretab selle algasenisse
-- e taastab algsed andmed

--consistent - kõik transactioni puudutavad andmed jäetakse loogiliselt
--järelepide

--isolated - transaction peab andmeid mõjutama, sekkumata teistesse
--sammaaegsetesse transacto


--subqueries e alamkäsud
--alamkäsud on sql-i käsud, mis on pesastatud
create table product
(
Id int primary key,
Name nvarchar(20),
Description nvarchar(250)
)

create table ProductSales
(
Id int primary key identity,
ProductId int foreign key references product(Id),
UnitPrice Int,
QuantitySold int
)

insert into product values (1, 'tv', '52 inch black color lcd tv')
insert into product values (2, 'laptop', 'very thin black color laptop')
insert into product values (3, 'desktop', 'hp high preformance desktop')

insert into ProductSales values(3,450,5)
insert into ProductSales values(2,250,7)
insert into ProductSales values(3,450,4)
insert into ProductSales values(3,450,9)

select * from product
select * from ProductSales

select id, Name, Description
from product
where Id not in (select productId from ProductSales)
--sulgude sees on subquery, mis kõik productid-d productSales tabelist

--enamus juhtudel saab subquerit asendada JOIN-iga
select product.Id, product.Name, description
from product
left join ProductSales
on product.Id = ProductSales.ProductId
where ProductSales.ProductId is null

select name,
(select sum(QuantitySold) from ProductSales where ProductId = product.Id) as
[Total Quantity]
from product
order by Name

select product.Id, sum(QuantitySold) as [Total Quantity]
from product
left join ProductSales
on product.Id = ProductSales.ProductId 
group by Name
order by name

--subqueryt saab subquery sisse panna
--subquery on alati sulgudes ja neid nimetatakse

truncate table product
truncate table productSales

select * from product
select * from ProductSales

create table Product
(
Id int identity primary key,
Name nvarchar(50),
Description nvarchar(250)
)

create table ProductSales
(
Id int primary key identity,
ProductId int foreign key references Product(Id),
UnitPrice int,
QuantitySold int
)

--sisestame näidisandmed product tabelisse
declare @Id int
set @Id = 1
while(@Id <= 3000000)
begin
	insert into product
	values ('product - ' + cast(@Id as nvarchar(20)),
	'description for product - ' + cast(@Id as nvarchar(20)))

	print @Id
	set @Id = @Id + 1
end

declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int

declare @LowerLimitForProductId int
declare @UpperLimitForProductId int 

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000 

declare @LowerLimitForUnitPrice int
declare @UpperLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100 

declare @LowerLimitForQualitySold int
declare @UpperLimitForQualitySold int

set @LowerLimitForQualitySold = 1
set @UpperLimitForQualitySold = 10

declare @Counter int
set @Counter = 1

while(@Counter <= 4500000)
begin
	set @RandomProductId = ROUND(((@UpperLimitForProductId - 
	@LowerLimitForProductId) * rand () + @LowerLimitForProductId), 0)

	set @RandomUnitPrice = ROUND(((@UpperLimitForUnitPrice - 
	@LowerLimitForUnitPrice) * rand () + @LowerLimitForUnitPrice), 0)
	
	set @RandomQuantitySold = ROUND(((@UpperLimitForUnitPrice - 
	@LowerLimitForUnitPrice) * rand () + @LowerLimitForUnitPrice), 0)

	insert into ProductSales
	values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	print @Counter
	set @Counter = @Counter + 1
end



