-- 1. Write a query to display for each store its store ID, city, and country.
use sakila;
select store.store_id as store_id, city.city, country.country from store
join address a on store.address_id = a.address_id
join city on a.city_id = city.city_id
join country on city.country_id = country.country_id
group by store.store_id;
-- 2. Write a query to display how much business, in dollars, each store brought in.
select store.store_id, sum(p.amount) as income from store 
join staff on store.store_id = staff.store_id
join payment p on p.staff_id = staff.staff_id
group by store.store_id;
-- 3. Which film categories are longest?
select c.name as category_name,
avg(f.length) as avg_film_duration from film_category fc
join category c on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name order by avg(f.length) desc limit 1;
-- 4. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_date) as freq_rented from film f
join inventory i on f.film_id = i.film_id
join rental r on r.inventory_id = i.inventory_id
group by f.title order by count(r.rental_date) desc;
-- 5. List the top five genres in gross revenue in descending order.
select cat.name as film_category, sum(p.amount) as revenue_gross from category cat
join film_category fc on fc.category_id = cat.category_id
join inventory i on i.film_id = fc.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by cat.name order by sum(p.amount) desc limit 5;
-- 6. Is "Academy Dinosaur" available for rent from Store 1?
select f.title, s.store_id, count(r.rental_date)-count(r.return_date)
as num_rented from film f
join inventory i on i.film_id = f.film_id 
join store s on s.store_id = i.store_id
join rental r on r.inventory_id = i.inventory_id
where f.title = "Academy Dinosaur"
group by s.store_id;
-- 7. Get all pairs of actors that worked together.
select concat(a1.first_name," ",a1.last_name) as actor_1, 
concat(a2.first_name," ",a2.last_name) as actor_2, 
f.title as movie_title, f.release_year from film_actor fa1
join film_actor fa2 on fa1.film_id = fa2.film_id and fa1.actor_id < fa2.actor_id
join actor a1 on fa1.actor_id = a1.actor_id
join actor a2 on fa2.actor_id = a2.actor_id
join film f on fa1.film_id = f.film_id;






-- trying to do number 6
select f.title, s.store_id, count(r.rental_date)-count(r.return_date)
as available_in_store from film f
join inventory i on i.film_id = f.film_id 
join store s on s.store_id = i.store_id
join rental r on r.inventory_id = i.inventory_id
where f.title = "Academy Dinosaur"
group by s.store_id;
select f.title, i.store_id, count(i.film_id) as total_stock,
count(i.film_id)-(count(r.rental_date)-count(r.return_date)) as available
from inventory i
join film f on f.film_id = i.film_id
join rental r on r.inventory_id = i.inventory_id
where f.title = "Academy Dinosaur"
group by i.store_id, i.film_id;
select * from inventory;
select f.film_id, f.title from film f
join inventory i on i.film_id = f.film_id
where f.title = "Academy Dinosaur";
-- 8. Get all pairs of customers that have rented the same film more than 3 times.
-- 9. For each film, list actor that has acted in more films.