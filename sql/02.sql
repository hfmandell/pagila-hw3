/*
 * Compute the country with the most customers in it. 
 */

WITH customer_count_by_country AS (
        SELECT country, count(*) FROM country
        JOIN city ON city.country_id=country.country_id
        JOIN address ON address.city_id=city.city_id
        JOIN customer ON customer.address_id = address.address_id
        GROUP by country
        ORDER by count(*) DESC)

SELECT country FROM customer_count_by_country WHERE "count" = (SELECT MAX("count") FROM customer_count_by_country);
