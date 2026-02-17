--teeme andmebaasi e db
--create database IKT25tar

-- andmebaasi valimine
--use IKT25tar
use master
--andmekastutamine koodiga
--otsida kood ülesse
drop database IKT25tar

--teeme uuesti andmebaasi IKT25tar
create database IKT25tar
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
