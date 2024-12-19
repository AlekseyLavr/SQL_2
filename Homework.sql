--1. Перечислить все таблицы и первичные ключи в базе данных. Формат решения в виде таблицы: | Название таблицы | Первичный ключ | 
select tc.table_name, kc.column_name as PK_name
from
    information_schema.table_constraints tc,
    information_schema.key_column_usage kc
where
    tc.constraint_type = 'PRIMARY KEY'
    and kc.table_name = tc.table_name and kc.table_schema = tc.table_schema
    and kc.constraint_name = tc.constraint_name
order by tc.table_name;

--2. Вывести всех неактивных покупателей
select customer_id, first_name, last_name, active
from customer c 
where active = 0;

--3. Вывести все фильмы, выпущенные в 2006 году
select film_id, title, release_year
from film f 
where release_year = 2006;

--4. Вывести 10 последних платежей за прокат фильмов.
select payment_id, customer_id, rental_id, amount, payment_date
from payment p 
order by payment_date desc 
limit 10;

--5. Выведите магазины, имеющие больше 300-от покупателей
select store_id 
from customer c 
group by store_id 
having count(customer_id) > 300;

--6. Выведите у каждого покупателя город в котором он живет
select c.customer_id, c2.city
from customer c 
join address a on a.address_id = c.address_id 
join city c2 on a.city_id = c2.city_id;

--7. Выведите ФИО сотрудников и города магазинов, имеющих больше 300-от покупателей
select staff_id, first_name, last_name, city, count(distinct customer_id) as unic_customer 
from payment p 
join staff s using (staff_id)
join address a using (address_id)
join city c using (city_id)
join store s2 using (store_id)
group by staff_id , city 
having count(distinct customer_id) > 300;

--8. Выведите количество актеров, снимавшихся в фильмах, которые сдаются в аренду за 2,99
select film_id, title, count(actor_id) as actors_count
from film_actor fa
inner join film f using (film_id)
group by film_id 
having rental_rate = 2.99
order by title;