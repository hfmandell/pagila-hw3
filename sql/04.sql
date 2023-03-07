/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

WITH c_actors AS (
    SELECT actor.first_name, actor.last_name, actor.actor_id
    FROM actor, film, film_actor, film_category, category
    WHERE actor.actor_id = film_actor.actor_id AND
        film_actor.film_id = film.film_id AND
        film.film_id = film_category.film_id AND
        film_category.category_id = category.category_id AND
        category.name = 'Children'
    ORDER BY last_name, first_name
    ),

h_actors AS (
    SELECT actor.first_name, actor.last_name, actor.actor_id
    FROM actor, film, film_actor, film_category, category
    WHERE actor.actor_id = film_actor.actor_id AND
        film_actor.film_id = film.film_id AND
        film.film_id = film_category.film_id AND
        film_category.category_id = category.category_id AND
        category.name = 'Horror'
    ORDER BY last_name, first_name
    )

SELECT first_name, last_name
FROM c_actors
EXCEPT
SELECT first_name, last_name
FROM h_actors
ORDER BY last_name, first_name;
