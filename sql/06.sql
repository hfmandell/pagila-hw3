/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

WITH films_with_rb AS (
    SELECT film.film_id, actor.actor_id
    FROM film
    JOIN film_actor on film_actor.film_id = film.film_id
    JOIN actor on actor.actor_id = film_actor.actor_id
    WHERE actor.first_name = 'RUSSELL' AND
    actor.last_name = 'BACALL'
)

SELECT DISTINCT first_name || ' ' || last_name AS "Actor Name"
FROM (
        SELECT actor_id
        FROM film_actor
        WHERE film_id IN (
                SELECT film_id FROM films_with_rb
                )
        AND actor_id NOT IN (
                SELECT actor_id FROM films_with_rb
                )
        ) t
JOIN actor USING(actor_id) ORDER BY "Actor Name";
