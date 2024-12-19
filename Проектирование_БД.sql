--1. Проектирование баз данных
--1.1 Создание таблиц и внесение информации в них.
create table lang (lang_id serial primary key, lang_name varchar (50) not null);
insert into lang (lang_name) values ('Русский'), ('Китайский'), ('Английский');
select * from lang;
create table ngroup (ngroup_id serial primary key, ngroup_name varchar (50) not null);
insert into ngroup (ngroup_name) values ('Русские'), ('Казахи'), ('Французы'), ('Немцы'), ('Американцы'), ('Китайцы');
select * from ngroup;
create table cantr (cantr_id serial primary key, cantr_name varchar (50) not null);
insert into cantr (cantr_name) 
values ('Россия'), ('Англия'), ('Китай'), ('Германия'), ('США'), ('Франция');
select * from cantr;
--1.2 Связующие таблицы.
create table lang_ngroup (
lang_id int not null references lang(lang_id),
ngroup_id int not null references ngroup(ngroup_id),
primary key (lang_id, ngroup_id)
);
create table ngroup_cantr (
ngroup_id int not null references ngroup(ngroup_id),
cantr_id int not null references cantr(cantr_id),
primary key (ngroup_id, cantr_id)
);


--2. Сколько фильмов в каждой категории было арендовано, а также общую сумму платежей для каждой категории.
select 
	c."name" as category_name,
	count(distinct f.film_id) as total_rented_films,
	sum(p.amount) as total_payments
from category c 
join film_category fc on c.category_id = fc.category_id 
join film f on f.film_id = fc.film_id 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
join payment p on r.rental_id = p.rental_id 
group by c."name" 
order by total_payments desc;

select 
	c."name" as category_name,
	(select count( * )
	from film_category fc
	where fc.category_id = c.category_id) as total_rented_films,
	(select sum(p.amount)
	from payment p 
	join rental r on p.rental_id = r.rental_id
	join inventory i on r.inventory_id = i.inventory_id
	join film_category fc on i.film_id = fc.film_id
	where fc.category_id = c.category_id) as total_payments
from category c 
order by total_payments desc;

--Выбрать всех клиентов, которые живут в California.
select c.first_name, c.last_name, a.address, c2.city
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on c2.city_id = a.city_id 
where a.district = 'California';

--Выбрать всех клиентов, которые живут в California (сложный запрос).
select c.first_name, c.last_name, addr.address, addr.city
from customer c 
join (select a.address_id, a.address, c2.city
from address a 
join city c2 on c2.city_id = a.city_id 
where a.district = 'California'
) addr
on addr.address_id = c.address_id;