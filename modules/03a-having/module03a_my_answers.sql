-- Module 03a — HAVING
-- Exercise 1: Moderately active customers

SELECT
    customer_id,
    COUNT(*) AS rental_count
FROM dbo.rental
GROUP BY customer_id
HAVING COUNT(*) > 10 AND COUNT(*) < 20
ORDER BY rental_count ASC;


-- Exercise 2: Customers with at least 5 rentals

SELECT
    customer_id,
    COUNT(*) AS rental_count
FROM dbo.rental
GROUP BY customer_id
HAVING COUNT(*) >= 5;


-- Exercise 3: High payment activity

SELECT
    customer_id,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_paid
FROM dbo.payment
GROUP BY customer_id
HAVING COUNT(*) >= 30
   AND SUM(amount) > 200
ORDER BY total_paid DESC;


-- Exercise 4: Actors with large filmographies

SELECT
    actor_id,
    COUNT(*) AS film_count
FROM dbo.film_actor
GROUP BY actor_id
HAVING COUNT(*) >= 35
ORDER BY film_count DESC;


-- Exercise 5: WHERE versus HAVING
-- Exclude adjustments of 1 or less before calculating totals.
-- Keep only customers whose remaining payments exceed 50.

SELECT
    customer_id,
    SUM(amount) AS total_paid
FROM dbo.payment
WHERE amount > 1
GROUP BY customer_id
HAVING SUM(amount) > 50;