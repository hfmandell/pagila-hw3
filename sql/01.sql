/*
 * Compute the number of customers who live outside of the US.
 */

SELECT count(*) FROM customer
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
WHERE country.country_id != 103;
