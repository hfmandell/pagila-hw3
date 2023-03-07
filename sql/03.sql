/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

WITH payment_by_addr AS (
    SELECT address_id, payment.amount FROM customer
    JOIN payment ON payment.customer_id=customer.customer_id
    )

SELECT country.country, sum(payment_by_addr.amount) AS total_payments
FROM country
JOIN city ON city.country_id=country.country_id
JOIN address ON address.city_id=city.city_id
JOIN payment_by_addr ON payment_by_addr.address_id=address.address_id
GROUP BY country.country
ORDER BY total_payments DESC, country.country;
