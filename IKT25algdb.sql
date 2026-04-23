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
	select * from #Tempable
	from inserted

	--käib läbi kõik andmed temp tebelist
	while (exists(select Id From #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimene rea andmed temp tabel-st
		select top 1 @Id, @NewGender = Gender, @NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewManagerId = ManagerId, @NewFirstName = FirstName, @NewMiddleName = MiddleName,
		@NewLastName = LastName, @NewEmail = Email
		from #TempTable
		-- võtab vanad andmed kustudab tabelist
		select @OldGender = Gender, @OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldManagerId = ManagerId, @OldFirstName = FirstName, @OldMiddleName = MiddleName,
		@OldLastName = LastName, @OldEmail = Email 
		from deleted where Id @Id







