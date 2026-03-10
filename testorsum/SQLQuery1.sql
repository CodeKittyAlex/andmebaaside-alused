--1
create database test

create table RaamatuSüsteem
(
Id int not null primary key,
pealkiri nvarchar(100),
autor nvarchar(100),
aasta int,
hind decimal(5,2)
)

insert into RaamatuSüsteem(Id, pealkiri, autor, aasta, hind)
values
(1, 'got', 'JR tolkein',2010,20.99),
(2, 'MyCemicalRomance','bob',2020 ,19.99),
(3, 'bible','satan',1985 ,10.99),
(4, 'mehiko','jose',2008 ,10.99),
(5, 'MyLife','tina',2005 ,32.99),
(6, '1984','georg',1999 ,18.99)

update RaamatuSüsteem
set hind = 17.99
where Id = 2

update RaamatuSüsteem
set autor = 'bob'
where Id = 5

alter table raamatuSüsteem
add laos_kogus int

update RaamatuSüsteem
set laos_kogus = 25
where Id = 1

update RaamatuSüsteem
set laos_kogus = 25
where Id = 3

update RaamatuSüsteem
set laos_kogus = 25
where Id = 6

alter table RaamatuSüsteem
drop column hind 

delete from RaamatuSüsteem where Id = 5
