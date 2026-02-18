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
set Age = 159
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

