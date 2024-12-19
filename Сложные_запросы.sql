--Вывести кол-во фильмов со стоимостью аренды за день, > чем среднее.
select count(film_id) 
from film f 
where f.rental_rate / f.rental_duration > (
	select avg(rental_rate / rental_duration)
	from film f);
	
--Вывести все фильмы с категорией начинающейся с "С".
select f.title , c."name" 
from film f 
join film_category fc on fc.film_id = f.film_id 
join category c on c.category_id = fc.category_id 
where c.category_id in (select c.category_id
	from category c
	where c."name" ilike 'c%');
	
--Оконная ф-ция
--Выведите таблицу с 3-мя полями: название фильма, имя актёра и кол-во фильмов, в которых он снимался.
select f.title, a.first_name, a.last_name, count(f.film_id) 
from film f 
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id 
group by f.title, a.first_name, a.last_name; 

select f.title, a.first_name, a.last_name, count(f.film_id) over (partition by a.actor_id) as count_film
from film f 
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id

--CTE Common Table Expression (Обобщенные табличные выражения).
--При помощи CTE вывести таблицу со следующим содержанием Фамилия и Имя сотрудника(staff) и кол-во прокатов (rental), которые он продал.
with cte as (
select concat(s.last_name, ' ', s.first_name) as st, r.rental_id, s.staff_id 
from staff s
join rental r on r.staff_id = s.staff_id)
select cte.st, count(cte.rental_id)
from cte
group by cte.staff_id, cte.st;

--Представления
--Создайте view с колонками клиент (ФИО, email) и названием фильмов title, которые он брал в прoкат последними
create view task as
with cte as (
select r.*,
row_number() over (partition by r.customer_id order by r.rental_date desc)
from rental r 
)
select concat(c.last_name, ' ', c.first_name), c.email, f.title 
from cte
join customer c on c.customer_id = cte.customer_id
join inventory i on i.inventory_id = cte.inventory_id
join film f on f.film_id = i.film_id
where cte.row_number = 1;

select *
from task;