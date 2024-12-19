--1. Создать базу данных.
create database Book;-- название базы данных

--2. Создать схему.
create schema Schema_1;-- название схемы

--3. Переключение между схемами.
set search path to --название схемы

--4. Создать таблицу авторов песен с полями id, full_name, nick_name, born_date.
create table mus(
id serial primary key,-- первичный ключ
full_name varchar(100) not null,--varchar длина строки N - число символов
nick_name varchar(20),
born_date date not null--date - дата без времени
);

select * from mus;

--5. Внесение данных в таблицу.
insert into mus (full_name, nick_name, born_date)--insert внесение новых данных, into сохранение результата
values ('Тилль Линдесманн', 'Rammstein', '05.01.1994'), --внесение данных в таблицу
	   ('Майкл Джексон', 'Maikl', '31.12.2006');
	  
select * from mus;

--6. Добавить поле репертуар.
alter table mus add column rep varchar(50);--alter table изменение таблицы (столбца), add column добавление столбца

select * from mus;

--7. Дозаполнить таблицу.
update mus--обновление данных
set rep = 'РОК'--set поле, rep = 'РОК' выражение
where id = 1;
update mus
set rep = 'РОК'
where id = 2;

select * from mus;

--8. Удалить строку.
delete from mus--удаление строк
where id = 2;

select * from mus;

drop table mus_1 ;
drop schema schema_1;
drop database Book;






