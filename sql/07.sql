/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH films_with_rb AS (
    SELECT film.film_id, actor.actor_id
    FROM film
    JOIN film_actor on film_actor.film_id = film.film_id
    JOIN actor on actor.actor_id = film_actor.actor_id
    WHERE actor.first_name = 'RUSSELL' AND
    actor.last_name = 'BACALL'
),

one_degree_rb AS (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
                SELECT film_id FROM films_with_rb
                )
        AND actor_id NOT IN (
                SELECT actor_id FROM films_with_rb
                )
),

films_with_actors_with_rb AS (
    SELECT *
    FROM actor
    JOIN one_degree_rb USING(actor_id)
    WHERE actor_id IN (
        SELECT actor_id FROM one_degree_rb
        )
),

two_degree_rb AS (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
            SELECT film_id from films_with_actors_with_rb
        )
        AND actor_id NOT IN (SELECT actor_id FROM one_degree_rb)
        AND actor_id NOT IN (
            SELECT actor_id FROM films_with_rb
        )
)

SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
FROM two_degree_rb
JOIN actor USING(actor_id)
ORDER BY "Actor Name";
