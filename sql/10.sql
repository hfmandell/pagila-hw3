/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 * The query below computes the total amount that each customer has spent.
 * It needs to be modified so that the "percentile" column contains the customer's percentile, and then filtered so that only customers with percentile >= 90 are kept.
 *
 * Like the previous problem, this problem requires that you learn a new weird syntax: window functions.
 * There are many window functions in postgres, but for this assignment you'll want to use the ntile function (with parameter n=100).
 * See the following tutorials for a guide:
 * 1. https://www.postgresqltutorial.com/postgresql-ntile-function/
 * 2. https://www.postgresqltutorial.com/postgresql-window-function/
 */
WITH total_payments AS (
    SELECT
        customer_id,
        first_name || ' ' || last_name AS name,
        sum(amount) AS total_payment
    FROM customer
    JOIN payment USING (customer_id)
    GROUP BY customer_id,first_name,last_name
    ORDER BY total_payment DESC
),

percentiles AS (
    SELECT customer_id, name, total_payment, (NTILE(100) OVER(ORDER BY total_payment)) AS percentile
    FROM total_payments
    ORDER BY name
)

SELECT * FROM percentiles
WHERE percentile >= 90;
