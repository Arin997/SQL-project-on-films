First I created the tables in PGAdmin
then inserted all the values with the help of copy command

--1 Name of the actors of the films

select b.title, concat(a.first_name|| ' ' ||a.last_name) as Actor_name
from film as b
left join
film_actor as fa
on fa.film_id=b.film_id
left join
actor1 as a
on a.actor_id=fa.actor_id;

--2 All the drama category films

select f.title, c.name
from film as f
left join
film_category as fc
on f.film_id=fc.film_id
left join
category as c
on fc.category_id=c.category_id
where name='Drama';

--3 Wherever word drama is present in the film lists

select title
from film
where description like '%Drama%';

--4 All the name of the films where PENELOPE GUINESS has worked

select b.title
from film as b
left join
film_actor as fa
on fa.film_id=b.film_id
left join
actor1 as a
on a.actor_id=fa.actor_id
where a.actor_id=1;

--5 Name of the cities with the number of active customers

select c.city
from city as c
join
address as a
on c.city_id=a.city_id
join
customer as cu
on cu.address_id=a.address_id
where cu.active=1;

--6 Top 3 actors who have most appeared in the “Sci-Fi” category films

select concat(a.first_name|| ' ' ||a.last_name) as Actor_names, count(f.title)
from actor1 as a
join
film_actor as fa
on a.actor_id=fa.actor_id
join
film as f
on fa.film_id=f.film_id
join
film_category as fc
on f.film_id=fc.film_id
join
category as c
on fc.category_id=c.category_id
where c.name='Sci-Fi'
group by Actor_names
order by count(f.title) DESC
limit 3;

--7 Top 5 films which the customers are renting.

select f.title as name, count(c.customer_id) as total_customer
from customer as c
join
rental1 as r
on c.customer_id=r.customer_id
join
inventory as i
on r.inventory_id=i.inventory_id
join
film as f
on i.film_id=f.film_id
group by name
order by total_customer desc
limit 5;

--8 All the films done by each actors using string agg.

select concat(a.first_name|| ' ' ||a.last_name) as Actor_name, string_agg(f.title,', ')
from film as f
left join
film_actor as fa
on fa.film_id=f.film_id
left join
actor1 as a
on a.actor_id=fa.actor_id
group by Actor_name;

--9 The customers are spenting the most money in which store

select st.store_id, sum(p.amount)
from staff as s
inner join
store as st
on s.store_id=st.store_id
left join
payment as p
on s.staff_id=p.staff_id
group by st.store_id;

--10 Top 10 actors whose films are rented the most

select concat(a.first_name|| ' ' ||a.last_name) as Actor_name, count(r.rental_id) as No_of_times_rented
from actor1 as a
left join
film_actor as fa
on a.actor_id=fa.actor_id
left join
film as f
on fa.film_id=f.film_id
left join
inventory as i
on f.film_id=i.film_id
left join
rental1 as r
on i.inventory_id=r.inventory_id
group by Actor_name
order by No_of_times_rented DESC
limit 10;

--11 The top 10 countries where the customers rented the maximum time

select co.country, count(r.rental_id) as total_rental_ids
from country as co
join
city as c
on co.country_id=c.country_id
join
address as a
on c.city_id=a.city_id
join customer as cu
on a.address_id=cu.address_id
join
rental1 as r
on cu.customer_id=r.customer_id
group by co.country
order by total_rental_ids DESC
limit 10;
